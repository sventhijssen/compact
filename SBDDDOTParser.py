import itertools
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


class SBDDDOTParser(BDDParser):

    def __init__(self, benchmark: Benchmark):
        super(SBDDDOTParser, self).__init__(benchmark)
        if benchmark.model is not None:
            self.dot_file = config.abc_path.joinpath('{}.dot'.format(benchmark.model))
        else:
            self.dot_file = config.abc_path.joinpath('{}.dot'.format(benchmark.name))
        self.abc_file_path = config.abc_path.joinpath(self.benchmark.file_path.name)
        self.bdd_show_time = 0
        self.dot_bdd = None
        if self.dot_file.exists():
            os.remove(self.dot_file)

    def _write_files(self):
        print("\tStarted ABC")
        file_name = self.benchmark.file_path.name

        bdd_construct_start_time = time.time()
        process = pexpect.spawn(config.abc_cmd, cwd=str(config.abc_path))
        process.sendline('read "{}"; collapse;'.format(file_name))

        try:
            if config.time_limit_bdd is not None:
                index = process.expect(['abc 03'], timeout=config.time_limit_bdd)
            else:
                index = process.expect(['abc 03'], timeout=config.time_limit_bdd)
            bdd_construct_stop_time = time.time()

            self.bdd_construct_time = bdd_construct_stop_time - bdd_construct_start_time

            self.log += 'BDD construct time (s): {}\n'.format(self.bdd_construct_time)

            if index == 0:

                bdd_show_start_time = time.time()
                abc_cmd = 'show_bdd -g;'
                process.sendline(abc_cmd)
                while not self.dot_file.exists():
                    pass
                bdd_show_stop_time = time.time()
                self.bdd_show_time = bdd_show_stop_time - bdd_show_start_time
                time.sleep(1)

                dot_bdd = self._read_file()
                if self.dot_file.exists():
                    os.remove(self.dot_file)
                while self.dot_file.exists():
                    pass
                time.sleep(1)

                print("\tStopped ABC")
                return dot_bdd
        except EOF:
            raise Exception("\tABC EOF error.\n")
        except TIMEOUT:
            self.log += 'BDD construct time (s): {}\n'.format(config.time_limit_bdd)
            self.log += 'Timeout'
            config.log.add(self.get_log())
            raise Exception("\tABC timeout error.\n")

    def _read_file(self):
        dot_content = ""
        with open(self.dot_file, 'r') as file:
            for line in file:
                dot_content += line
        return dot_content

    def parse(self) -> Graph:
        global output_variables
        print("Started constructing SBDDs from benchmark")
        print("\t{}".format(datetime.now()))

        self.log += 'BDD type: SBDD\n'

        # Copy the file from its current location to abc folder
        shutil.copy(self.benchmark.file_path, self.abc_file_path)

        # Generate BDD using ABC
        dot_content = self._write_files()

        print("\tStarted parsing SBDD")

        bdd = DiGraph()

        # Get the names of the nodes and the values on which they are mapped
        raw_layers = list(re.findall(r'{\s*rank\s*=\s*same;([^}]+);\n}', dot_content))

        layers = []
        for raw_layer in raw_layers:
            layers.append(raw_layer.replace(' ', '').replace('\n', '').replace('"', '').split(';'))

        # Remove function output
        layers = layers[:-1]

        # Strip the 'rank' and 'node' objects
        stripped_content = re.sub(r'{\s(?:rank|node)[^}]+}', '', dot_content)

        node_variable = dict()

        raw_output_variable_nodes = re.findall(r'"\s*([\w\d\[\]]+)\s*"\s->\s"([\w\d]+)"\s\[style\s=\ssolid\]',
                                               stripped_content)
        raw_output_variable_nodes = [(i[1], i[0]) for i in raw_output_variable_nodes]
        output_variable_nodes = dict()
        for raw_output_variable_node in raw_output_variable_nodes:
            node = raw_output_variable_node[0]
            output_variable = raw_output_variable_node[1]
            if node in output_variable_nodes:
                output_variable_nodes[node].append(output_variable)
            else:
                output_variable_nodes[node] = [output_variable]

        # Find all edges defined by NODE -> NODE with optional [STYLE] parameter and
        # leave nodes, defined by NODE [LABEL]
        raw_edges = re.findall(
            r'"([\w\d\s\[\]]+)"\s->\s"([\w\d\s]+)"(?:\s\[style\s=\s(solid|dashed)\])?|"([\w\d\s]+)"\s\[label\s=\s"(\d)"\]',
            stripped_content)

        # Build BDD (directed graph) by adding the nodes
        for i in range(len(layers)):
            layer = layers[i]
            input_variable = layer[0]
            nodes = layer[1:]
            for node in nodes:
                node_variable[node] = layer[0]
                if node in output_variable_nodes:
                    output_vars = output_variable_nodes[node]
                    bdd.add_node(node, output_variables=output_vars, variable=input_variable, terminal=False, root=True)
                else:
                    bdd.add_node(node, variable=input_variable, terminal=False, root=False)

        has_terminal_zero = list(filter(lambda tup: tup[4] == '0', raw_edges))
        has_terminal_one = list(filter(lambda tup: tup[4] == '1', raw_edges))

        # Normal BDD
        if len(has_terminal_one) > 0 and len(has_terminal_zero) > 0:
            terminal_one = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '1', raw_edges)))[0]
            terminal_zero = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '0', raw_edges)))[0]

            bdd.add_node(terminal_one, variable='1', terminal=True, root=False)
            bdd.add_node(terminal_zero, variable='0', terminal=True, root=False)

            output_variables = list(itertools.chain(*output_variable_nodes.values()))

            formatted_output_variables = ['  {}  '.format(output_variable) for output_variable in output_variables]

            # Add the edges of the graph
            for raw_edge in raw_edges:
                if raw_edge[0] != '' and raw_edge[0] not in formatted_output_variables:
                    variable = node_variable[raw_edge[0]]
                    if raw_edge[2] != 'dashed':
                        bdd.add_edge(raw_edge[0], raw_edge[1], variable=variable, positive=True)
                    else:
                        bdd.add_edge(raw_edge[0], raw_edge[1], variable=variable, positive=False)

            # We set the output variables for the terminal nodes
            if terminal_one in output_variable_nodes:
                output_vars = output_variable_nodes[terminal_one]
                set_node_attributes(bdd, {terminal_one: output_vars}, "output_variables")
                set_node_attributes(bdd, {terminal_one: True}, "root")
            if terminal_zero in output_variable_nodes:
                output_vars = output_variable_nodes[terminal_zero]
                set_node_attributes(bdd, {terminal_zero: output_vars}, "output_variables")
                set_node_attributes(bdd, {terminal_zero: True}, "root")

        # Has positive terminal, but does not negative terminal: always true
        elif len(has_terminal_one) > 0 and len(has_terminal_zero) == 0:
            terminal_one = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '1', raw_edges)))[0]
            output_variables = output_variable_nodes[terminal_one]
            bdd.add_node('0', variable='0', terminal=True, root=False)
            bdd.add_node(terminal_one, variable='1', terminal=True, root=True, output_variables=output_variables)

        # Does not have positive terminal, but has negative terminal: always false
        elif len(has_terminal_one) == 0 and len(has_terminal_zero) > 0:
            terminal_zero = list(map(lambda tup: list(tup)[3], filter(lambda tup: tup[4] == '0', raw_edges)))[0]
            output_variables = output_variable_nodes[terminal_zero]
            bdd.add_node('1', variable='1', terminal=True, root=False)
            bdd.add_node(terminal_zero, variable='0', terminal=True, root=True, output_variables=output_variables)
        else:
            Exception("BDD must at least have a positive or a negative terminal.")

        directed_graph = bdd.copy(as_view=False)
        self.benchmark_graph.add_graph(directed_graph)
        self.directed_graph = disjoint_union(self.directed_graph, directed_graph)

        bdd_log = ''
        bdd_log += '\tOutput variables: {}\n'.format(', '.join(output_variables))
        bdd_log += '\tNodes: {}\n'.format(len(bdd.nodes))
        bdd_log += '\tEdges: {}\n'.format(len(bdd.edges))
        bdd_log += '\tBDD show time (s): {}\n'.format(self.bdd_show_time)
        self.log += bdd_log

        for line in bdd_log.splitlines():
            print("\t{}".format(line))

        print("\tStopped parsing SBDD")

        abc_dir = os.listdir(config.abc_path)

        for file in abc_dir:
            if file.endswith(".ps"):
                os.remove(os.path.join(config.abc_path, file))

        config.log.add(self.get_log())
        print("Stopped constructing SBDD from benchmark")
        print()

        return self.benchmark_graph
