from MemristorGraph.MemristorNode import MemristorNode


class MemristorEdge:

    def __init__(self, a: MemristorNode, b: MemristorNode):
        self.a = a
        self.b = b
