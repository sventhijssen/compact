import config
from cli.Command import Command
from COMPACT import COMPACT


class COMPACTCommand(Command):

    def __init__(self, args: list):
        super(COMPACTCommand).__init__()

        if "-gamma" in args:
            idx = args.index("-gamma")
            config.gamma = float(args[idx + 1])
        else:
            config.gamma = 1

        if "-g" in args:
            idx = args.index("-g")
            config.gamma = float(args[idx + 1])
        else:
            config.gamma = 1

        if "-vh" in args:
            config.vh_labeling = True
        else:
            config.vh_labeling = False

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
        compact = COMPACT()
        context.crossbar = compact.map(context.benchmark_graph.get_single_graph())
        return False
