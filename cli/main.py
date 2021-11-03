from cli.CommandParser import CommandParser


def run():
    do_exit = False
    while not do_exit:
        try:
            raw_command = input()
            print(raw_command)
            raw_commands = raw_command.split("|")
            for raw_command in raw_commands:
                command = CommandParser.parse(raw_command)
                if command.execute():
                    do_exit = True
        except Exception as e:
            print(e)


if __name__ == "__main__":
    run()
