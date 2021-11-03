from BenchmarkGraph import BenchmarkGraph


class BDDWriter:

    def __init__(self, benchmark_name: str, file_name: str):
        self.benchmark_name = benchmark_name
        self.file_name = file_name

    def write(self, bdd: BenchmarkGraph):
        content = ''
        content += '.model {}\n'.format(self.benchmark_name)
        content += '.inputs {}\n'.format(' '.join(bdd.input_variables))
        content += '.outputs {}\n'.format(' '.join(bdd.output_variables))
        for graph in bdd.get_all_graphs():
            content += '.bdd\n'
            for (node, node_data) in graph.nodes(data=True):
                successors = graph.successors(node)
                positive_child = -1
                negative_child = -1
                for successor in successors:
                    edge_data = graph.get_edge_data(node, successor)
                    if edge_data["positive"]:
                        positive_child = successor
                    else:
                        negative_child = successor
                if node_data["root"]:
                    content += '{} {} {} {} {}\n'.format(node, positive_child, negative_child, node_data["variable"],
                                                         node_data["output_variables"])
                else:
                    content += '{} {} {} {}\n'.format(node, positive_child, negative_child, node_data["variable"])
            content += '.end\n'

        with open(self.file_name, 'w') as f:
            f.write(content)
