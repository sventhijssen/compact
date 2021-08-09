from collections import deque

from Graph.Edge import Edge
from Graph.Node import Node


class Graph:

    def __init__(self):
        self.nodes = set()
        self.edges = set()
        self.adjacency_list = dict()
        self.edge_attributes = dict()
        self.node_attributes = dict()

    def add_node(self, node: Node, attributes: dict = None):
        if node not in self.nodes:
            self.adjacency_list[node] = []
            self.nodes.add(node)
            self.node_attributes[node] = attributes

    def add_edge(self, node_a: Node, node_b: Node, attributes: dict = None):
        if not isinstance(node_a, Node):
            raise Exception("First argument must be of type Node")
        if not isinstance(node_b, Node):
            raise Exception("Second argument must be of type Node")
        if node_a not in self.nodes:
            self.add_node(node_a)
        if node_b not in self.nodes:
            self.add_node(node_b)

        edge = Edge(node_a, node_b)
        if edge not in self.edges:
            self.adjacency_list[node_a].append(node_b)
            self.adjacency_list[node_b].append(node_a)
            self.edges.add(Edge(node_a, node_b))
            self.edge_attributes[edge] = attributes
        return edge

    def degree(self, node: Node):
        return len(self.adjacency_list[node])
