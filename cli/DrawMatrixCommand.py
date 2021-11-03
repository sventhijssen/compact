import config
from cli.Command import Command


class DrawMatrixCommand(Command):

    def __init__(self, args: list):
        super().__init__()
        if len(args) > 0:
            self.name = args[0]
        else:
            ctx = config.context_manager.get_context()
            self.name = ctx.benchmark.name

    def execute(self):
        context = config.context_manager.get_context()
        context.crossbar.draw_matrix(self.name)
        return False
