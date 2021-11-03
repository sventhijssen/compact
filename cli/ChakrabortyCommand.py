import config
from ChakrabortyMappingMethod import ChakrabortyMappingMethod
from cli.Command import Command


class ChakrabortyCommand(Command):

    def __init__(self):
        super(ChakrabortyCommand).__init__()

    def execute(self):
        context = config.context_manager.get_context()
        chakraborty = ChakrabortyMappingMethod()
        context.crossbar = chakraborty.map(context.benchmark_graph.get_single_graph())
        return False
