class MemristorNode:

    def __init__(self, row, column):
        self.row = row
        self.column = column
        self.adjacent_nodes = set()

    def add_adjacent_node(self, node):
        self.adjacent_nodes.add(node)

    def __eq__(self, other):
        return self.row == other.row and self.column == other.column

    def __hash__(self):
        return hash((self.row, self.column))

    def __str__(self):
        return '(' + str(self.row) + ', ' + str(self.column) + ')'

    def __repr__(self):
        return '(' + str(self.row) + ', ' + str(self.column) + ')'
