from pathlib import Path

import config
from BLIFParser import BLIFParser
from PLAParser import PLAParser
from VerilogParser import VerilogParser


class BenchmarkReader:

    def __init__(self, relative_file_path: str):
        self.file_path = Path(relative_file_path)
        self.log = ''

    def get_log(self) -> str:
        return self.log

    def read(self):
        file_name = self.file_path.name
        [benchmark_name, file_extension] = file_name.split('.')

        if file_extension == "pla":
            benchmark_parser = PLAParser()
        elif file_extension == "blif":
            benchmark_parser = BLIFParser()
        elif file_extension == "v":
            benchmark_parser = VerilogParser()
        else:
            raise Exception("Unsupported file type.")
        print("Started reading benchmark \"{}\"".format(benchmark_name))

        # TODO: Move context to Command
        benchmark_parser.read_file(config.root.joinpath(self.file_path))
        benchmark = benchmark_parser.parse()
        config.context_manager.add_context(benchmark.name, benchmark)

        self.log += 'Benchmark: {}\n'.format(benchmark.name)
        self.log += 'Inputs: {}\n'.format(len(benchmark.input_variables))
        self.log += 'Outputs: {}\n'.format(len(benchmark.output_variables))

        for line in self.log.splitlines():
            print("\t{}".format(line))
        config.log.add(self.get_log())

        print("Stopped reading benchmark")
        print()
