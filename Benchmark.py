from pathlib import Path
from typing import Dict, List

from z3 import Bool

from BooleanFunction import BooleanFunction
from Formula import Formula


class Benchmark(BooleanFunction):

    def __init__(self, file_path: Path, input_variables: List[str], output_variables: List[str],
                 formulas: Dict[str, Formula] = None):
        super(Benchmark).__init__()
        if formulas is None:
            formulas = dict()
        [name, _] = file_path.name.split('.')
        self.model = None
        self.name = name
        self.file_path = file_path
        self.input_variables = input_variables
        self.output_variables = output_variables
        self.formulas = formulas
        self.graph = None

    def get_benchmark(self):
        return self

    def get_graph(self):
        pass

    def get_crossbar(self):
        pass

    def get_z3(self) -> Bool:
        pass

    def eval(self, instance: Dict) -> Dict[str, bool]:
        evaluation = dict()
        for (output_variable, formula) in self.formulas.items():
            evaluation[output_variable] = formula.eval(instance)
        return evaluation

    def __str__(self):
        return self.name + ""

    def add_formula(self, formula):
        self.formulas[formula.output_variable] = formula
