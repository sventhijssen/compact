import networkx as nx
from networkx import Graph
from pulp import LpVariable, LpProblem, LpMinimize, LpInteger, lpSum, PULP_CBC_CMD, LpStatus, CPLEX_CMD

import config
from Labeling import Labeling


class MinimumVertexCover(Labeling):

    # Based on: https://link.springer.com/content/pdf/10.1007%2F978-3-319-21275-3.pdf
    # p.33
    @staticmethod
    def label(G: Graph, leaf_node_one: str):
        K2 = nx.complete_graph(2)
        P = nx.cartesian_product(G, K2)

        return MinimumVertexCover.ilp(G, P)

    @staticmethod
    def ilp(G: Graph, P: Graph):
        # Variables
        # 0 <= v <= 1
        p_vars = LpVariable.dicts("Nodes", P.nodes, 0, 1, LpInteger)

        # -1 <= g <= 1
        g_vars = LpVariable.dicts("GNodes", G.nodes, -1, 1, LpInteger)

        if config.use_cplex:
            solver = CPLEX_CMD(path=config.cplex_path, msg=False)
        else:
            solver = PULP_CBC_CMD(msg=False)

        lpvc = LpProblem("VC", LpMinimize)

        # Objective function
        # sum(v), v \in V(G)
        lpvc += lpSum([p_vars])

        # Constraints
        # u+v >= 1, uv \in E(G)
        for e in P.edges:
            lpvc += lpSum(p_vars[e[0]] + p_vars[e[1]]) >= 1
        p_nodes = list(P.nodes)
        i = 0
        while i < len(P.nodes):
            lpvc += lpSum(p_vars[p_nodes[i]] - p_vars[p_nodes[i+1]]) >= g_vars[p_nodes[i][0]]
            lpvc += lpSum(p_vars[p_nodes[i]] - p_vars[p_nodes[i + 1]]) <= g_vars[p_nodes[i][0]]
            i += 2
        lpvc += lpSum(g_vars) <= 1
        lpvc += lpSum(g_vars) >= -1

        lpvc.solve(solver)

        print("Status:", LpStatus[lpvc.status])

        vertical = []
        vs = 0
        hs = 0
        xs = 0
        horizontal = []
        s = 0
        for v in lpvc.variables():
            # print(v.name, "=", v.varValue)
            if v.name[0] == "G":
                node = v.name[7:]
                s += v.varValue

                if v.varValue == 1:
                    vertical.append(node)
                    vs += 1
                elif v.varValue == -1:
                    horizontal.append(node)
                    hs += 1
                else:
                    vertical.append(node)
                    horizontal.append(node)
                    xs += 1

        if config.verbose:
            print("Label V: " + str(vs))
            print("Label H: " + str(hs))
            print("Label VH: " + str(xs))

        # BenchmarkLog
        config.log_file.label_v += vs
        config.log_file.label_h += hs
        config.log_file.label_vh += xs

        return [vertical, horizontal]
