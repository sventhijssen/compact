import os
import re
import shutil
import time
from datetime import datetime

import pexpect as pexpect
from networkx import DiGraph, disjoint_union, set_node_attributes, Graph
from pexpect import EOF, TIMEOUT

import config
from BDDParser import BDDParser
from Benchmark import Benchmark


class ROBDDDOTParser(BDDParser):

    def __init__(self, benchmark: Benchmark):
        super(ROBDDDOTParser, self).__init__(benchmark)
        self.copy_file = config.abc_path.joinpath('copy.dot')
        self.abc_file_path = config.abc_path.joinpath(self.benchmark.file_path.name)

        if self.copy_file.exists():
            os.remove(self.copy_file)

    def _write_files(self):
        print("\tStarted ABC")
        dot_bdds = dict()
        file_name = self.benchmark.file_path.name

        output_variables = self.benchmark.output_variables

        bdd_construct_start_time = time.time()
        process = pexpect.spawn(config.abc_cmd, cwd=str(config.abc_path))
        process.sendline('read "{}"; bdd; collapse;'.format(file_name))

        try:
            if config.time_limit_bdd is not None:
                index = process.expect('abc 03>', timeout=config.time_limit_bdd)
            else:
                index = process.expect('abc 03>', timeout=config.time_limit_bdd)
            bdd_construct_stop_time = time.time()

            self.bdd_construct_time = bdd_construct_stop_time - bdd_construct_start_time

            self.log += 'BDD construct time (s): {}\n'.format(self.bdd_construct_time)

            if index == 0:
                i = 1
                for output_variable in output_variables:
                    print("\t\tOutput variable {}/{}: {}".format(i, len(output_variables), output_variable))
                    bdd_show_start_time = time.time()
                    abc_cmd = 'show_bdd "{}";'.format(output_variable)
                    process.sendline(abc_cmd)
                    process.expect('abc 03>')
                    while not self.copy_file.exists():
                        pass
                    bdd_show_stop_time = time.time()
                    self.bdd_show_times[output_variable] = bdd_show_stop_time - bdd_show_start_time
                    time.sleep(1)
                    dot_bdd = self._read_file()
                    dot_bdds[output_variable] = dot_bdd
                    if self.copy_file.exists():
                        os.remove(self.copy_file)
                    while self.copy_file.exists():
                        pass
                    time.sleep(1)
                    i += 1

                print("\tStopped ABC")
                return dot_bdds
        except EOF:
            raise Exception("\tABC EOF error.\n")
        except TIMEOUT:
            self.log += 'BDD construct time (s): {}\n'.format(config.time_limit_bdd)
            self.log += 'Timeout'
            config.log.add(self.get_log())
            raise Exception("\tABC timeout error.\n")

    def _read_file(self):
        dot_content = ""
        with open(self.copy_file, 'r') as file:
            for line in file:
                dot_content += line
        return dot_content

    def parse(self) -> Graph:
        print("Started constructing ROBDDs from benchmark")
        print("\t{}".format(datetime.now()))

        self.log += 'BDD type: ROBDD\n'

        # Copy the file from its current location to abc folder
        shutil.copy(self.benchmark.file_path, self.abc_file_path)

        # Generate BDD using ABC
        dot_bdds = self._write_files()

        print("\tStarted parsing ROBDDs")

        for output_variable in self.benchmark.output_variables:
            dot_content = dot_bdds[output_variable]

            bdd = DiGraph()

            # Get the names of the nodes and the values on which they are mapped
            raw_layers = list(re.findall(r'{\s*rank\s*=\s*same;([^}]+);\n}', dot_content))

            layers = []
            for raw_layer in raw_layers:
                layers.append(raw_layer.replace(' ', '').replace('\n', '').replace('"', '').split(';'))

            # Remove function output
            layers = layers[:-1]

            node_variable = dict()

            # Build BDD (directed graph) by adding the nodes
            for i in range(len(layers)):
                layer = layers[i]
                input_variable = layer[0]
                nodes = layer[1:]
                for node in nodes:
                    node_variable[node] = layer[0]
                    if i == 0:
                        root = True
                    else:  # Value must be overridden for leaf nodes (deduced from edges pointing to terminal node one)
                        root = False
                    bdd.add_node(node, variable=input_variable, terminal=False, root=root)

            # Strip the 'rank' and 'node' objects
            stripped_content = re.sub(r'{\s(?:rank|node)[^}]+}', '', dot_content)

            # Find all edges defined by NODE -> NODE with optional [STYLE] parameter and
            # leave nodes, defined by NODE [LABEL]
            raw_edges = re.findall(
                r'"([\w\d\s\[\]]+)"\s->\s"([\w\d\s]+)"(?:\s\[style\s=\s(solid|dashed)\])?|"([\w\d\s]+)"\s\[label\s=\s"(\d)"\]',
                stripped_content)

            has_terminal_zero = list(filter(lambda tup: tup[4] == '0', raw_edges))
            has_terminal_one = list(filter(lambda tup: tup[4] == '1', raw_edges))

            # Normal BDD
            if len(has_terminal_one) > 0 and len(has_terminal_zero) > 0:
                terminal_one = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '1', raw_edges)))[0]
                terminal_zero = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '0', raw_edges)))[0]

                bdd.add_node(terminal_one, variable='1', terminal=True, root=False)
                bdd.add_node(terminal_zero, variable='0', terminal=True, root=False)
                output_variable_node_name = raw_edges[0][0]

                # Add output variable to root node
                root_node = list(filter(lambda n: n[1]["root"], bdd.nodes(data=True)))[0][0]
                set_node_attributes(bdd, {root_node: [output_variable]}, "output_variables")
                set_node_attributes(bdd, {root_node: True}, "root")

                # Add the edges of the graph
                for raw_edge in raw_edges:
                    if raw_edge[0] != '' and raw_edge[0] != '{}'.format(output_variable_node_name):
                        variable = node_variable[raw_edge[0]]
                        if raw_edge[2] != 'dashed':
                            bdd.add_edge(raw_edge[0], raw_edge[1], variable=variable, positive=True)
                        else:
                            bdd.add_edge(raw_edge[0], raw_edge[1], variable=variable, positive=False)

            # Has positive terminal, but does not negative terminal: always true
            elif len(has_terminal_one) > 0 and len(has_terminal_zero) == 0:
                terminal_one = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '1', raw_edges)))[0]
                bdd.add_node('0', variable='0', terminal=True, root=False)
                bdd.add_node(terminal_one, variable='1', terminal=True, root=True, output_variables=[output_variable])
                # bdd.add_edge(output_variable, '1', variable='True', positive=True)
                # set_node_attributes(bdd, {output_variable: output_variable}, "output_variables")
                # # set_node_attributes(bdd, {output_variable: True}, "single_node")
                # set_node_attributes(bdd, {output_variable: 'root'}, "type")
                # set_node_attributes(bdd, {output_variable: 'True'}, "variable")
                # set_node_attributes(bdd, {'1': '1'}, "variable")
                # set_node_attributes(bdd, {'1': 'terminal'}, "type")
                #
                # bdd.add_edge(output_variable, '0', variable='False', positive=False)
                # set_node_attributes(bdd, {'0': '0'}, "variable")
                # set_node_attributes(bdd, {'0': 'terminal'}, "type")
                #
                # directed_graph = bdd.copy(as_view=False)
                #
                # self.benchmark_graph.add_graph(directed_graph)
                #
                # self.directed_graph = disjoint_union(self.directed_graph, directed_graph)

            # Does not have positive terminal, but has negative terminal: always false
            elif len(has_terminal_one) == 0 and len(has_terminal_zero) > 0:
                terminal_zero = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '0', raw_edges)))[0]
                bdd.add_node('0', variable='0', terminal=True, root=False)
                bdd.add_node(terminal_zero, variable='0', terminal=True, root=True, output_variables=[output_variable])
                # bdd.add_edge(output_variable, '0', variable='False', positive=False)
                # set_node_attributes(bdd, {output_variable: output_variable}, "output_variables")
                # # set_node_attributes(bdd, {output_variable: False}, "single_node")
                # set_node_attributes(bdd, {output_variable: 'root'}, "type")
                # set_node_attributes(bdd, {output_variable: 'False'}, "variable")
                # set_node_attributes(bdd, {'0': '0'}, "variable")
                # set_node_attributes(bdd, {'0': 'terminal'}, "type")

                # directed_graph = bdd.copy(as_view=False)
                #
                # self.benchmark_graph.add_graph(directed_graph)
                #
                # self.directed_graph = disjoint_union(self.directed_graph, directed_graph)
            else:
                Exception("BDD must at least have a positive or a negative terminal.")

            directed_graph = bdd.copy(as_view=False)
            self.benchmark_graph.add_graph(directed_graph)
            self.directed_graph = disjoint_union(self.directed_graph, directed_graph)

            bdd_log = ''
            bdd_log += '\tOutput variable: {}\n'.format(output_variable)
            bdd_log += '\tNodes: {}\n'.format(len(bdd.nodes))
            bdd_log += '\tEdges: {}\n'.format(len(bdd.edges))
            bdd_log += '\tBDD show time (s): {}\n'.format(self.bdd_show_times[output_variable])
            self.log += bdd_log

            for line in bdd_log.splitlines():
                print("\t{}".format(line))

        # # Find all terminal one nodes
        # terminal_ones = list(
        #     map(lambda tup: tup[0], filter(lambda tup: tup[1]['type'] == 'terminal' and tup[1]['variable'] == '1',
        #                                    self.directed_graph.nodes(data=True))))
        #
        # if len(terminal_ones) > 0:
        #
        #     # For each terminal one node, remove its incoming edges and connect the edges with the new
        #     # terminal one node
        #     terminal_edges = self.directed_graph.in_edges(terminal_ones, data=True)
        #
        #     n = len(self.directed_graph.nodes)
        #
        #     for (leaf_node, old_terminal_node, attributes) in terminal_edges:
        #         self.directed_graph.add_edge(leaf_node, n + 1, **attributes)
        #
        #     # Add a new terminal one node (sink)
        #     self.directed_graph.nodes[n + 1]['variable'] = '1'
        #     self.directed_graph.nodes[n + 1]['type'] = 'terminal'
        #     self.directed_graph.remove_nodes_from(terminal_ones)
        #
        # if not config.full_bdd:
        #     terminal_zeros = list(
        #         map(lambda tup: tup[0],
        #             filter(lambda tup: tup[1]['type'] == 'terminal' and tup[1]['variable'] == '0',
        #                    self.directed_graph.nodes(data=True))))
        #
        #     self.directed_graph.remove_nodes_from(terminal_zeros)
        #
        # else:
        #     terminal_zeros = list(
        #         map(lambda tup: tup[0], filter(lambda tup: tup[1]['type'] == 'terminal' and tup[1]['variable'] == '0',
        #                                        self.directed_graph.nodes(data=True))))
        #
        #     # For each terminal zero node, remove its incoming edges and connect the edges with the new
        #     # terminal zero node
        #     terminal_edges = self.directed_graph.in_edges(terminal_zeros, data=True)
        #
        #     # n = len(self.directed_graph.nodes)
        #
        #     for (leaf_node, old_terminal_node, attributes) in terminal_edges:
        #         self.directed_graph.add_edge(leaf_node, n + 2, **attributes)
        #
        #     # Add a new terminal one node (sink)
        #     self.directed_graph.nodes[n + 2]['variable'] = '0'
        #     self.directed_graph.nodes[n + 2]['type'] = 'terminal'
        #     self.directed_graph.remove_nodes_from(terminal_zeros)

        print("\tStopped parsing ROBDDs")

        abc_dir = os.listdir(config.abc_path)

        for file in abc_dir:
            if file.endswith(".ps"):
                os.remove(os.path.join(config.abc_path, file))

        config.log.add(self.get_log())
        print("Stopped constructing ROBDDs from benchmark")
        print()

        return self.benchmark_graph
