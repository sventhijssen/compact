import itertools
import re

from pyparsing import Word, alphanums, oneOf, Literal, Suppress, Forward, Group, ZeroOrMore

import config
from Z3Converter import Z3Converter


class VerilogParser:

    def __init__(self):
        self.content = ''
        self.bdds = dict()
        self.z3_formulas = dict()
        self.python_formulas = dict()
        self.partial_input_variables = dict()

    def read_file(self, file_name):
        file = open(file_name, 'r')
        self.content = file.read()
        file.close()

    def parse(self):
        [pre_output, _] = self.content.split('output')
        [pre_assign, _] = self.content.split('assign', 1)
        raw_input_variables = re.findall(r'input\s([\s\S]+)+;', pre_output)
        all_input_variables = raw_input_variables[0].replace('\n', ' ').replace(' ', '').split(',')

        if config.model_checking:
            monolithic_truth_table = list(map(lambda x: list(x), list(itertools.product([False, True], repeat=len(all_input_variables)))))
        else:
            monolithic_truth_table = []

        raw_output_variables = re.findall(r'output\s([\s\S]+)+;', pre_assign)
        output_variables = raw_output_variables[0].replace('\n', ' ').replace(' ', '').split(',')

        for output_variable in output_variables:
            raw_formulae = re.findall(r'assign\s{}\s=\s(.+);'.format(output_variable), self.content)
            raw_formula = raw_formulae[0]

            if raw_formula == "1'b0" or raw_formula == "1'b1":
                input_variables = set()
                if raw_formula == "1'b0":
                    self.z3_formulas[output_variable] = False
                    self.python_formulas[output_variable] = [False]
                else:
                    self.z3_formulas[output_variable] = True
                    self.python_formulas[output_variable] = [True]
            else:
                input_variables = list(set(re.findall(r'([\w\d]+)', raw_formula)))
                input_variables.sort()

            self.partial_input_variables[output_variable] = input_variables

            if config.model_checking:
                if len(input_variables) == 0:
                    if raw_formula == "1'b0":
                        truth_table = [False]
                    else:
                        truth_table = [True]
                else:
                    # Source: https://stackoverflow.com/questions/6336424/python-build-a-dynamic-growing-truth-table
                    # Documentation: https://docs.python.org/3.8/library/itertools.html#itertools.product
                    truth_table = list(map(lambda x: list(x), list(itertools.product([False, True], repeat=len(input_variables)))))
            else:
                truth_table = []

            if len(input_variables) != 0:

                # Begin Source: https://stackoverflow.com/questions/27527087/parsing-nested-ternary-expressions
                # Author: PaulMcG
                # Published on: December 18, 2014
                # Accessed on: June 11, 2020

                # variable = Word(alphanums+'_~')
                # bool_op = oneOf("^ | &")
                # QM, COLON = map(Literal, "?:")
                # expr = infixNotation(variable,
                #                      [
                #                          (bool_op, 2, opAssoc.LEFT),
                #                          ((QM, COLON), 3, opAssoc.LEFT),
                #                      ])
                # result = expr.parseString(raw_formula).asList()

                # Begin Source (1): https://stackoverflow.com/questions/37925803/parserelement-enablepackrat-doesnt-make-infixnotation-faster
                # Author: PaulMcG
                # Published on: June 20, 2016
                # Accessed on: July 15, 2020
                # Begin Source (2): https://stackoverflow.com/questions/23879784/parse-mathematical-expressions-with-pyparsing
                # Author: PaulMcG
                # Published on: May 20, 2014
                # Visited on: July 15, 2020
                LPAR, RPAR = map(Suppress, '()')
                expr = Forward()
                variable = Word(alphanums + '_~')
                nested = variable | Group(LPAR + expr + RPAR)
                binary_op = nested + ZeroOrMore(oneOf('^ | &') + nested)
                ternary_op = nested + Literal('?') + nested + Literal(':') + nested
                formula_expr = ternary_op | binary_op
                expr <<= formula_expr

                result = [expr.parseString(raw_formula).asList()]
                result_b = result.copy()
                self.python_formulas[output_variable] = result
                # End Source

                # Convert formula to Z3
                self.z3_formulas[output_variable] = Z3Converter.verilog_to_z3(result_b)

                def replace(lst):
                    if len(lst) == 3 and lst[1] == '^':
                        left = lst[0]
                        right = lst[2]
                        lst = ['bool(', left, ')', 'is not', 'bool(', right, ')']
                    if len(lst) == 5 and lst[1] == '?':
                        cond = lst[0]
                        true_stmt = lst[2]
                        false_stmt = lst[4]
                        lst = [true_stmt, 'if', cond, 'else', false_stmt]
                    new_lst = []
                    for i in range(len(lst)):
                        if isinstance(lst[i], list):
                            new_lst.append(replace(lst[i]))
                        else:
                            new_lst.append(lst[i])
                    return new_lst
                a = replace(result)

                def to_string(lst):
                    s = ''
                    for i in range(len(lst)):
                        if isinstance(lst[i], list):
                            s += '(' + to_string(lst[i]) + ')'
                        else:
                            s += ' ' + lst[i] + ' '
                    return s
                reordered_formula = to_string(a)

                formula = reordered_formula.replace('~', 'not ').replace('&', 'and').replace('|', 'or')

                if config.model_checking:
                    for i in range(len(monolithic_truth_table)):
                        formula_instance = formula
                        for j in range(len(all_input_variables)):
                            formula_instance = re.sub(r'\b%s\b' % all_input_variables[j], str(monolithic_truth_table[i][j]), formula_instance)
                        monolithic_truth_table[i].append(eval(formula_instance))

                    for i in range(len(truth_table)):
                        formula_instance = formula
                        for j in range(len(input_variables)):
                            formula_instance = re.sub(r'\b%s\b' % input_variables[j], str(truth_table[i][j]), formula_instance)
                        truth_table[i].append(eval(formula_instance))

                if config.simulate:
                    for j in range(len(all_input_variables)):
                        v = config.simulation_instance[all_input_variables[j]]
                        monolithic_truth_table.append(v)
                    formula_instance = formula
                    for key, value in config.simulation_instance.items():
                        formula_instance = re.sub(r' %s ' % key, ' %s ' % str(value), formula_instance)

                    monolithic_truth_table.append(eval(formula_instance))

            else:
                if config.model_checking:
                    for i in range(len(monolithic_truth_table)):
                        monolithic_truth_table[i].append(truth_table[0])

            self.bdds[output_variable] = [input_variables, truth_table]

        return [self.bdds, all_input_variables, output_variables, monolithic_truth_table]