from PythonConverter import PythonConverter


class Formula:

    def __init__(self, inputs, output, verilog):
        self.input_variables = inputs
        self.output_variable = output
        self.verilog = verilog

    def eval(self, instance: dict):
        formula_instance = PythonConverter.verilog_to_python_string(self.verilog)

        for (input_variable, value) in instance.items():
            formula_instance = formula_instance.replace(input_variable, str(value))
        return eval(formula_instance)

    def __str__(self):
        return self.output_variable + ' = ' + self.verilog

    def __repr__(self):
        return str(self)
