import config
from Log import Log
from cli.Command import Command


class NewLogCommand(Command):

    def __init__(self, args):
        super().__init__()
        if len(args) < 1:
            raise Exception("No filename defined.")
        self.file_name = args[0]

    def execute(self) -> bool:
        config.log = Log(self.file_name)
        return False
