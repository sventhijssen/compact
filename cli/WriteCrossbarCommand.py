from typing import List

import config
from cli.Command import Command
from CrossbarWriter import CrossbarWriter


class WriteCrossbarCommand(Command):

    def __init__(self, args: List[str]):
        super().__init__()
        if len(args) < 1:
            raise Exception("No filename defined.")
        self.file_name = args[0]

    def execute(self) -> bool:
        context = config.context_manager.get_context()
        cw = CrossbarWriter(context.crossbar, self.file_name)
        cw.write()
        return False
