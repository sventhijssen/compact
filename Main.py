import ast
import sys

import config
from Chakraborty import Chakraborty
from ROBDD import ROBDD
from SBDD import SBDD


def main(args):

    if len(args) < 1:
        raise Exception("No synthesis approach defined")

    if len(args) < 2:
        raise Exception("No file defined")

    approach = args[1]
    file_path = args[2]

    if "-l" in args:
        config.log = True

    if "-m" in args:
        model_checking = True
    else:
        model_checking = False

    if "-d" in args:
        config.draw = True
        draw = True
    else:
        config.draw = False
        draw = False

    if "-c" in args:
        clean = True
    else:
        clean = False

    if "-s" in args:
        if config.ltspice:
            config.simulate = True
            cmd_index = args.index("-s")
            if cmd_index < len(args)-1:
                if isinstance(eval(args[cmd_index+1]), int):
                    config.simulation_size = int(args[cmd_index+1])
                elif isinstance(eval(args[cmd_index+1]), dict):
                    config.simulation_instance = ast.literal_eval(args[cmd_index+1])
        else:
            print("LTspice only supported on Windows.")
    else:
        config.simulate = False

    if "--v" in args or "--verbose" in args:
        verbose = True
        config.verbose = True
    else:
        verbose = False

    if approach == "robdd":
        mapping_method = ROBDD()
    elif approach == "sbdd":
        mapping_method = SBDD()
    elif approach == "chakraborty":
        mapping_method = Chakraborty()
    else:
        raise Exception("Unknown mapping method.")

    mapping_method.map(file_path, None, model_checking, draw, clean, verbose)


if __name__ == "__main__":
    main(sys.argv)
