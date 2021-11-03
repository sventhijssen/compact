import config
from cli.Command import Command


class ListCommand(Command):
    """

    """

    def __init__(self, args):
        """
        Initialize a list of commands.
        :param args:
        """
        super().__init__()
        self.long = False
        if "-l" in args:
            self.long = True

    def execute(self):
        for (name, context) in config.context_manager.contexts.items():
            print("\t{}".format(name))
            if self.long:
                for formula in context.benchmark_filename.formulas.values():
                    print("\t\t{}".format(formula))
        return False
