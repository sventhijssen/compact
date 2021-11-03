import re
from pathlib import Path

from MemristorCrossbar import MemristorCrossbar
from Literal import Literal


class CrossbarReader:

    def __init__(self, file_name: str):
        self.file_name = file_name
        self.crossbar = None

    @staticmethod
    def _get_input_variables(line):
        return line.split(" ")[1:]

    @staticmethod
    def _get_input_nanowires(lines):
        input_nanowires = dict()
        for line in lines:
            line_lst = line.split(" ")
            if line_lst[0] != ".i":
                break
            input_nanowires[line_lst[1]] = (0, int(line_lst[2]))
        return input_nanowires

    @staticmethod
    def _get_output_variables(lines):
        output_variables = dict()
        for line in lines:
            line_lst = line.split(" ")
            if line_lst[0] == ".xbar":
                break
            if line_lst[0] == ".o":
                output_variables[line_lst[1]] = (0, int(line_lst[2]))
        return output_variables

    def read(self):
        f = open(self.file_name, 'r')
        lines = f.read().splitlines()

        input_variables = self._get_input_variables(lines[1])
        rows = int(lines[3].split(" ")[1])
        columns = int(lines[4].split(" ")[1])
        input_nanowires = self._get_input_nanowires(lines[5:])
        output_variables = self._get_output_variables(lines[5:])

        self.crossbar = MemristorCrossbar(rows, columns)
        self.crossbar.input_variables = input_variables
        self.crossbar.output_nanowires = output_variables
        self.crossbar.filename = Path(self.file_name)
        self.crossbar.name = Path(lines[0].split(" ")[1]).name
        self.crossbar.input_nanowires = input_nanowires

        file_offset = lines.index(".xbar")
        for r in range(rows):
            line = lines[file_offset+1+r].split('\t')
            for c in range(columns):
                raw_literal = re.findall(r'(0|1|[\[\]a-z0-9]+|\\\+[\[\]a-z0-9]+)', line[c])[0]
                if raw_literal == '0':
                    self.crossbar.set_memristor(r, c, Literal('False', False))
                elif raw_literal == '1':
                    self.crossbar.set_memristor(r, c, Literal('True', True))
                elif raw_literal[0] == '\\':
                    self.crossbar.set_memristor(r, c, Literal(raw_literal[2:], False))
                else:
                    self.crossbar.set_memristor(r, c, Literal(raw_literal, True))
        f.close()
        return self.crossbar
