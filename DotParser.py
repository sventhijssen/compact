import re

from Literal import Literal
from Memristor import Memristor


class DotParser:

    def __init__(self):
        self.content = ""
        self.active_rows = set()
        self.active_columns = set()
        self.nr_vertices = 0

    def read_file(self, file_name):
        file = open(file_name, 'r')
        self.content = file.read()
        file.close()

    def parse(self, output_variable):

        # Get the names of the nodes and the values on which they are mapped
        raw_layers = list(reversed(re.findall(
            r'{\s*rank\s*=\s*same;([^}]+);\n}',
            self.content)))

        layers = []
        for raw_layer in raw_layers:
            layers.append(raw_layer.replace(' ', '').replace('\n', '').replace('"', '').split(';'))

        layers = layers[1:]

        # Strip the 'rank' and 'node' objects
        stripped_content = re.sub(r'{\s(?:rank|node)[^}]+}', '', self.content)

        # Find all edges defined by NODE -> NODE with optional [STYLE] parameter and
        # leave nodes, defined by NODE [LABEL]
        raw_edges = re.findall(
            r'"([\w\d\s]+)"\s->\s"([\w\d\s]+)"(?:\s\[style\s=\s(solid|dashed)\])?|"([\w\d\s]+)"\s\[label\s=\s"(\d)"\]',
            stripped_content)

        leave_nodes = dict()

        left_right_node = dict()

        edges = dict()
        for raw_edge in raw_edges:
            # print(raw_edge)
            if raw_edge[0] != '':
                if raw_edge[0] not in edges:
                    if raw_edge[2] != 'dashed':
                        edges[raw_edge[0]] = {'1': raw_edge[1]}
                    else:
                        edges[raw_edge[0]] = {'0': raw_edge[1]}
                else:
                    if raw_edge[2] != 'dashed':
                        edges[raw_edge[0]]['1'] = raw_edge[1]
                    else:
                        edges[raw_edge[0]]['0'] = raw_edge[1]

                if raw_edge[2] != 'dashed':
                    left_right_node[raw_edge[1]] = '1'
                else:
                    left_right_node[raw_edge[1]] = '0'

            else:
                leave_nodes[raw_edge[3]] = raw_edge[4]

        if len(leave_nodes) == 1:
            keys = list(leave_nodes.keys())

            # The function always evaluates to false
            if int(leave_nodes[keys[0]]) == 0:
                v_dim = 0
                h_dim = 0
                crossbar = [[Memristor(j, i, Literal('False', False)) for i in range(h_dim + 2)] for j in
                            range(v_dim + 2)]
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

            crossbar[0][1] = Memristor(0, 1, Literal('True', True))
            crossbar[v_dim + 1][1] = Memristor(v_dim + 1, 1, Literal('True', True))
            return [crossbar, v_dim + 2, h_dim + 2, 0, 1]

        root_node = edges['  {}  '.format(output_variable)]['1']

        dim = 4*len(edges)
        tempm = [[None for i in range(dim)] for j in range(dim)]

        # print(edges)
        # print(leave_nodes)
        #
        # print(layers)
        #
        # print(left_right_node)

        layers_dict = dict()

        h = dict()

        tempm[dim-1][0] = 'True'

        row = dim - 2
        col = 1

        input_rows = set()
        output_columns = set()

        for layer in layers:
            for node in layer[1:]:
                if node != '':

                    layers_dict[node] = layer[0]

                    d = 0

                    # print("MemristorNode: " + node)
                    if edges[node]['0'] in leave_nodes:
                        if leave_nodes[edges[node]['0']] != '0':
                            tempm[row][col] = '\+' + node
                            if leave_nodes[edges[node]['0']] == '1':
                                tempm[row][0] = 'True'
                                input_rows.add(row)
                            d += 1
                    else:
                        tempm[h[edges[node]['0']]][col] = '\+' + node

                    if edges[node]['1'] in leave_nodes:
                        if leave_nodes[edges[node]['1']] != '0':
                            tempm[row-d][col] = node
                            if leave_nodes[edges[node]['1']] == '1':
                                tempm[row-d][0] = 'True'
                                input_rows.add(row-d)
                            d += 1
                    else:
                        tempm[h[edges[node]['1']]][col] = node

                    # TODO: Better mapping for True/1 -> must be in steps above all nodes from this layer
                    if node != root_node:
                        tempm[row - d][col] = 'True'
                        h[node] = row - d
                        row -= (d+1)
                        col += 1
                    else:
                        tempm[0][col] = 'True'  # Set node_a node in the first row to True to guid to the output
                        tempm[0][dim-1] = 'True'  # The output node
                        output_columns.add(col)

        # print('\n'.join([''.join(['{:4}\t\t'.format(str(item)) for item in row]) for row in
        #                  tempm]))

        # print(layers_dict)

        # print(h)

        self.nr_vertices = len(layers_dict.values()) + 1

        for r in range(dim):
            for c in range(dim):

                if tempm[r][c] is None:
                    tempm[r][c] = Memristor(r, c, Literal('False', False))
                elif tempm[r][c] == 'True':
                    tempm[r][c] = Memristor(r, c, Literal('True', True))
                elif tempm[r][c].startswith('\\+'):
                    tempm[r][c] = Memristor(r, c, Literal(layers_dict[tempm[r][c][2:]], False))
                    self.active_rows.add(r)
                    self.active_columns.add(c)
                else:
                    tempm[r][c] = Memristor(r, c, Literal(layers_dict[tempm[r][c]], True))
                    self.active_rows.add(r)
                    self.active_columns.add(c)

        v_dim = len(self.active_rows)
        h_dim = len(self.active_columns)

        crossbar = [[None for i in range(h_dim + 2)] for j in range(v_dim + 2)]

        row_offset = dim - v_dim - 1
        col_offset = 1

        for r in range(v_dim):
            for c in range(h_dim):
                if tempm[r + row_offset][c + col_offset] == 'True':
                    crossbar[r + 1][c + 1] = Memristor(r + 1, c + 1, Literal('True', True))
                else:
                    # Correction of memristor coordinates, after totation and translation
                    memristor = tempm[r + row_offset][c + col_offset]
                    crossbar[r + 1][c + 1] = Memristor(r + 1, c + 1, memristor.literal)

        cells = 0
        for r in range(v_dim + 2):
            for c in range(h_dim + 2):
                if crossbar[r][c] is not None and crossbar[r][c].literal.atom != 'False' and crossbar[r][c].literal.atom != 'True':
                    cells += 1

                if crossbar[r][c] is None:
                    crossbar[r][c] = Memristor(r, c, Literal('False', False))

        # Flow input
        crossbar[v_dim + 1][0] = Memristor(v_dim + 1, 0, Literal('True', True))
        # Flow output
        crossbar[0][h_dim + 1] = Memristor(0, h_dim + 1, Literal('True', True))

        # Input rows
        for r in input_rows:
            crossbar[r - dim + v_dim + 2][0] = Memristor(r - dim + v_dim + 2, 0, Literal('True', True))

        # Output columns
        for c in output_columns:
            crossbar[0][c] = Memristor(0, c, Literal('True', True))

        return [crossbar, v_dim + 2, h_dim + 2, cells, self.nr_vertices]