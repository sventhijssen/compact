from BooleanFunction import BooleanFunction


class Context:

    def __init__(self, boolean_function: BooleanFunction):
        self.boolean_function = boolean_function
        self.benchmark = self.boolean_function.get_benchmark()
        self.benchmark_graph = self.boolean_function.get_graph()
        self.crossbar = self.boolean_function.get_crossbar()
