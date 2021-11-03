import config
from cli.Command import Command
from Compact import Compact


class COMPACTCommand(Command):

    def __init__(self, args: list):
        super(COMPACTCommand).__init__()

        if "-t" in args:
            idx = args.index("-t")
            config.time_limit = int(args[idx + 1])
        else:
            config.time_limit = None

        if "-keep" in args:
            config.keep_files = True
        else:
            config.keep_files = False

    def execute(self):
        context = config.context_manager.get_context()
        compact = Compact()
        context.crossbar = compact.map(context.benchmark_graph.get_single_graph())
        return False
