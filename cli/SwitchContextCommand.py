import config
from cli.Command import Command


class SwitchContextCommand(Command):

    def __init__(self, args):
        if len(args) < 1:
            raise Exception("No context name provided.")
        self.name = args[0]
        super().__init__()

    def execute(self):
        config.context_manager.switch_context(self.name)
        return False
