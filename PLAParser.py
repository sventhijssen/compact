import re
from typing import Dict, List

from Benchmark import Benchmark
from BenchmarkParser import BenchmarkParser


class PLAParser(BenchmarkParser):

    @staticmethod
    def _prettify(lines: List, components: Dict, keyword: str):
        [start, stop] = components.get(keyword)
        raw_content = lines[start:stop + 1]
        raw_content = ''.join(raw_content)
        return raw_content.replace(".{}".format(keyword), "").replace("\\", "")

    def parse(self):
        # Important: ilb and ob do not always exist.
        # ABC will automatically generate input variables and output variables.
        # If .i = PI and .ilb is absent, then the input variables are of the form:
        # x0 x1 ... xPI
        # If .o = PI and .ob is absent, then the output variables are of the form:
        # z0 z1 ... zPI
        keywords = ["ilb", "ob", "i", "o", "p"]
        raw_lines = self.content.split("\n")

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
                    break
                elif not line.startswith('.') and not line.startswith('#'):
                    if current_keyword is not None:
                        components[current_keyword].append(i - 1)
                    halt = True

        model = None
        input_variables = []
        output_variables = []
        for keyword in keywords:
            if keyword == "ilb" and keyword in components:
                pretty_content = self._prettify(lines, components, keyword)
                input_variables = re.findall(r'([\w\d]+)', pretty_content)
            elif keyword == "ob" and keyword in components:
                pretty_content = self._prettify(lines, components, keyword)
                output_variables = re.findall(r'([\w\d]+)', pretty_content)
            elif keyword == "i" and "ilb" not in components:
                pretty_content = self._prettify(lines, components, keyword)
                nr_inputs = int(re.findall(r'(\d+)', pretty_content)[0])
                nr_char = len(str(nr_inputs - 1))
                fmt = '0{}d'.format(nr_char)
                input_variables = [f'x{i:{fmt}}' for i in range(nr_inputs)]
            elif keyword == "o" and "ob" not in components:
                pretty_content = self._prettify(lines, components, keyword)
                nr_outputs = int(re.findall(r'(\d+)', pretty_content)[0])
                nr_char = len(str(nr_outputs - 1))
                fmt = '0{}d'.format(nr_char)
                output_variables = [f'z{i:{fmt}}' for i in range(nr_outputs)]

        self.benchmark = Benchmark(self.file_path, input_variables, output_variables)

        return self.benchmark
