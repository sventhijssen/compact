import os
import shutil
import subprocess

import config


class VerilogConverter:

    def __init__(self, benchmark_path, abc_path):
        self.benchmark_path = benchmark_path
        self.abc_path = abc_path

    def convert(self, file, new_file, collapse=True):
        # Copy input file from benchmark folder to ABC folder
        shutil.copy2(str(self.benchmark_path) + os.path.sep + file, str(self.abc_path) + os.path.sep + file)

        if collapse:
            abc_cmd = 'read {}; bdd; collapse; write_verilog {};'.format(file, new_file)
        else:
            abc_cmd = 'read {}; bdd; write_verilog {};'.format(file, new_file)
        process = subprocess.Popen(config.abc_cmd, cwd=str(self.abc_path), stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                   shell=True)
        # process.stdin.write(str.encode(abc_cmd))
        process.communicate(str.encode(abc_cmd))

        # Copy Verilog file from ABC folder to benchmark folder
        shutil.copy2(str(self.abc_path) + os.path.sep + new_file, str(self.benchmark_path) + os.path.sep + new_file)

