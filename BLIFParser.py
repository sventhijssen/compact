import re
from typing import Dict, List

from Benchmark import Benchmark
from BenchmarkParser import BenchmarkParser


class BLIFParser(BenchmarkParser):

    @staticmethod
    def _prettify(lines: List, components: Dict, keyword: str):
        [start, stop] = components.get(keyword)
        raw_content = lines[start:stop + 1]
        raw_content = ''.join(raw_content)
        return raw_content.replace(".{}".format(keyword), "").replace("\\", "")

    def parse(self):
        keywords = ["model", "inputs", "outputs", "names"]
        raw_lines = self.content.split("\n")

        # We strip the comment lines
        lines = []
        for line in raw_lines:
            if not line.startswith("#"):
                lines.append(line)

        components = dict()
        current_keyword = None
        for i in range(len(lines)):
            line = lines[i]
            for keyword in keywords:
                if line.startswith(".{}".format(keyword)):
                    components[keyword] = [i]
                    if current_keyword is not None:
                        components[current_keyword].append(i - 1)
                    current_keyword = keyword

        model = None
        input_variables = []
        output_variables = []
        for keyword in keywords:
            if keyword == "model":
                pretty_content = self._prettify(lines, components, keyword)
                model = pretty_content.strip()
            if keyword == "inputs":
                pretty_content = self._prettify(lines, components, keyword)
                input_variables = re.findall(r'([\w\d\[\]\(\)\-_]+)', pretty_content)
            elif keyword == "outputs":
                pretty_content = self._prettify(lines, components, keyword)
                output_variables = re.findall(r'([\w\d\[\]\(\)\-_]+)', pretty_content)

        self.benchmark = Benchmark(self.file_path, input_variables, output_variables)
        if model is not None:
            self.benchmark.model = model

        return self.benchmark
