class Node:

    def __init__(self, name: str = None):
        self.name = name

    def __eq__(self, other):
        if not isinstance(other, Node):
            return False
        return self.name == other.name

    def __hash__(self):
        return hash(self.name)

    def __str__(self):
        return self.name

    def __repr__(self):
        return self.name

    def __copy__(self):
        return Node(self.name)
