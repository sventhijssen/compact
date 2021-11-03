import re

from Benchmark import Benchmark
from BenchmarkParser import BenchmarkParser
from Formula import Formula
from ParsingException import ParsingException


class VerilogParser(BenchmarkParser):

    def parse(self):
        [pre_output, _] = self.content.split('output')
        [pre_assign, _] = self.content.split('assign', 1)
        raw_input_variables = re.findall(r'input\s([\s\S]+)+;', pre_output)
        all_input_variables = raw_input_variables[0].replace('\n', ' ').replace(' ', '').split(',')

        raw_output_variables = re.findall(r'output\s([\s\S]+)+;', pre_assign)
        output_variables = raw_output_variables[0].replace('\n', ' ').replace(' ', '').split(',')

        self.benchmark = Benchmark(self.file_path, all_input_variables, output_variables)

        for input_variable in all_input_variables:
            if '<' in input_variable:  # Cannot handle arrays
                raise ParsingException("Unknown character in input variable.")

        for output_variable in output_variables:
            if '<' in output_variable:  # Cannot handle arrays
                raise ParsingException("Unknown character in output variable.")
            formatted_output_variable = output_variable.replace('[', '\[').replace(']', '\]')
            raw_formulae = re.findall(r'assign\s+{}\s+=\s+(.+);'.format(formatted_output_variable), self.content)
            raw_formula = raw_formulae[0]

            if raw_formula == "1\'b0" or raw_formula == "1\'b1":
                input_variables = set()
            else:
                input_variables = list(set(re.findall(r'([\w\d]+)', raw_formula)))
                input_variables.sort()

            formula = Formula(input_variables, output_variable, raw_formula)

            self.benchmark.add_formula(formula)

        return self.benchmark
