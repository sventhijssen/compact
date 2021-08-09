from abc import ABC, abstractmethod

from networkx import Graph


class Labeling(ABC):

    @staticmethod
    @abstractmethod
    def label(graph: Graph, leaf_node_one: str):
        pass
