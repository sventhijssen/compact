import os
import shutil
import subprocess
import time

from pathlib import Path

import config
from IOConverter import IOConverter
from IOType import IOType
from LatexGenerator import LatexGenerator
from MappingMethod import MappingMethod
from MinimumVertexCover import MinimumVertexCover
from SBDDParser import SBDDParser
from SymmetricDifference import SymmetricDistance
from VerilogParser import VerilogParser


class SBDD(MappingMethod):

    def __init__(self):
        super(SBDD, self).__init__()

    def map(self, file_path, logger=None, model_checking=False, draw=False, clean=True, verbose=False):

        print("SBDD")

        total_start_time = time.time()

        [_, file] = file_path.split(os.path.sep)

        [file_name, _] = file.split('.')

        benchmark_path = config.root.joinpath('Benchmarks')
        sbdd_path = config.root.joinpath('SBDD')
        abc_path = config.root.joinpath('ABC')

        # Convert input (Verilog, blif, PLA) to PLA
        ioc = IOConverter(abc_path, benchmark_path, sbdd_path)
        pla_file = file_name + '_out.pla'
        ioc.convert(file, pla_file, IOType.PLA)

        # Strip comments from PLA file
        # Based on: https://unix.stackexchange.com/questions/157328/how-can-i-remove-all-comments-from-a-file
        # Author: Joseph R.
        # Published on: September 26, 2014
        # Accessed on: June 16, 2020
        process = subprocess.Popen(['bash'], cwd=str(sbdd_path), stdin=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
        process.communicate(str.encode("sed '/^[[:blank:]]*#/d;s/#.*//' {} > {}".format(pla_file, 'stripped_' + pla_file)))

        # Move and remove
        # process = subprocess.Popen(['bash'], cwd=str(sbdd_path), stdin=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
        # process.communicate(str.encode('mv {} {}'.format('stripped_' + pla_file, pla_file)))

        shutil.copy2(str(sbdd_path.joinpath('stripped_' + pla_file)), str(sbdd_path.joinpath(pla_file)))
        os.remove(str(sbdd_path.joinpath('stripped_' + pla_file)))

        # Construct SBDD from PLA file
        sbdd_cmd = config.sbdd_cmd.copy()
        sbdd_cmd[-1] += ' {}'.format(pla_file)
        subprocess.Popen(sbdd_cmd, cwd=str(sbdd_path), stdin=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)

        # Wait for sbdd.dot to be created
        while not config.root.joinpath('SBDD').joinpath('sbdd.dot').is_file():
            pass
        # Delay with 2 seconds
        # The file sbdd.dot might have been created but it takes some time before the content is written
        time.sleep(1)

        # Labeling method
        mvc = MinimumVertexCover()

        # Parse the SBDD
        sdp = SBDDParser()
        sdp.read_file(sbdd_path.joinpath('sbdd.dot'), sbdd_path.joinpath('sbdd.txt'))
        [crossbar, rows, columns, total_nr_variables, nr_vertices, sbdd_output_variables, sbdd_input_variables] = sdp.parse(mvc)

        total_time = time.time() - total_start_time

        print("Benchmark: " + file_name)
        print("Nr of inputs: " + str(len(sbdd_input_variables)))
        print("Nr of outputs: " + str(len(sbdd_output_variables)))
        print("Total nr of vertices: " + str(nr_vertices))
        print("Total nr of variables: " + str(total_nr_variables))
        print("Total nr of rows: " + str(rows-1-len(sbdd_output_variables)))
        print("Total nr of columns: " + str(columns-1-len(sbdd_output_variables)))
        print("Area: " + str((rows-1-len(sbdd_output_variables)) * (columns-1-len(sbdd_output_variables))))
        print("Total time: " + str(total_time) + "s")

        if config.log:
            config.log_file.approach = "SBDD"
            config.log_file.benchmark = file_name
            config.log_file.input_variables = len(sbdd_input_variables)
            config.log_file.output_variables = len(sbdd_output_variables)
            config.log_file.vertices = nr_vertices
            config.log_file.rows = rows - 1 - len(sbdd_output_variables)
            config.log_file.columns = columns - 1 - len(sbdd_output_variables)
            config.log_file.cumulative_area = (rows - 1 - len(sbdd_output_variables)) * (columns - 1 - len(sbdd_output_variables))
            config.log_file.variables = total_nr_variables
            config.log_file.time = total_time
            config.log_file.write()

        if model_checking:
            print("-- Convert PLA to Verilog")

            # Convert PLA file to Verilog
            ioc = IOConverter(abc_path, sbdd_path, sbdd_path)
            pla_file = file_name + '_out.pla'
            verilog_file = file_name + '.v'
            ioc.convert(pla_file, verilog_file, IOType.VERILOG)

            print("-- Parse Verilog")

            vp = VerilogParser()
            vp.read_file(str(sbdd_path) + os.path.sep + verilog_file)
            [_, input_variables, verilog_output_variables, truth_table] = vp.parse(model_checking)

            print("-- Model checking")

            permutation = [verilog_output_variables.index(var) for var in sbdd_output_variables]
            offset = len(input_variables)
            permutation_truth_table = [None for i in range(len(truth_table))]
            for r in range(len(truth_table)):
                row = truth_table[r]
                permutation_row = [None for i in range(len(row))]
                for c in range(len(row)):
                    if c < offset:
                        permutation_row[c] = row[c]
                    else:
                        permutation_row[c] = row[offset + permutation[c - offset]]
                permutation_truth_table[r] = permutation_row

            # Check correctness
            sd = SymmetricDistance()
            total_error = sd.is_valid(rows, columns, crossbar, input_variables, permutation_truth_table)
            print("Total error label design: " + str(total_error))

        if draw:
            print("-- Generating Latex file")
            # Generate Latex file
            lg = LatexGenerator()
            lg.draw_design('sbdd.tex', rows, columns, crossbar)

        if config.clean:
            files = [sbdd_path.joinpath('sbdd.dot'),
                     sbdd_path.joinpath('sbdd.txt'),
                     sbdd_path.joinpath(pla_file),
                     abc_path.joinpath(file),
                     abc_path.joinpath(pla_file)]
            if draw:
                files.extend([Path.cwd().joinpath('sbdd.aux'), Path.cwd().joinpath('sbdd.log'), Path.cwd().joinpath('sbdd.tex')])
            SBDD.clean(files)
        print()

        return rows, columns, crossbar
