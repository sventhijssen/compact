from MemristorGraph.MemristorNode import MemristorNode
from MemristorGraph.MemristorEdge import MemristorEdge


class MemristorGraph:

    def __init__(self, rows: int, columns: int):
        self.nodes = set()
        self.edges = set()
        self.last_node_column = [None for column in range(columns)]  # for each row, track
        self.last_node_row = [None for row in range(rows)]

    def add_node(self, node: MemristorNode):
        self.nodes.add(node)
        self._update_edges(node)

    def _update_edges(self, node: MemristorNode):
        if self.last_node_column[node.column] is None:
            self.last_node_column[node.column] = node
        else:
            node.add_adjacent_node(self.last_node_column[node.column])
            self.last_node_column[node.column].add_adjacent_node(node)
            self.last_node_column[node.column] = node

        if self.last_node_row[node.row] is None:
            self.last_node_row[node.row] = node
        else:
            node.add_adjacent_node(self.last_node_row[node.row])
            self.last_node_row[node.row].add_adjacent_node(node)
            self.last_node_row[node.row] = node
