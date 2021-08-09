import re

from Graph.Graph import Graph
from Graph.Node import Node
from Literal import Literal
from Memristor import Memristor


class Parent:

    def __init__(self, row: int, col: int, horizontal: bool):
        self.row = row
        self.col = col
        self.horizontal = horizontal


class NewDotParser:

    def __init__(self):
        self.content = ""

    def read_file(self, file_name):
        file = open(file_name, 'r')
        self.content = file.read()
        file.close()

    def parse(self):

        # Get the names of the nodes and the values on which they are mapped
        raw_layers = list(re.findall(
            r'{\s*rank\s*=\s*same;([^}]+);\n}',
            self.content))

        layers = []
        for raw_layer in raw_layers:
            layers.append(raw_layer.replace(' ', '').replace('\n', '').replace('"', '').split(';'))

        layers = layers[:-1]

        # Strip the 'rank' and 'node' objects
        stripped_content = re.sub(r'{\s(?:rank|node)[^}]+}', '', self.content)

        # Find all edges defined by NODE -> NODE with optional [STYLE] parameter and
        # leave nodes, defined by NODE [LABEL]
        raw_edges = re.findall(
            r'"([\w\d\s]+)"\s->\s"([\w\d\s]+)"(?:\s\[style\s=\s(solid|dashed)\])?|"([\w\d\s]+)"\s\[label\s=\s"(\d)"\]',
            stripped_content)

        leave_nodes = dict()

        left_right_node = dict()

        g = Graph()

        layers_dict = dict()

        for layer in layers:
            for i in range(1, len(layer)):
                g.add_node(Node(layer[i]))

        edges = dict()
        for raw_edge in raw_edges:
            # print(raw_edge)
            if raw_edge[0] != '' and raw_edge[0] != '  F  ':
                if raw_edge[0] not in edges:
                    if raw_edge[2] != 'dashed':
                        g.add_edge(Node(raw_edge[0]), Node(raw_edge[1]), {'weight': 1})
                    else:
                        g.add_edge(Node(raw_edge[0]), Node(raw_edge[1]), {'weight': 0})
                else:
                    if raw_edge[2] != 'dashed':
                        g.add_edge(Node(raw_edge[0]), Node(raw_edge[1]), {'weight': 1})
                    else:
                        g.add_edge(Node(raw_edge[0]), Node(raw_edge[1]), {'weight': 0})

                if raw_edge[2] != 'dashed':
                    left_right_node[raw_edge[1]] = '1'
                else:
                    left_right_node[raw_edge[1]] = '0'

            else:
                leave_nodes[raw_edge[3]] = raw_edge[4]

        g.coloring()

        root_node = edges['  F  ']['1']

        return self.design_crossbar(root_node, edges, leave_nodes, layers_dict)

    def design_crossbar(self, root_node, edges, leave_nodes, layers_dict):

        self.crossbar[self.dim - 1][0] = 'True'
        self.crossbar[0][self.dim - 1] = 'True'

        s = [root_node]  # Stack with the order of visiting the nodes

        parent_positions = {root_node: Parent(0, self.dim-1, False)}
        visited = set()

        last_row = 0
        last_col = self.dim - 1

        # TODO: Before placing node_a node on the board, first check whether the its neighbor is already places on the
        #  board and whether these nodes can be connected
        # e.g.:
        #           a0 a1
        #         /  \/ \
        #       ...  b1 ...
        # b1 is already places on the board by a0 and needs to be placed on the board by a1 ->
        # check if these can be connected

        while not len(s) == 0:
            node = s.pop()

            parent = parent_positions[node]

            if node not in leave_nodes:

                # If parent node is not horizontal., i.e. vertical, then this node is horizontal
                if not parent.horizontal:
                    d = 0
                    if edges[node]['0'] not in leave_nodes or leave_nodes[edges[node]['0']] == '1':
                        d += 1
                        self.crossbar[parent.row][last_col - d] = '\+' + node  # Negative
                        s.append(edges[node]['0'])
                        parent_positions[edges[node]['0']] = Parent(parent.row, last_col - d, True)  # Negative

                        if edges[node]['0'] in leave_nodes and leave_nodes[edges[node]['0']] == '1':
                            self.crossbar[self.dim - 1][last_col - d] = 'True'

                    if edges[node]['1'] not in leave_nodes or leave_nodes[edges[node]['1']] == '1':
                        d += 1
                        self.crossbar[parent.row][last_col - d] = node  # Positive
                        s.append(edges[node]['1'])
                        parent_positions[edges[node]['1']] = Parent(parent.row, last_col - d, True)  # Positive

                        if edges[node]['1'] in leave_nodes and leave_nodes[edges[node]['1']] == '1':
                            self.crossbar[self.dim - 1][last_col - d] = 'True'
                    last_col = last_col - d
                else:
                    if node in visited:
                        pass
                    else:
                        d = 0
                        if edges[node]['1'] not in leave_nodes or leave_nodes[edges[node]['1']] == '1':
                            d += 1
                            self.crossbar[last_row + d][parent.col] = node  # Positive
                            s.append(edges[node]['1'])
                            parent_positions[edges[node]['1']] = Parent(last_row + d, parent.col, False)

                            if edges[node]['1'] in leave_nodes and leave_nodes[edges[node]['1']] == '1':
                                self.crossbar[last_row + d][0] = 'True'

                        if edges[node]['0'] not in leave_nodes or leave_nodes[edges[node]['0']] == '1':
                            d += 1
                            self.crossbar[last_row + d][parent.col] = '\+' + node  # Negative
                            s.append(edges[node]['0'])
                            parent_positions[edges[node]['0']] = Parent(last_row + d, parent.col, False)  # Negative

                            if edges[node]['0'] in leave_nodes and leave_nodes[edges[node]['0']] == '1':
                                self.crossbar[last_row + d][0] = 'True'
                        last_row = last_row + d

        print('\n'.join([''.join(['{:4}\t\t'.format(str(item)) for item in row]) for row in
                         self.crossbar]))

        for r in range(self.dim):
            for c in range(self.dim):
                if self.crossbar[r][c] is None:
                    self.crossbar[r][c] = Memristor(r, c, Literal('False', False))
                elif self.crossbar[r][c] == 'True':
                    self.crossbar[r][c] = Memristor(r, c, Literal('True', True))
                elif self.crossbar[r][c].startswith('\\+'):
                    self.crossbar[r][c] = Memristor(r, c, Literal(layers_dict[self.crossbar[r][c][2:]], False))
                else:
                    self.crossbar[r][c] = Memristor(r, c, Literal(layers_dict[self.crossbar[r][c]], True))

        print('\n'.join([''.join(['{:4}\t\t'.format(str(item)) for item in row]) for row in
                         self.crossbar]))
        return [self.crossbar, last_row, last_col]
