from z3 import Bool

from abc import ABC, abstractmethod
from typing import Dict


class BooleanFunction(ABC):

    def __init__(self):
        self.input_variables = None
        self.output_nanowires = None

    @abstractmethod
    def get_benchmark(self):
        pass

    @abstractmethod
    def get_graph(self):
        pass

    @abstractmethod
    def get_crossbar(self):
        pass

    @abstractmethod
    def get_z3(self) -> Bool:
        pass

    @abstractmethod
    def eval(self, instance: dict) -> Dict[str, bool]:
        pass
