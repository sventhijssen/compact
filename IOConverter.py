import subprocess

import config
from IOType import IOType


class IOConverter:

    def __init__(self):
        pass

    def convert(self, file: str, new_file: str, output_type: IOType = IOType.VERILOG):
        if output_type == IOType.VERILOG:
            write_cmd = 'write_verilog'
        elif output_type == IOType.PLA:
            write_cmd = 'write_pla'
        else:
            write_cmd = 'write_verilog'

        abc_cmd = 'read {}; bdd; order; collapse; {} {};'.format(file, write_cmd, new_file)

        process = subprocess.Popen(config.abc_cmd, cwd=str(config.abc_path), stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=None,
                                   shell=True)
        process.communicate(str.encode(abc_cmd))
