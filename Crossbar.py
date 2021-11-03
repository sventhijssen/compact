from __future__ import annotations

from abc import abstractmethod
from typing import Dict, List, Tuple

from networkx import Graph
from z3 import Bool
from BooleanFunction import BooleanFunction
from Literal import Literal
from Memristor import Memristor


class Crossbar(BooleanFunction):
    """
    Abstract class for a crossbar.
    """

    def __str__(self):
        return str(self.matrix)

    def __repr__(self):
        return str(self.matrix)

    def __copy__(self):
        pass

    @abstractmethod
    def draw_matrix(self, benchmark_name: str):
        pass

    @abstractmethod
    def eval(self, instance: dict, input_function: str = "1") -> Dict[str, bool]:
        pass

    @abstractmethod
    def get_z3(self) -> Bool:
        pass

    def instantiate(self, instance: Dict) -> Crossbar:
        pass

    @abstractmethod
    def get_matrix(self):
        pass

    def __init__(self, rows: int, columns: int, default_literal=Literal("False", False)):
        super().__init__()
        self.name = ""
        self.filename = ""
        self.rows = rows
        self.columns = columns
        self.input_nanowires = dict()
        self.output_nanowires = dict()
        self.input_variables = []
        self.default_literal = default_literal
        self.matrix = [[Memristor(r, c, default_literal) for c in range(self.columns)] for r in range(self.rows)]

    def set_name(self, name: str):
        self.name = name

    def get_name(self):
        return self.name

    def get_input_nanowire(self, input_function: str) -> int:
        return self.input_nanowires[input_function]

    def get_input_nanowires(self) -> Dict[str, int]:
        return self.input_nanowires

    def get_output_nanowire(self, output_function: str) -> int:
        return self.output_nanowires[output_function]

    def get_output_nanowires(self) -> Dict[str, int]:
        return self.output_nanowires

    def set_input_nanowire(self, input_function: str, nanowire: int):
        self.input_nanowires[input_function] = nanowire

    def set_output_nanowire(self, output_function: str, nanowire: int):
        self.output_nanowires[output_function] = nanowire

    def get_input_variables(self):
        return self.input_variables

    def get_output_variables(self):
        return self.output_nanowires.keys()

    def graph(self) -> Graph:
        graph = Graph()
        for r in range(self.rows):
            for c in range(self.columns):
                memristor = self.get_memristor(r, c)
                graph.add_edge("R_{}".format(r), "C_{}".format(c), atom=memristor.literal.atom, positive=memristor.literal.positive)
        return graph

    def get_rows(self) -> int:
        return self.rows

    def get_columns(self) -> int:
        return self.columns

    def get_semiperimeter(self):
        return self.get_rows() + self.get_columns()

    def get_memristor(self, row: int, column: int) -> Memristor:
        return self.matrix[row][column]

    def set_memristor(self, row: int, column: int, literal: Literal):
        memristor = Memristor(row, column, literal)
        self.matrix[row][column] = memristor

    def swap_rows(self, a: int, b: int):
        row_a = []
        row_b = []
        for c in range(self.columns):
            row_a.append(self.get_memristor(a, c))
            row_b.append(self.get_memristor(b, c))

        for c in range(self.columns):
            memristor = row_a[c]
            self.set_memristor(b, c, memristor.literal)

        for c in range(self.columns):
            memristor = row_b[c]
            self.set_memristor(a, c, memristor.literal)

        if a in self.get_output_nanowires().values():
            index = list(self.get_output_nanowires().values()).index(a)
            output_variable = list(self.get_output_nanowires().keys())[index]
            self.set_output_nanowire(output_variable, b)

        if b in self.get_output_nanowires().values():
            index = list(self.get_output_nanowires().values()).index(b)
            output_variable = list(self.get_output_nanowires().keys())[index]
            self.set_output_nanowire(output_variable, a)

    def flip_horizontal(self):
        self.matrix.reverse()

        for r in range(self.rows):
            for c in range(self.columns):
                memristor = self.get_memristor(r, c)
                self.set_memristor(r, c, memristor.literal)

        outputs = dict()
        for (output_variable, row) in self.get_output_nanowires().items():
            outputs[output_variable] = self.rows - 1 - row
        self.output_nanowires = outputs

    def flip_vertical(self):
        for r in range(self.rows):
            old_row = self.matrix[r]
            new_row = old_row[::-1]
            for c in range(self.columns):
                literal = new_row[c].literal
                new_row[c] = Memristor(r, c, literal)
            self.matrix[r] = new_row
