from __future__ import annotations

import copy
from typing import Dict

from networkx import has_path
from z3 import Bool

from Benchmark import Benchmark
from Crossbar import Crossbar
from LatexGenerator import LatexGenerator
from Literal import Literal


class MemristorCrossbar(Crossbar):

    def __init__(self, rows: int, columns: int, default_literal=Literal("False", False)):
        super().__init__(rows, columns, default_literal)
        self.input_rows = None

    def __copy__(self):
        crossbar = MemristorCrossbar(self.rows, self.columns)
        crossbar.matrix = copy.deepcopy(self.matrix)
        crossbar.input_nanowires = self.input_nanowires
        crossbar.input_variables = self.input_variables.copy()
        crossbar.output_nanowires = self.output_nanowires.copy()
        return crossbar

    def get_benchmark(self):
        return Benchmark(self.filename, self.input_variables, self.output_nanowires)

    def get_graph(self):
        return self.graph()

    def get_crossbar(self):
        return self

    def get_matrix(self):
        return self.matrix

    def get_z3(self) -> Dict[str, Bool]:
        return dict()

    def instantiate(self, instance: dict) -> MemristorCrossbar:
        for r in range(self.rows):
            for c in range(self.columns):
                memristor = self.get_memristor(r, c)
                literal = memristor.literal
                variable_name = literal.atom
                positive = literal.positive
                if variable_name != "True" and variable_name != "False":
                    if positive:
                        if instance[variable_name]:
                            literal = Literal('True', True)
                        else:
                            literal = Literal('False', False)
                    else:
                        if instance[variable_name]:
                            literal = Literal('False', False)
                        else:
                            literal = Literal('True', True)
                    self.set_memristor(r, c, literal)
        return self

    def eval(self, instance: dict, input_function: str = "1") -> Dict[str, bool]:
        for (other_input_function, input_nanowire) in self.get_input_nanowires().items():
            if input_function != other_input_function:
                for c in range(self.columns):
                    self.set_memristor(input_nanowire, c, Literal("False", False))

        crossbar_copy = self.__copy__()
        crossbar_instance = crossbar_copy.instantiate(instance)
        graph = crossbar_instance.graph()
        true_edges = [(u, v) for u, v, d in graph.edges(data=True) if
                              not (d['atom'] == 'True' and d['positive'])]
        graph.remove_edges_from(true_edges)

        evaluation = dict()
        for (output_variable, output_nanowire) in crossbar_instance.get_output_nanowires().items():
            source = "R_{}".format(output_nanowire)
            input_nanowire = crossbar_instance.get_input_nanowire(input_function)
            sink = "R_{}".format(input_nanowire)
            evaluation[output_variable] = has_path(graph, source, sink)

        return evaluation

    def draw_matrix(self, benchmark_name: str):
        content = ''
        content += '\\documentclass{article}\n'
        content += '\\usepackage{tikz,amsmath,siunitx}\n'
        content += '\\usetikzlibrary{arrows,snakes,backgrounds,patterns,matrix,shapes,fit,calc,shadows,plotmarks}\n'
        content += '\\usepackage[graphics,tightpage,active]{preview}\n'
        content += '\\PreviewEnvironment{tikzpicture}\n'
        content += '\\PreviewEnvironment{equation}\n'
        content += '\\PreviewEnvironment{equation*}\n'
        content += '\\newlength{\imagewidth}\n'
        content += '\\newlength{\imagescale}\n'
        content += '\\pagestyle{empty}\n'
        content += '\\thispagestyle{empty}\n'
        content += '\\begin{document}\n'
        content += '\\begin{tikzpicture}[STUCK/.style={circle, draw, fill = red!40, minimum size=8, inner sep=0pt, ' \
                   'text width=6mm, align=center},OFF/.style={circle, draw, fill = gray!40, minimum size=8, inner sep=0pt, ' \
                   'text width=6mm, align=center},ON/.style={circle, draw, fill = green!40, minimum size=8, ' \
                   'inner sep=0pt, text width=6mm, align=center},VAR/.style={circle, draw, fill = blue!40, ' \
                   'minimum size=8, inner sep=0pt, text width=6mm, align=center},BARE/.style={circle, draw=none, ' \
                   'minimum size=8, inner sep=0pt, text width=6mm, align=center}]\n'

        for c in range(self.columns):
            for r in range(self.rows):
                if self.get_memristor(r, c).literal.atom == 'False':
                    v = '$\\scriptscriptstyle 0$'
                    s = 'OFF'
                elif self.get_memristor(r, c).literal.atom == 'True':
                    v = '$\\scriptscriptstyle 1$'
                    s = 'ON'
                else:
                    if not self.get_memristor(r, c).literal.positive:
                        v = '$\\scriptscriptstyle \\neg ' + self.get_memristor(r, c).literal.atom + '$'
                    else:
                        v = '$\\scriptscriptstyle ' + self.get_memristor(r, c).literal.atom + '$'
                    s = 'VAR'
                content += '\\node[%s](n%d_%d) at (0.8*%d, 0.8*%d) {%s};\n' % (
                    s, c + 1, self.rows - r, c + 1, self.rows - r, v)

        for c in range(self.columns - 1):
            for r in range(self.rows):
                content += '\\draw (n%d_%d) -- (n%d_%d);\n' % (c + 1, r + 1, c + 2, r + 1)

        for c in range(self.columns):
            for r in range(self.rows - 1):
                content += '\\draw (n%d_%d) -- (n%d_%d);\n' % (c + 1, r + 1, c + 1, r + 2)

        for (i, r) in self.get_input_nanowires().items():
            v = '$\\scriptscriptstyle Vin_{}$'.format(i)
            content += '\\node[BARE](n%d_%d) at (0.8*%d, 0.8*%d) {%s};\n' % (0, self.rows - r, 0, self.rows - r, v)
            content += '\\draw (n%d_%d) -- (n%d_%d);\n' % (0, self.rows - r, 1, self.rows - r)

        # Outputs
        output_variables = dict()
        for (o, r) in self.output_nanowires.items():
            if r in output_variables:
                output_variables[r].append(o)
            else:
                output_variables[r] = [o]
        for (r, os) in output_variables.items():
            for i in range(len(os)):
                o = os[i]
                v = '$\\scriptscriptstyle ' + o + '$'
                content += '\\node[BARE](n%d_%d) at (0.8*%d, 0.8*%d) {%s};\n' % (
                    self.columns + 1 + i, self.rows - r, self.columns + 1 + i, self.rows - r, v)
            content += '\\draw (n%d_%d) -- (n%d_%d);\n' % (self.columns, self.rows - r, self.columns + 1, self.rows - r)

        content += '\\end{tikzpicture}\n'
        content += '\\end{document}\n'

        LatexGenerator.generate(benchmark_name, content)
