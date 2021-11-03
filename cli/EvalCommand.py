import config
from cli.Command import Command
from InstanceFileReader import InstanceFileReader


class EvalCommand(Command):

    def __init__(self, args):
        super().__init__()
        if len(args) < 1:
            raise Exception("Unknown instance file.")
        self.instance_file = args[0]

        # Output file is specified in command following argument "-f"
        if "-f" in args:
            idx = args.index("-f")
            self.output_file = args[idx + 1]
        else:
            self.output_file = None

    def execute(self) -> bool:
        context = config.context_manager.get_context()

        instance_file_reader = InstanceFileReader(self.instance_file)
        instance = instance_file_reader.parse()

        content = ''
        # evaluation = context.crossbar.eval(instance, "1")
        # print(evaluation)
        for formula in context.benchmark.formulas.values():
            evaluation = "{} = {}\n".format(formula.output_variable, formula.eval(instance))
            content += evaluation

        print(content)

        if self.output_file is not None:
            with open(self.output_file, 'w') as f:
                f.write(content)
        return False
