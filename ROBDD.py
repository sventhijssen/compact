import os
import time
import random

import config
from CrossbarMerger import CrossbarMerger
from pathlib import Path

import subprocess

from LTSpiceSimulator import LTSpiceSimulator
from LabelingDotParser import LabelingDotParser
from LatexGenerator import LatexGenerator
from MappingMethod import MappingMethod
from MinimumVertexCover import MinimumVertexCover
from SymmetricDifference import SymmetricDistance
from VerilogConverter import VerilogConverter
from VerilogParser import VerilogParser


class ROBDD(MappingMethod):

    def __init__(self):
        super(ROBDD, self).__init__()

    def map(self, file_path, logger=None, model_checking=False, draw=False, clean=True, verbose=False):

        print("ROBDD")

        total_start_time = time.time()

        [_, file] = file_path.split(os.path.sep)

        [file_name, _] = file.split('.')

        benchmark_path = config.root.joinpath('Benchmarks')
        abc_path = config.root.joinpath('ABC')
        verilog_path = config.root.joinpath('ABC')
        dot_path = config.root.joinpath('ABC')

        vc = VerilogConverter(benchmark_path, abc_path)
        verilog_file = file_name + '_out.v'
        vc.convert(file, verilog_file)

        vp = VerilogParser()
        vp.read_file(verilog_path.joinpath(verilog_file))
        [bdds, all_input_variables, output_variables, monolithic_truth_table] = vp.parse()

        self.output_variables = output_variables
        self.input_variables = all_input_variables
        self.z3_formulas = vp.z3_formulas
        self.python_formulas = vp.python_formulas
        self.partial_input_variables = vp.partial_input_variables

        sd = SymmetricDistance()

        lg = LatexGenerator()

        cm = CrossbarMerger()

        total_nodes = 0
        total_nr_variables = 0
        cumulative_area = 0

        for output_variable, [input_variables, truth_table] in bdds.items():
            self.truth_tables[output_variable] = [input_variables, truth_table]
            start_time = time.time()
            # Construct ROBDD for a given node
            abc_cmd = 'read_verilog "{}"; bdd; order; show_bdd {};'.format(verilog_file, output_variable)
            process = subprocess.Popen(config.abc_cmd, cwd=str(abc_path), stderr=None, stdin=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
            process.communicate(str.encode(abc_cmd))

            # Labeling method
            mvc = MinimumVertexCover()

            ldp = LabelingDotParser()
            ldp.read_file(dot_path.joinpath('copy.dot'.format(output_variable)))
            [crossbar, rows, columns, nr_variables, nr_vertices] = ldp.parse(output_variable, mvc)
            cm.add(crossbar, rows, columns)
            end_time = time.time() - start_time
            total_nodes += nr_vertices
            total_nr_variables += nr_variables
            cumulative_area += (rows-2) * (columns-2)

            self.crossbars[output_variable] = [rows, columns, crossbar]
            self.one_paths[output_variable] = ldp.one_paths

            if config.verbose:
                print(output_variable)
                print("Nr of vertices: " + str(nr_vertices))
                print("Nr of variables: " + str(nr_variables))
                print("Nr of rows: " + str(rows-2))
                print("Nr of columns: " + str(columns-2))
                print("Rows + columns: " + str(rows - 2 + columns - 2))
                print("Area: " + str((rows-2) * (columns-2)))
                print("Time: " + str(end_time) + "s")

            if config.log:
                config.log_file.subformula[output_variable] = {"input_variables": input_variables, "rows": rows, "columns": columns, "active_memristors": nr_variables}

            if model_checking:
                error = sd.is_valid(rows, columns, crossbar, input_variables, truth_table)
                print("Error label design: " + str(error))

            if config.draw:
                lg.draw_design(output_variable + '.tex', rows, columns, crossbar)

        [monolithic, rows, columns] = cm.merge()

        self.rows = rows
        self.columns = columns
        self.monolithic_crossbar = monolithic

        # Change to function evaluation on demand
        # i.e. evaluate the Boolean function for a given instance
        # -> sample input -> fast output evaluation
        if config.simulate:
            # if config.simulation_size > len(monolithic_truth_table):
            #     raise Exception("Simulation size larger than truth table.")
            lts = LTSpiceSimulator()
            if config.simulation_instance is not None:
                # simulate_instance = list(map(lambda v: config.simulation_instance[v], all_input_variables))
                # evaluation = [False]
                # for instance in monolithic_truth_table:
                #     if instance[:len(all_input_variables)] == simulate_instance:
                #         evaluation = instance[len(all_input_variables):]
                #         break
                # simulate_instance.extend(evaluation)
                samples = [monolithic_truth_table]
            else:
                samples = random.sample(monolithic_truth_table, config.simulation_size)
            [min_true_signal, max_false_signal, avg_true_signal, avg_false_signal] = lts.simulate(rows, columns, all_input_variables, output_variables, samples, monolithic)

            if config.log:
                config.log_file.simulation_size = config.simulation_size
                config.log_file.min_true_signal = min_true_signal
                config.log_file.max_false_signal = max_false_signal
                config.log_file.avg_true_signal = avg_true_signal
                config.log_file.avg_false_signal = avg_false_signal

            if config.verbose:
                print("Minimum true signal: {}".format(min_true_signal))
                print("Maximum false signal: {}".format(max_false_signal))
                print("Average true signal: {}".format(avg_true_signal))
                print("Average false signal: {}".format(avg_false_signal))

        total_time = time.time() - total_start_time

        print("Benchmark: " + file_name)
        print("Nr of inputs: " + str(len(all_input_variables)))
        print("Nr of outputs: " + str(len(output_variables)))
        print("Total nr of vertices: " + str(total_nodes))
        print("Total nr of variables: " + str(total_nr_variables))
        print("Total nr of rows: " + str(rows-1-len(output_variables)))
        print("Total nr of columns: " + str(columns-1-len(output_variables)))
        print("Rows + columns: " + str((rows - 1 - len(output_variables)) + (columns - 1 - len(output_variables))))
        print("Total Area: " + str((rows-1-len(output_variables)) * (columns-1-len(output_variables))))
        print("Cumulative Area: " + str(cumulative_area))
        print("Total time: " + str(total_time) + "s")

        if config.log:
            config.log_file.approach = "ROBDD"
            config.log_file.benchmark = file_name
            config.log_file.input_variables = len(all_input_variables)
            config.log_file.output_variables = len(output_variables)
            config.log_file.vertices = total_nodes
            config.log_file.rows = rows - 1 - len(output_variables)
            config.log_file.columns = columns - 1 - len(output_variables)
            config.log_file.cumulative_area = cumulative_area
            config.log_file.variables = total_nr_variables
            config.log_file.time = total_time
            config.log_file.write()

        if model_checking:
            total_error = sd.is_valid(rows, columns, monolithic, all_input_variables, monolithic_truth_table)
            print("Total error label design: " + str(total_error))

        if config.draw:
            print("-- Generating Latex file")
            lg.draw_design('robdd.tex', rows, columns, monolithic)

        if config.clean:
            files = [benchmark_path.joinpath(verilog_file),
                     abc_path.joinpath(file),
                     abc_path.joinpath(verilog_file),
                     abc_path.joinpath('copy.dot')
                     ]
            # for output_variable in output_variables:
            #     files.append(abc_path.joinpath('{}.ps'.format(output_variable)))
            #     files.append(abc_path.joinpath('{}.dot_copy.dot'.format(output_variable)))

            if config.draw:
                files.extend([Path.cwd().joinpath('robdd.aux'), Path.cwd().joinpath('robdd.log'), Path.cwd().joinpath('robdd.tex')])
                if verbose:
                    for output_variable in output_variables:
                        files.append(Path.cwd().joinpath('{}.aux'.format(output_variable)))
                        files.append(Path.cwd().joinpath('{}.log'.format(output_variable)))
                        files.append(Path.cwd().joinpath('{}.tex'.format(output_variable)))
            MappingMethod.clean(files)
        print()

        return rows, columns, monolithic
