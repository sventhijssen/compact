from cli.CommandParser import CommandParser


class Program:

    @staticmethod
    def execute(raw_command: str):
        raw_commands = raw_command.split("|")
        for raw_command in raw_commands:
            command = CommandParser.parse(raw_command)
            command.execute()
