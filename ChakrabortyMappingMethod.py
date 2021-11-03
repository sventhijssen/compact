import time
from datetime import datetime

from networkx import DiGraph

import config
from Literal import Literal
from MappingMethod import MappingMethod
from MemristorCrossbar import MemristorCrossbar


class ChakrabortyMappingMethod(MappingMethod):

    def __init__(self):
        super(ChakrabortyMappingMethod, self).__init__()

    def map(self, graph: DiGraph) -> MemristorCrossbar:
        print("Chakraborty's mapping method started")
        print(datetime.now())
        self.start_time = time.time()
        config.log.add('Nodes: {}\n'.format(len(graph.nodes)))
        config.log.add('Edges: {}\n'.format(len(graph.edges)))

        rows = len(graph.nodes)
        columns = len(graph.edges)

        crossbar = MemristorCrossbar(rows, columns)

        # We assign each node to a layer with the terminal node to the bottom-most nanowire
        # and the root node to the top-most nanowire
        r = 0
        input_variables = set()
        input_nodes = dict()
        root_nodes = dict()
        node_layers = dict()
        for (current_node, node_data) in graph.nodes(data=True):
            input_variables.add(node_data["variable"])
            if node_data["root"]:
                output_variables = node_data["output_variables"]
                for output_variable in output_variables:
                    root_nodes[output_variable] = (0, r)
            if node_data["terminal"]:
                input_variable = node_data["variable"]
                input_nodes[input_variable] = (0, r)
            node_layers[current_node] = r
            r += 1

        c = 0
        for (current_node, node_data) in graph.nodes(data=True):
            out_edges = graph.edges(current_node, data=True)
            variable = node_data['variable']

            positive_child_node = None
            negative_child_node = None
            for (_, child_node, edge_data) in out_edges:
                if edge_data['positive']:
                    positive_child_node = child_node
                if not edge_data['positive']:
                    negative_child_node = child_node

            if positive_child_node is not None:
                r_current_node = node_layers[current_node]
                r_child_node = node_layers[positive_child_node]
                crossbar.set_memristor(r_current_node, c, Literal(variable, True))
                crossbar.set_memristor(r_child_node, c, Literal("True", True))
                c += 1
            if negative_child_node is not None:
                r_current_node = node_layers[current_node]
                r_child_node = node_layers[negative_child_node]
                crossbar.set_memristor(r_current_node, c, Literal(variable, False))
                crossbar.set_memristor(r_child_node, c, Literal("True", True))
                c += 1

        crossbar.input_variables = list(input_variables)
        for (input_function, nanowire) in input_nodes.items():
            crossbar.set_input_nanowire(input_function, nanowire)
        for (output_function, nanowire) in root_nodes.items():
            crossbar.set_output_nanowire(output_function, nanowire)

        self.crossbar = crossbar
        self.end_time = time.time()

        config.log.add('Rows: {}\n'.format(rows))
        config.log.add('Columns: {}\n'.format(columns))
        config.log.add('Chakraborty\'s mapping method time (s): {}\n'.format(self.end_time - self.start_time))

        print("Chakraborty's mapping method stopped")

        return self.crossbar

    def get_log(self) -> str:
        pass
