class BenchmarkLog:

    def __init__(self):
        self.approach = None
        self.benchmark = None
        self.input_variables = 0
        self.output_variables = 0
        self.vertices = 0
        self.edges = 0
        self.label_v = 0
        self.label_h = 0
        self.label_vh = 0
        self.rows = 0
        self.columns = 0
        self.cumulative_area = 0
        self.active_variables = 0
        self.variables = 0
        self.time = 0
        self.simulation_size = 0
        self.min_true_signal = 0
        self.max_false_signal = 0
        self.avg_true_signal = 0
        self.avg_false_signal = 0
        self.subformula = dict()

    def write(self):
        with open(self.benchmark + '_' + self.approach + '.txt', 'w') as f:
            f.write('Benchmark: {}\n'.format(self.benchmark))
            f.write('Approach: {}\n'.format(self.approach))
            f.write('Input: {}\n'.format(self.input_variables))
            f.write('Output: {}\n'.format(self.output_variables))
            f.write('Vertices: {}\n'.format(self.vertices))
            f.write('Edges: {}\n'.format(self.edges))
            f.write('Label V: {}\n'.format(self.label_v))
            f.write('Label H: {}\n'.format(self.label_h))
            f.write('Label VH: {}\n'.format(self.label_vh))
            f.write('Rows: {}\n'.format(self.rows))
            f.write('Columns: {}\n'.format(self.columns))
            f.write('Cumulative area: {}\n'.format(self.cumulative_area))
            f.write('Active variables: {}\n'.format(self.active_variables))
            f.write('Variables: {}\n'.format(self.variables))
            f.write('Time: {}\n'.format(self.time))
            f.write('Simulation size: {}\n'.format(self.simulation_size))
            f.write('Minimum true signal: {:.2E}\n'.format(self.min_true_signal))
            f.write('Maximum false signal: {:.2E}\n'.format(self.max_false_signal))
            f.write('Average true signal: {:.2E}\n'.format(self.avg_true_signal))
            f.write('Average false signal: {:.2E}\n'.format(self.avg_false_signal))
            f.write('\n')
            for k, v in self.subformula.items():
                f.write('Output: {}\n'.format(k))
                f.write('\tUnique variables: {}\n'.format(len(v["input_variables"])))
                f.write('\tUnique variables/Area: {0:.2f}%\n'.format(len(v["input_variables"]) / (v["rows"] * v["columns"]) * 100))
                f.write('\tRows: {}\n'.format(v["rows"]))
                f.write('\tColumns: {}\n'.format(v["columns"]))
                f.write('\tArea: {}\n'.format(v["rows"] * v["columns"]))
                f.write('\tActive memristors: {}\n'.format(v["active_memristors"]))
                f.write('\tDensity: {0:.2f}%\n'.format(v["active_memristors"] / (v["rows"] * v["columns"]) * 100))
