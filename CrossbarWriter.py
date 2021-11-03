from MemristorCrossbar import MemristorCrossbar
from Literal import Literal


class CrossbarWriter:

    def __init__(self, crossbar: MemristorCrossbar, file_name):
        self.crossbar = crossbar
        self.file_name = file_name

    def _literal_representation(self, literal: Literal):
        if literal == Literal("True", True):
            return 1
        elif literal == Literal("False", False):
            return 0
        else:
            return literal

    def write(self):
        with open(self.file_name, 'w') as f:
            f.write(".model {}\n".format(self.file_name))
            f.write(".inputs {}\n".format(' '.join(self.crossbar.get_input_variables())))
            f.write(".outputs {}\n".format(' '.join(self.crossbar.get_output_variables())))
            f.write(".rows {}\n".format(self.crossbar.rows))
            f.write(".columns {}\n".format(self.crossbar.columns))
            for (input_variable, nanowire) in self.crossbar.get_input_nanowires().items():
                f.write(".i {} {}\n".format(input_variable, nanowire))
            for (output_variables, nanowire) in self.crossbar.get_output_nanowires().items():
                    f.write(".o {} {}\n".format(" ".join(output_variables), nanowire))
            f.write(".xbar\n")
            for r in range(self.crossbar.rows):
                for c in range(self.crossbar.columns):
                    literal = self._literal_representation(self.crossbar.get_memristor(r, c).literal)
                    if c < self.crossbar.columns - 1:
                        f.write("{}\t".format(literal))
                    else:
                        f.write("{}\r\n".format(literal))
            f.write(".end\n")
