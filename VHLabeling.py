import math
import os
import time
import re
from datetime import datetime
from itertools import product
from pathlib import Path
from typing import Dict

import numpy as np
from networkx import Graph, complete_graph, cartesian_product
from pulp import LpVariable, LpProblem, LpMinimize, LpInteger, lpSum, PULP_CBC_CMD, LpStatus, LpStatusInfeasible, \
    CPLEX_CMD

import config
from InfeasibleSolutionException import InfeasibleSolutionException


class VHLabeling:

    def __init__(self, g: Graph, layers: int = 1):
        self.g = g
        self.layers = layers
        self.labeling = dict()
        self.start_time = None
        self.stop_time = None

    def get_log(self) -> str:
        return 'VH-labeling time (s): {}\n'.format(self.stop_time - self.start_time)

    @staticmethod
    def get_labels(vh_labeling: Dict):
        label_v = dict(filter(lambda elem: elem[1] == 1, vh_labeling.items()))
        label_h = dict(filter(lambda elem: elem[1] == -1, vh_labeling.items()))
        label_vh = dict(filter(lambda elem: elem[1] == 0, vh_labeling.items()))

        v = len(label_v)
        h = len(label_h)
        vh = len(label_vh)

        return v, h, vh

    def label(self):
        self.start_time = time.time()

        solver = CPLEX_CMD(path=config.cplex_path, msg=False, keepFiles=config.keep_files, timeLimit=config.time_limit,
                           logPath=str(config.root.joinpath("cplex.log")))

        cmbs = ['V', 'H']
        # Variables
        # 0 <= v <= 1
        x_vars = LpVariable.dicts("x", (self.g.nodes, cmbs), 0, 1, LpInteger)
        # -1 <= g <= 1
        s_vars = LpVariable.dicts("s", self.g.edges, 0, 1, LpInteger)

        # Based on: https://stackoverflow.com/questions/65572617/absolute-value-formulation-for-an-optimization-problem-with-pulp
        S = LpVariable("S", 0, cat=LpInteger)
        D = LpVariable("D", 0, cat=LpInteger)
        R = LpVariable("R", 0, cat=LpInteger)
        C = LpVariable("C", 0, cat=LpInteger)

        lpvc = LpProblem("VC", LpMinimize)

        lpvc += config.gamma * S + (1 - config.gamma) * D
        lpvc += S == lpSum([x_vars])
        lpvc += D >= R
        lpvc += D >= C

        lpvc += R == sum([x_vars[v]['V'] for v in self.g.nodes])
        lpvc += C == sum([x_vars[v]['H'] for v in self.g.nodes])

        for e in self.g.edges:
            lpvc += lpSum(x_vars[e[0]]['V'] + x_vars[e[1]]['H']) >= 2 - 2 * s_vars[e]
            lpvc += lpSum(x_vars[e[0]]['H'] + x_vars[e[1]]['V']) >= 2 - 2 * (1 - s_vars[e])

        # Required constraint: root node and leaf node must be given a label V
        if config.io_constraints:
            for (v, d) in self.g.nodes(data=True):
                if d["root"]:
                    lpvc += x_vars[v]['H'] == 1
                if d["terminal"]:
                    lpvc += x_vars[v]['H'] == 1

        print("\tStarted ILP solver")
        print("\t{}".format(datetime.now()))
        lpvc.solve(solver)
        print("\tStopped ILP solver")
        print("\t{}".format(datetime.now()))

        if lpvc.status == LpStatusInfeasible:
            raise InfeasibleSolutionException("Infeasible solution.")

        vertical = []
        horizontal = []
        for v in self.g.nodes:
            self.labeling[v] = 0
            if int(round(x_vars[v]['V'].varValue)) == 1:
                vertical.append(v)
                self.labeling[v] += 1
            if int(round(x_vars[v]['H'].varValue)) == 1:
                horizontal.append(v)
                self.labeling[v] += -1

        vertical_set = set(vertical)
        horizontal_set = set(horizontal)
        vhs = len(list(vertical_set.intersection(horizontal_set)))
        vs = len(vertical) - vhs
        hs = len(horizontal) - vhs

        self.stop_time = time.time()

        print("Status: ", LpStatus[lpvc.status])
        print("Objective: " + str(config.gamma * S.varValue + (1 - config.gamma) * D.varValue))
        print("Label V: " + str(vs))
        print("Label H: " + str(hs))
        print("Label VH: " + str(vhs))

        config.log.add("Objective: {}\n".format(config.gamma * S.varValue + (1 - config.gamma) * D.varValue))
        config.log.add("Label V: {}\n".format(vs))
        config.log.add("Label H: {}\n".format(hs))
        config.log.add("Label VH: {}\n".format(vhs))

        gap = 0
        cplex_log_file_name = config.root.joinpath("cplex.log")
        if cplex_log_file_name.is_file():
            with open(str(cplex_log_file_name), 'r') as f:
                for line in f.readlines():
                    if "gap" in line:
                        gap = float(re.findall(r'(\d+\.\d+)\%', line)[0])
        config.log.add("Gap (%): {}\n".format(gap))
        # print('Labeling: {}\n'.format(self.labeling))

        config.log.add(self.get_log())

        return self.labeling
