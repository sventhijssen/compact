from BenchmarkReader import BenchmarkReader
from cli.Command import Command


class ReadCommand(Command):

    def __init__(self, args):
        super(ReadCommand).__init__()
        if len(args) < 1:
            raise Exception("No file defined.")
        self.relative_file_path = args[0]

    def execute(self):
        benchmark_reader = BenchmarkReader(self.relative_file_path)
        benchmark_reader.read()
        return False
