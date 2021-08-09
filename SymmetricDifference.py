import copy
import random
from queue import Queue
from typing import List
from MemristorGraph.MemristorGraph import MemristorGraph
from MemristorGraph.MemristorNode import MemristorNode
from Memristor import Memristor


class SymmetricDistance:

    @staticmethod
    def evaluate(rows: int, columns: int, crossbar: List[List[Memristor]], input_variables: List[str], truth_instance: List[int]):
        matrix_instance = copy.deepcopy(crossbar)
        for r in range(rows):
            for c in range(columns):
                variable_name = matrix_instance[r][c].literal.atom
                if variable_name != "True" and variable_name != "False":
                    variable_index = input_variables.index(variable_name)
                    if not truth_instance[variable_index]:
                        matrix_instance[r][c].literal = matrix_instance[r][c].literal.negate()

        graph = MemristorGraph(rows, columns)

        start_node = None

        # The algorithm starts in the last row looking for node_a node that is ON
        for c in range(columns):
            next_node = matrix_instance[rows - 1][c]
            if next_node.literal.positive:
                start_node = MemristorNode(rows - 1, c)
                graph.add_node(start_node)
                break

        # Build node_a graph from the nodes which are ON
        for r in range(rows):
            for c in range(columns):
                node = matrix_instance[r][c]
                if node.literal.positive:
                    graph.add_node(MemristorNode(node.row, node.column))

        # Breadth-first search
        # The set visited will contain all reachable active nodes from the crossbar instance
        q = Queue()
        if start_node is not None:
            q.put(start_node)
        visited = set()

        parents = dict()

        while not q.empty():
            node = q.get()
            for adjacent_node in node.adjacent_nodes:
                if adjacent_node not in visited:
                    parents[adjacent_node] = node
                    visited.add(adjacent_node)
                    q.put(adjacent_node)

        # Get all rows which can be reached
        active_rows = set(map(lambda n: n.row, visited))

        return 0 in active_rows

    @staticmethod
    def sample(rows: int, columns: int, crossbar: List[List[Memristor]], input_variables: List[str], truth_table: List[List[int]], sample_size: float = 0.2):
        nr_samples = int(sample_size * len(truth_table))

        samples = random.sample(truth_table, nr_samples)

        total_error = 0

        # For each instance, instantiate the matrix
        for truth_instance in samples:
            instance_error = 0
            matrix_instance = copy.deepcopy(crossbar)
            for r in range(rows):
                for c in range(columns):
                    variable_name = matrix_instance[r][c].literal.atom
                    if variable_name != "True" and variable_name != "False":
                        variable_index = input_variables.index(variable_name)
                        if not truth_instance[variable_index]:
                            matrix_instance[r][c].literal = matrix_instance[r][c].literal.negate()

            # print('\n')
            # print('\n'.join([''.join(['{:4}\t\t'.format(str(item)) for item in row]) for row in
            #                  matrix]))
            # print('\n')
            # print('\n'.join([''.join(['{:4}\t\t'.format(str(item.literal.positive)) for item in row]) for row in
            #                  matrix_instance]))

            graph = MemristorGraph(rows, columns)

            start_node = None

            # The algorithm starts in the last row looking for node_a node that is ON
            for c in range(columns):
                next_node = matrix_instance[rows - 1][c]
                if next_node.literal.positive:
                    start_node = MemristorNode(rows - 1, c)
                    graph.add_node(start_node)
                    break

            # Build node_a graph from the nodes which are ON
            for r in range(rows):
                for c in range(columns):
                    node = matrix_instance[r][c]
                    if node.literal.positive:
                        graph.add_node(MemristorNode(node.row, node.column))

            # Breadth-first search
            # The set visited will contain all reachable active nodes from the crossbar instance
            q = Queue()
            if start_node is not None:
                q.put(start_node)
            visited = set()

            parents = dict()

            while not q.empty():
                node = q.get()
                for adjacent_node in node.adjacent_nodes:
                    if adjacent_node not in visited:
                        parents[adjacent_node] = node
                        visited.add(adjacent_node)
                        q.put(adjacent_node)

            # Get all rows which can be reached
            active_rows = set(map(lambda n: n.row, visited))

            offset = len(input_variables)

            output = truth_instance[offset:]

            for o in range(len(output)):
                value = bool(output[o])
                if value and o not in active_rows:
                    instance_error += 1
                if not value and o in active_rows:
                    instance_error += 1

            # print(output)
            # print(active_rows)
            # print('\n')

            # lg = LatexGenerator()
            # lg.draw_instance(rows, columns, matrix_instance, truth_instance, parents)

            total_error += instance_error

        # print(total_error)

        return [total_error, len(samples)]

    @staticmethod
    def is_valid(rows: int, columns: int, crossbar: List[List[Memristor]], input_variables: List[str], truth_table: List[List[int]]):
        """
        The fitness function is computed as the Manhattan Distance between the computed output and the correct output.
        For each possible combination of input, we compute the output. If number of inputs x is N, the we have 2^N
        checks to perform.
        Thus, error = sum(abs(y_computed(i) - y_actual(i))). 
        :param crossbar: 
        :param output_variables: 
        :param input_variables: 
        :param truth_table: 
        :param columns: 
        :param rows: 
        :return: 
        """""

        if len(input_variables) == 0:
            return 0

        total_error = 0

        # For each instance, instantiate the matrix
        for truth_instance in truth_table:
            instance_error = 0
            matrix_instance = copy.deepcopy(crossbar)
            for r in range(rows):
                for c in range(columns):
                    variable_name = matrix_instance[r][c].literal.atom
                    if variable_name != "True" and variable_name != "False":
                        variable_index = input_variables.index(variable_name)
                        if not truth_instance[variable_index]:
                            matrix_instance[r][c].literal = matrix_instance[r][c].literal.negate()

            # print('\n')
            # print('\n'.join([''.join(['{:4}\t\t'.format(str(item)) for item in row]) for row in
            #                  matrix]))
            # print('\n')
            # print('\n'.join([''.join(['{:4}\t\t'.format(str(item.literal.positive)) for item in row]) for row in
            #                  matrix_instance]))

            graph = MemristorGraph(rows, columns)

            start_node = None

            # The algorithm starts in the last row looking for node_a node that is ON
            for c in range(columns):
                next_node = matrix_instance[rows - 1][c]
                if next_node.literal.positive:
                    start_node = MemristorNode(rows - 1, c)
                    graph.add_node(start_node)
                    break

            # Build node_a graph from the nodes which are ON
            for r in range(rows):
                for c in range(columns):
                    node = matrix_instance[r][c]
                    if node.literal.positive:
                        graph.add_node(MemristorNode(node.row, node.column))

            # Breadth-first search
            # The set visited will contain all reachable active nodes from the crossbar instance
            q = Queue()
            if start_node is not None:
                q.put(start_node)
            visited = set()

            parents = dict()

            while not q.empty():
                node = q.get()
                for adjacent_node in node.adjacent_nodes:
                    if adjacent_node not in visited:
                        parents[adjacent_node] = node
                        visited.add(adjacent_node)
                        q.put(adjacent_node)

            # Get all rows which can be reached
            active_rows = set(map(lambda n: n.row, visited))

            offset = len(input_variables)

            output = truth_instance[offset:]

            for o in range(len(output)):
                value = bool(output[o])
                if value and o not in active_rows:
                    instance_error += 1
                if not value and o in active_rows:
                    instance_error += 1

            # print(output)
            # print(active_rows)
            # print('\n')

            # lg = LatexGenerator()
            # lg.draw_instance(rows, columns, matrix_instance, truth_instance, parents)

            total_error += instance_error

        # print(total_error)

        return total_error
