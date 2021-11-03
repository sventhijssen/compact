import re
from typing import List, Dict

from networkx import DiGraph, set_node_attributes

import config
from BenchmarkGraph import BenchmarkGraph


class BDDReader:

    def __init__(self, file_name: str):
        self.file_name = file_name
        self.benchmark_graph = None
        self.log = ''

    def get_log(self) -> str:
        return self.log

    @staticmethod
    def _prettify(lines: List, components: Dict, keyword: str):
        [start, stop] = components.get(keyword)
        raw_content = lines[start:stop + 1]
        raw_content = ''.join(raw_content)
        return raw_content.replace(".{}".format(keyword), "").replace("\\", "")

    def read(self):
        with open(self.file_name, "r") as f:
            content = f.read()

        keywords = ["model", "inputs", "outputs", "bdd"]
        raw_lines = content.split("\n")

        # We strip the comment lines
        lines = []
        for line in raw_lines:
            if not line.startswith("#"):
                lines.append(line)

        components = dict()
        current_keyword = None
        halt = False
        for i in range(len(lines)):
            if halt:
                break
            line = lines[i]
            for keyword in keywords:
                if halt:
                    break
                if line.startswith(".{}".format(keyword)):
                    components[keyword] = [i]
                    if current_keyword is not None:
                        components[current_keyword].append(i - 1)
                    current_keyword = keyword

                    if keyword == "bdd":
                        halt = True

        pretty_content = self._prettify(lines, components, "inputs")
        input_variables = re.findall(r'([\w\d\[\]]+)', pretty_content)
        pretty_content = self._prettify(lines, components, "outputs")
        output_variables = re.findall(r'([\w\d\[\]]+)', pretty_content)

        self.benchmark_graph = BenchmarkGraph(input_variables, output_variables)
        self.benchmark_graph.name = lines[0][7:]

        lines = lines[components["bdd"][0]:]

        node_attrs = dict()
        bdd = None
        output_variables = []
        for i in range(len(lines)):
            line = lines[i]
            if len(line) == 0:
                continue
            elif line.startswith(".bdd"):
                bdd = DiGraph()
            elif line.startswith(".end"):
                set_node_attributes(bdd, node_attrs)
                self.benchmark_graph.add_graph(bdd)
                bdd_log = ''
                bdd_log += '\tOutput variable: {}\n'.format(output_variables)
                bdd_log += '\tNodes: {}\n'.format(len(bdd.nodes))
                bdd_log += '\tEdges: {}\n'.format(len(bdd.edges))
                self.log += bdd_log

                for line in bdd_log.splitlines():
                    print("\t{}".format(line))
            else:
                line_items = line.split()

                if line_items[3] == "True":
                    output_variables.append(line_items[4])
                    bdd.add_node("1", terminal=True, root=True, variable=line_items[4], output_variables=output_variables)
                elif line_items[3] == "False":
                    output_variables.append(line_items[4])
                    bdd.add_node("0", terminal=True, root=True, variable=line_items[4], output_variables=output_variables)
                    bdd.add_node(output_variables[0], terminal=False, root=True, variable=line_items[4],
                                 output_variables=output_variables)
                    bdd.add_edge(output_variables[0], "0", variable="False", positive="False")
                else:
                    if line_items[1] != '-1':
                        bdd.add_edge(line_items[0], line_items[1], variable=line_items[3], positive=True)
                    if line_items[2] != '-1':
                        bdd.add_edge(line_items[0], line_items[2], variable=line_items[3], positive=False)

                    # TODO: Make sure that a function that always evaluates True/False is correctly parsed
                    if len(line_items) == 5:  # We have a root node
                        output_variables.append(line_items[4])
                        node_attrs[line_items[0]] = {"terminal": False, "root": True, "variable": line_items[3],
                                                     "output_variables": output_variables}
                    if line_items[3] == '1' or line_items[3] == '0':
                        node_attrs[line_items[0]] = {"terminal": True, "root": False, "variable": line_items[3], "output_variables": []}
                    else:
                        node_attrs[line_items[0]] = {"terminal": False, "root": False, "variable": line_items[3], "output_variables": []}

        config.log.add(self.get_log())
        single_graph = self.benchmark_graph.get_single_graph()
        print(len(single_graph.nodes))
        print(len(single_graph.edges))

        return self.benchmark_graph
