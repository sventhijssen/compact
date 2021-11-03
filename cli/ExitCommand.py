from cli.Command import Command


class ExitCommand(Command):

    def __init__(self):
        super(ExitCommand).__init__()

    def execute(self) -> bool:
        return True
