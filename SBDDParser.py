import re

import networkx as nx

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


class SBDDParser:

    def __init__(self):
        self.dot_content = ""
        self.txt_content = ""
        self.active_rows = set()
        self.active_columns = set()
        self.nr_vertices = 0
        self.graph = None

    def read_file(self, dot_file_name, txt_file_name):
        file = open(dot_file_name, 'r')
        self.dot_content = file.read()
        file.close()

        file = open(txt_file_name, 'r')
        self.txt_content = file.read()
        file.close()

    def parse(self, labeling_method: Labeling = None):
        if labeling_method is None:
            raise Exception("No labeling method provided")

        parts = self.dot_content.split('1[shape="box"];')
        top_part = parts[0]
        bottom_part = parts[1]

        raw_layer_nodes = list(re.findall(r'(\d+)\(([\w\d]+)\)', self.txt_content))

        layer_node_mapping = dict()
        for (layer, node) in raw_layer_nodes:
            if layer != -1 and layer not in layer_node_mapping:
                layer_node_mapping[layer] = node

        # Get the names of the nodes and the values on which they are mapped
        raw_layers = list(re.findall(r'(\d+)\[label="([\w\d\s]+)"\]', bottom_part))

        raw_edges = re.findall(r'([\d]+)\s*--\s*([\w\d]+)\s*(\[style="dotted"\];|;)', bottom_part)

        g = nx.Graph()

        # Add the nodes of the graph
        node_name_mapping = dict()
        for (node, layer) in raw_layers:
            node_name_mapping[node] = layer
            g.add_node(node)
        node_name_mapping['1'] = '1'

        self.nr_vertices = len(g.nodes)

        input_variables = set()

        # Add the edges of the graph
        edges = dict()
        for raw_edge in raw_edges:
            if raw_edge[1] != '0':
                input_variables.add(node_name_mapping[raw_edge[0]])
                g.add_edge(raw_edge[1], raw_edge[0])
                if raw_edge[2] != '[style="dotted"];':
                    edges[Edge(raw_edge[1], raw_edge[0])] = Literal(node_name_mapping[raw_edge[0]], True)  # Positive edge
                else:
                    edges[Edge(raw_edge[1], raw_edge[0])] = Literal(node_name_mapping[raw_edge[0]], False)  # Negative edge

        raw_root_nodes = list(re.findall(r'([\w\d]+)\s*--\s*([\d]+)', top_part))

        config.log_file.edges = len(edges)

        root_nodes = dict()
        for (output_node, root_node) in raw_root_nodes:
            root_nodes[root_node] = output_node

        self.graph = g

        [vertical, horizontal] = labeling_method.label(g, '')

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
            if node_b in root_nodes.keys():
                if node_b in horizontal:
                    output_columns.add(node_b)
                if node_b in vertical:
                    output_rows.add(node_b)

            self.active_rows.add(r)
            self.active_columns.add(c)

        # https://stackoverflow.com/questions/54667212/matrix-flip-horizontal-or-vertical
        tempm = crossbar.copy()
        tempm.reverse()

        crossbar = [[None for i in range(h_dim+len(root_nodes)+1)] for j in range(v_dim+len(root_nodes)+1)]

        row_displacement = len(root_nodes)

        for r in range(v_dim):
            for c in range(h_dim):
                if tempm[r][c] is not None:
                    memristor = tempm[r][c]
                    crossbar[r + row_displacement][c + 1] = Memristor(r + row_displacement, c + 1, memristor.literal)
                else:
                    crossbar[r + row_displacement][c + 1] = tempm[r][c]

        # Flow input
        crossbar[v_dim + len(root_nodes)][0] = Memristor(v_dim + len(root_nodes), 0, Literal('True', True))

        if '1' in horizontal:
            r = v_dim + len(root_nodes)
            c = horizontal.index('1') + 1
            crossbar[r][c] = Memristor(r, c, Literal('True', True))
        if '1' in vertical:
            r = v_dim - vertical.index('1') + len(root_nodes) - 1
            c = 0
            crossbar[r][c] = Memristor(r, c, Literal('True', True))

        # Flow output
        outputs = dict()
        i = 0
        for output in root_nodes.values():
            r = i
            c = h_dim + len(root_nodes) - i
            crossbar[r][c] = Memristor(r, c, Literal('True', True))
            outputs[output] = [r, c]
            i += 1

        for node in output_columns:
            r = outputs[root_nodes[node]][0]
            c = horizontal.index(node)
            crossbar[r][c+1] = Memristor(r, c+1, Literal('True', True))
        # The crossbar was rotated, hence v_dim - r
        for node in output_rows:
            # r = vertical.index(node) + len(root_nodes)
            r = v_dim - vertical.index(node) - 1 + len(root_nodes)
            c = outputs[root_nodes[node]][1]
            crossbar[r][c] = Memristor(r, c, Literal('True', True))

        cells = 0
        for r in range(v_dim+len(root_nodes)+1):
            for c in range(h_dim+len(root_nodes)+1):
                if crossbar[r][c] is not None and crossbar[r][c].literal.atom != 'False' and crossbar[r][c].literal.atom != 'True':
                    cells += 1

                if crossbar[r][c] is None:
                    crossbar[r][c] = Memristor(r, c, Literal('False', False))
                elif crossbar[r][c] == 'True':
                    crossbar[r][c] = Memristor(r, c, Literal('True', True))
                else:
                    # Correction of memristor coordinates, after rotation and translation
                    memristor = crossbar[r][c]
                    crossbar[r][c] = Memristor(r, c, memristor.literal)

        return [crossbar, v_dim+len(root_nodes)+1, h_dim+len(root_nodes)+1, cells, len(node_name_mapping), list(root_nodes.values()), input_variables]
