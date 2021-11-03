from typing import List

import config
from SBDDDOTParser import SBDDDOTParser
from cli.Command import Command
from ROBDDDOTParser import ROBDDDOTParser


class BDDCommand(Command):

    def __init__(self, bdd_type: str, args: List[str]):
        super(BDDCommand).__init__()
        self.bdd_type = bdd_type
        config.bdd = bdd_type

        if "-t" in args:
            idx = args.index("-t")
            config.time_limit_bdd = int(args[idx + 1])
        else:
            config.time_limit_bdd = 24 * 60 * 60  # 24 hours

        self.args = args

    def execute(self):
        context = config.context_manager.get_context()
        if self.bdd_type == "bdd":
            robdd_parser = ROBDDDOTParser(context.benchmark)
            robdd = robdd_parser.parse()
            sbdd_parser = SBDDDOTParser(context.benchmark)
            sbdd = sbdd_parser.parse()
            if len(robdd.nodes) < len(sbdd.nodes):
                config.bdd_parser = robdd_parser
                context.benchmark_graph = robdd
                config.bdd = 'robdd'
            else:
                config.bdd_parser = sbdd_parser
                context.benchmark_graph = sbdd
                config.bdd = 'sbdd'
        elif self.bdd_type == "robdd":
            config.bdd_parser = ROBDDDOTParser(context.benchmark)
            context.benchmark_graph = config.bdd_parser.parse()
        elif self.bdd_type == "sbdd":
            config.bdd_parser = SBDDDOTParser(context.benchmark)
            context.benchmark_graph = config.bdd_parser.parse()
        else:
            raise Exception("Unsupported BDD type.")
        return False
