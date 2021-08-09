import re

import networkx as nx
from networkx import DiGraph

import config
from Graph.Edge import Edge
from Labeling import Labeling
from Literal import Literal
from Memristor import Memristor


class Mapping:
    def __init__(self, orientation: str, position: int):
        self.orientation = orientation
        self.position = position

    def __str__(self):
        return self.orientation + '_' + str(self.position)

    def __repr__(self):
        return self.orientation + '_' + str(self.position)


class LabelingDotParser:

    def __init__(self):
        self.content = ""
        self.active_rows = set()
        self.active_columns = set()
        self.nr_vertices = 0
        self.graph = None
        self.one_paths = []

    def read_file(self, file_name):
        file = open(file_name, 'r')
        self.content = file.read()
        file.close()

    def parse(self, output_variable: str, labeling_method: Labeling = None):
        if labeling_method is None:
            raise Exception("No labeling method provided")

        # Get the names of all the nodes
        all_nodes = list(re.findall(
            r'"\s*([\w\d\s]+)\s"\s*->',
            self.content))

        # Get the names of the nodes and the values on which they are mapped
        raw_layers = list(re.findall(
            r'{\s*rank\s*=\s*same;([^}]+);\n}',
            self.content))

        layers = []
        for raw_layer in raw_layers:
            layers.append(raw_layer.replace(' ', '').replace('\n', '').replace('"', '').split(';'))

        # Remove function output
        layers = layers[:-1]

        # Strip the 'rank' and 'node' objects
        stripped_content = re.sub(r'{\s(?:rank|node)[^}]+}', '', self.content)

        # Find all edges defined by NODE -> NODE with optional [STYLE] parameter and
        # leave nodes, defined by NODE [LABEL]
        raw_edges = re.findall(
            r'"([\w\d\s]+)"\s->\s"([\w\d\s]+)"(?:\s\[style\s=\s(solid|dashed)\])?|"([\w\d\s]+)"\s\[label\s=\s"(\d)"\]',
            stripped_content)

        g = nx.Graph()

        # Add the nodes of the graph
        node_name_mapping = dict()
        for layer in layers:
            for i in range(1, len(layer)):
                node_name_mapping[layer[i]] = layer[0]
                g.add_node(layer[i])

        self.nr_vertices = len(g.nodes) + 1

        if self.nr_vertices == 1:

            leaf_zero = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '0', raw_edges)))
            # The function always evaluates to false
            if len(leaf_zero) != 0:
                v_dim = 0
                h_dim = 0
                crossbar = [[Memristor(j, i, Literal('False', False)) for i in range(h_dim + 2)] for j in range(v_dim + 2)]
                # Flow input
                crossbar[v_dim + 1][0] = Memristor(v_dim + 1, 0, Literal('True', True))
                # Flow output
                crossbar[0][h_dim + 1] = Memristor(0, h_dim + 1, Literal('True', True))

                return [crossbar, v_dim + 2, h_dim + 2, 0, 0]

            v_dim = 1
            h_dim = 1
            crossbar = [[Memristor(j, i, Literal('False', False)) for i in range(h_dim + 2)] for j in range(v_dim + 2)]
            # Flow input
            crossbar[v_dim + 1][0] = Memristor(v_dim + 1, 0, Literal('True', True))
            # Flow output
            crossbar[0][h_dim + 1] = Memristor(0, h_dim + 1, Literal('True', True))

            crossbar[v_dim + 1][h_dim + 1] = Memristor(v_dim + 1, h_dim + 1, Literal('True', True))
            crossbar[v_dim][h_dim] = Memristor(v_dim, h_dim, Literal('True', True))
            crossbar[0][h_dim] = Memristor(0, h_dim, Literal('True', True))
            return [crossbar, v_dim + 2, h_dim + 2, 0, 1]
        else:
            leaf_zero = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '0', raw_edges)))[0]
            leaf_node_one = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '1', raw_edges)))[0]

        connected_to_leaf_node_one = set()

        edges = dict()
        # Add the edges of the graph
        for raw_edge in raw_edges:
            # print(raw_edge)
            if raw_edge[0] != '' and raw_edge[0] != '  {}  '.format(output_variable):
                if raw_edge[1] != leaf_zero:
                    if raw_edge[1] == leaf_node_one:
                        connected_to_leaf_node_one.add(raw_edge[0])
                    g.add_edge(raw_edge[0], raw_edge[1])
                    if raw_edge[2] != 'dashed':
                        edges[Edge(raw_edge[0], raw_edge[1])] = Literal(node_name_mapping[raw_edge[0]], True)  # Positive edge
                    else:
                        edges[Edge(raw_edge[0], raw_edge[1])] = Literal(node_name_mapping[raw_edge[0]], False)  # Negative edge

        root_node = list(map(lambda tup: list(tup)[1], filter(lambda tup: tup[0] == '  {}  '.format(output_variable), raw_edges)))[0]

        config.log_file.edges += len(edges)
        # sys.exit()

        self.graph = g

        di_g = DiGraph()
        for edge in edges:
            di_g.add_edge(edge.a, edge.b)
        raw_one_paths = list(nx.all_simple_paths(di_g, source=root_node, target=leaf_node_one))
        for raw_one_path in raw_one_paths:
            one_path = []
            for k in range(len(raw_one_path) - 1):
                literal = edges[Edge(raw_one_path[k], raw_one_path[k + 1])]
                if not literal.positive:
                    one_path.append(Literal(node_name_mapping[raw_one_path[k]], False))
                else:
                    one_path.append(Literal(node_name_mapping[raw_one_path[k]], True))
            self.one_paths.append(one_path)

        if config.verbose:
            print("Number of edges: " + str(len(g.edges)))
            print("Number of nodes: " + str(len(g.nodes)))

        [vertical, horizontal] = labeling_method.label(g, leaf_node_one)

        v_dim = len(vertical)
        h_dim = len(horizontal)

        crossbar = [[None for i in range(h_dim)] for j in range(v_dim)]

        # Place the edges on the crossbar
        # col_offset = 1
        # row_offset = 1

        output_rows = set()
        output_columns = set()

        for edge in edges.keys():
            node_a = edge.a
            node_b = edge.b

            if node_a in horizontal and node_a in vertical:
                if node_b in horizontal:
                    c = horizontal.index(node_b)
                    r = vertical.index(node_a)
                else:
                    c = horizontal.index(node_a)
                    r = vertical.index(node_b)
                crossbar[r][c] = Memristor(r, c, edges[Edge(node_a, node_b)])

                c = horizontal.index(node_a)
                r = vertical.index(node_a)
                crossbar[r][c] = Memristor(r, c, Literal('True', True))
            elif node_b in horizontal and node_b in vertical:
                if node_a in horizontal:
                    c = horizontal.index(node_a)
                    r = vertical.index(node_b)
                else:
                    c = horizontal.index(node_b)
                    r = vertical.index(node_a)
                crossbar[r][c] = Memristor(r, c, edges[Edge(node_a, node_b)])

                c = horizontal.index(node_b)
                r = vertical.index(node_b)
                crossbar[r][c] = Memristor(r, c, Literal('True', True))
            elif node_a in horizontal and node_b in vertical:
                c = horizontal.index(node_a)
                r = vertical.index(node_b)
                crossbar[r][c] = Memristor(r, c, edges[Edge(node_a, node_b)])
            else:
                c = horizontal.index(node_b)
                r = vertical.index(node_a)
                crossbar[r][c] = Memristor(r, c, edges[Edge(node_a, node_b)])

            # If this edge connects to constant 1, we will guide it to the output
            # We place a 1 in the row/column of the variable
            if node_b == leaf_node_one:
                if node_b in horizontal:
                    output_columns.add(horizontal.index(node_b))
                if node_b in vertical:
                    output_rows.add(vertical.index(node_b))

            self.active_rows.add(r)
            self.active_columns.add(c)

        # https://stackoverflow.com/questions/54667212/matrix-flip-horizontal-or-vertical
        tempm = crossbar.copy()
        tempm.reverse()

        crossbar = [[None for i in range(h_dim+2)] for j in range(v_dim+2)]

        for r in range(v_dim):
            for c in range(h_dim):
                crossbar[r+1][c+1] = tempm[r][c]

        # Flow input
        crossbar[v_dim + 1][0] = Memristor(v_dim + 1, 0, Literal('True', True))
        # Flow output
        crossbar[0][h_dim + 1] = Memristor(0, h_dim + 1, Literal('True', True))

        if root_node in horizontal:
            c = horizontal.index(root_node)
            crossbar[v_dim+1][c+1] = Memristor(v_dim+1, c+1, Literal('True', True))
        if root_node in vertical:
            r = vertical.index(root_node)
            crossbar[v_dim - r][0] = Memristor(v_dim - r, 0, Literal('True', True))

        for c in output_columns:
            crossbar[0][c+1] = Memristor(0, c+1, Literal('True', True))
        # The crossbar was rotated, hence v_dim - r
        for r in output_rows:
            crossbar[v_dim - r][h_dim + 1] = Memristor(v_dim - r, h_dim + 1, Literal('True', True))

        cells = 0
        for r in range(v_dim+2):
            for c in range(h_dim+2):
                if crossbar[r][c] is not None and crossbar[r][c].literal.atom != 'False' and crossbar[r][c].literal.atom != 'True':
                    cells += 1

                if crossbar[r][c] is None:
                    crossbar[r][c] = Memristor(r, c, Literal('False', False))
                elif crossbar[r][c] == 'True':
                    crossbar[r][c] = Memristor(r, c, Literal('True', True))
                else:
                    # Correction of memristor coordinates, after totation and translation
                    memristor = crossbar[r][c]
                    crossbar[r][c] = Memristor(r, c, memristor.literal)

        return [crossbar, v_dim+2, h_dim+2, cells, self.nr_vertices]
