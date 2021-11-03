import config
from BDDReader import BDDReader
from cli.Command import Command


class ReadBDDCommand(Command):

    def __init__(self, args):
        super().__init__()
        if len(args) < 1:
            raise Exception("File name must be defined.")
        self.file_name = args[0]

    def execute(self) -> bool:
        r = BDDReader(self.file_name)
        bdd = r.read()
        config.context_manager.add_context(bdd.name, bdd)
        config.context_manager.get_context(bdd.name).benchmark_graph = bdd
        return False
