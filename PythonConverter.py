from typing import List

from Z3Converter import Z3Converter


class PythonConverter:

    @staticmethod
    def _tree_to_python(lst: List):
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
                new_lst.append(PythonConverter._tree_to_python(lst[i]))
            else:
                new_lst.append(lst[i])
        return new_lst

    @staticmethod
    def _python_replace_brackets(lst: List):
        s = ''
        for i in range(len(lst)):
            if isinstance(lst[i], list):
                s += '(' + PythonConverter._python_replace_brackets(lst[i]) + ')'
            else:
                s += ' ' + lst[i] + ' '
        return s

    @staticmethod
    def _python_replace_logical_operator(raw_string: str):
        return raw_string.replace('~', 'not ').replace('&', 'and').replace('|', 'or')

    @staticmethod
    def _python_to_string(lst: List):
        raw_string = PythonConverter._python_replace_brackets(lst)
        string = PythonConverter._python_replace_logical_operator(raw_string)
        return string

    @staticmethod
    def verilog_to_python_string(verilog_formula: str):
        if verilog_formula == "1\'b0":
            return 'False'
        elif verilog_formula == "1\'b1":
            return 'True'
        else:
            verilog_tree = Z3Converter.verilog_to_tree(verilog_formula)
            python_formula = PythonConverter._tree_to_python(verilog_tree)
            python_formula_string = PythonConverter._python_to_string(python_formula)
            return python_formula_string
