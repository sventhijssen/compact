from Graph.Node import Node


class Edge:

    def __init__(self, a: Node, b: Node):
        self.a = a
        self.b = b

    def __eq__(self, other):
        if not isinstance(other, Edge):
            return False
        return self.a == other.a and self.b == other.b

    def __hash__(self):
        return hash((self.a, self.b))

    def __str__(self):
        return '(' + str(self.a) + ' -> ' + str(self.b) + ')'

    def __repr__(self):
        return '(' + str(self.a) + ' -> ' + str(self.b) + ')'

    def __copy__(self):
        return Edge(self.a, self.b)
