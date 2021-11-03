import os
import subprocess

from BenchmarkGraph import BenchmarkGraph
from abc import ABC, abstractmethod

from networkx import Graph, DiGraph

from Benchmark import Benchmark


class BDDParser(ABC):

    def __init__(self, benchmark: Benchmark):
        self.benchmark = benchmark
        self.benchmark_graph = BenchmarkGraph(benchmark.input_variables, benchmark.output_variables)
        self.undirected_graph = Graph()
        self.directed_graph = DiGraph()
        self.reversed_graph = DiGraph()
        self.bdd_construct_time = None
        self.bdd_show_times = dict()
        self.log = ''

    def _write_dot_file(self, graph, dot_file_name):
        content = ""
        content += "graph sbdd {\n"
        for (u, d) in graph.nodes(data=True):
            if d["root"]:
                variable = d["variable"]
                output_variable = d["output_variables"]
                content += '{}[shape="plaintext"];\n'.format(output_variable)
                content += '{}[label="{}"];\n'.format(u, variable)
                content += '{} -- {};\n'.format(output_variable, u)
            elif d["terminal"]:
                variable = d["variable"]
                content += '{}[label="{}",shape="box"];\n'.format(u, variable)
            else:
                variable = d["variable"]
                content += '{}[label="{}"];\n'.format(u, variable)
        for (u, v, d) in graph.edges(data=True):
            if not d["positive"]:
                content += '{} -- {} [style="dotted"];\n'.format(u, v)
            else:
                content += '{} -- {};\n'.format(u, v)
        content += '}\n'
        with open(dot_file_name, 'w') as f:
            f.write(content)

    def draw(self):
        dot_file_name = "{}.dot".format(self.benchmark.name)
        png_file_name = "{}.png".format(self.benchmark.name)
        self._write_dot_file(self.directed_graph, dot_file_name)
        bash_cmd = 'dot -Tpng {} -o {}'.format(dot_file_name, png_file_name)
        process = subprocess.Popen(['bash'], cwd=os.getcwd(), stdin=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
        process.communicate(str.encode(bash_cmd))

    @abstractmethod
    def parse(self) -> Graph:
        pass

    def get_log(self) -> str:
        return self.log
