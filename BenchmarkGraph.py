from typing import List, Dict

from networkx import DiGraph, disjoint_union, set_node_attributes

from z3 import z3

from BooleanFunction import BooleanFunction


class BenchmarkGraph(BooleanFunction):

    def get_benchmark(self):
        pass

    def get_graph(self):
        pass

    def get_crossbar(self):
        pass

    def get_z3(self) -> z3:
        pass

    def eval(self, instance: dict) -> Dict[str, bool]:
        pass

    def __init__(self, input_variables: List[str], output_variables: List[str]):
        super().__init__()
        self.name = ''
        self.input_variables = input_variables
        self.output_variables = output_variables
        self.graphs = []

    def get_single_graph(self) -> DiGraph:
        """
        A benchmark can consist of multiple ROBDDs or a single SBDD.
        In case the benchmark consists of multiple ROBDDs, we must first merge them into a single graph.
        :return:
        """
        single_graph = DiGraph()
        for graph in self.graphs:
            single_graph = disjoint_union(single_graph, graph)

        # Find all terminal one nodes
        terminal_ones = list(
            map(lambda tup: tup[0],
                filter(lambda tup: tup[1]["terminal"] and tup[1]["variable"] == '1',
                                           single_graph.nodes(data=True))))
        # Find all terminal zero nodes
        terminal_zeros = list(
                map(lambda tup: tup[0],
                    filter(lambda tup: tup[1]["terminal"] and tup[1]["variable"] == '0',
                           single_graph.nodes(data=True))))
        # ROBDDs
        if len(terminal_ones) > 1:
            # For each terminal one node, remove its incoming edges and connect the edges with the new
            # terminal one node
            root = False
            output_variables = []
            for terminal_one in terminal_ones:
                terminal_one_root = single_graph.nodes[terminal_one]["root"]
                if terminal_one_root:
                    root = True
                    output_variables.extend(single_graph.nodes[terminal_one]["output_variables"])

            terminal_edges = single_graph.in_edges(terminal_ones, data=True)

            n = max(single_graph.nodes)

            for (leaf_node, old_terminal_node, attributes) in terminal_edges:
                single_graph.add_edge(leaf_node, n + 1, **attributes)

            single_graph.nodes[n + 1]["variable"] = '1'
            single_graph.nodes[n + 1]["terminal"] = True
            single_graph.nodes[n + 1]["root"] = root
            if root:
                single_graph.nodes[n + 1]["output_variables"] = output_variables
            single_graph.remove_nodes_from(terminal_ones)

        if len(terminal_zeros) > 1:
            # For each terminal one node, remove its incoming edges and connect the edges with the new
            # terminal one node
            root = False
            output_variables = []
            for terminal_zero in terminal_zeros:
                terminal_zero_root = single_graph.nodes[terminal_zero]["root"]
                if terminal_zero_root:
                    root = True
                    output_variables.extend(single_graph.nodes[terminal_zero]["output_variables"])

            terminal_edges = single_graph.in_edges(terminal_zeros, data=True)

            n = max(single_graph.nodes)

            for (leaf_node, old_terminal_node, attributes) in terminal_edges:
                single_graph.add_edge(leaf_node, n + 1, **attributes)

            single_graph.nodes[n + 1]["variable"] = '0'
            single_graph.nodes[n + 1]["terminal"] = True
            single_graph.nodes[n + 1]["root"] = root
            if root:
                single_graph.nodes[n + 1]["output_variables"] = output_variables
            single_graph.remove_nodes_from(terminal_zeros)

        terminal_zeros = list(
                map(lambda tup: tup[0],
                    filter(lambda tup: tup[1]["terminal"] and tup[1]["variable"] == '0',
                           single_graph.nodes(data=True))))

        if len(terminal_zeros) > 0:
            terminal_zero = terminal_zeros[0]
            terminal_zero_data = single_graph.nodes[terminal_zero]
            # If root, we keep the node for output variables
            # We do remove terminal
            if terminal_zero_data["root"]:
                set_node_attributes(single_graph, {terminal_zero: False}, "terminal")
                terminal_zero_edges = list(single_graph.in_edges(terminal_zero))
                single_graph.remove_edges_from(terminal_zero_edges)
            else:
                single_graph.remove_nodes_from(terminal_zeros)

        return single_graph

    def get_all_graphs(self) -> List[DiGraph]:
        return self.graphs

    def add_graph(self, graph: DiGraph):
        self.graphs.append(graph)
