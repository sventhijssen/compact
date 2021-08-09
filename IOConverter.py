import os
import shutil
import subprocess

import config
from IOType import IOType


class IOConverter:

    def __init__(self, abc_path, input_path, output_path):
        self.input_path = input_path
        self.output_path = output_path
        self.abc_path = abc_path

    def convert(self, file: str, new_file: str, output_type: IOType = IOType.VERILOG, collapse: bool = True):
        # Copy input file from benchmark folder to ABC folder
        shutil.copy2(str(self.input_path) + os.path.sep + file, str(self.abc_path) + os.path.sep + file)

        if output_type == IOType.VERILOG:
            write_cmd = 'write_verilog'
        elif output_type == IOType.PLA:
            write_cmd = 'write_pla'
        else:
            write_cmd = 'write_verilog'

        if collapse:
            abc_cmd = 'read {}; bdd; order; collapse; {} {};'.format(file, write_cmd, new_file)
        else:
            abc_cmd = 'read {}; bdd; order; {} {};'.format(file, write_cmd, new_file)
        process = subprocess.Popen(config.abc_cmd, cwd=str(self.abc_path), stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                   shell=True)
        # process.stdin.write(str.encode(abc_cmd))
        process.communicate(str.encode(abc_cmd))

        # Copy output file from ABC folder to benchmark folder
        shutil.copy2(str(self.abc_path) + os.path.sep + new_file, str(self.output_path) + os.path.sep + new_file)

