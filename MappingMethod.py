import os
from abc import ABC, abstractmethod
from pathlib import Path
from typing import List

from BenchmarkLog import BenchmarkLog


class MappingMethod(ABC):

    def __init__(self):
        self.input_variables = set()
        self.output_variables = set()
        self.partial_input_variables = dict()  # output_variable -> partial_input_variables
        self.truth_tables = dict()  # output_variable -> truth_table
        self.crossbars = dict()  # output_variable -> [rows, columns, crossbar]
        self.one_paths = dict()  # output_variable -> one_paths
        self.python_formulas = dict()
        self.z3_formulas = dict()  # output_variable -> z3_formula
        self.rows = 0
        self.columns = 0
        self.monolithic_crossbar = None

    @staticmethod
    def clean(files: List[Path]):
        for file in files:
            if file.exists():
                os.remove(str(file))

    @abstractmethod
    def map(self, file_path: str, logger: BenchmarkLog = None, model_checking: bool = False, draw: bool = False, clean: bool = True, verbose: bool = False):
        pass
