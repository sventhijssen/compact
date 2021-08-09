import subprocess
from typing import List, Dict


from Memristor import Memristor


class LatexGenerator:

    # Source: https://tex.stackexchange.com/questions/61805/tikz-using-loop-to-draw-grid-of-nodes
    @staticmethod
    def draw_instance(rows: int, columns: int, matrix_instance: List[List[Memristor]], truth_instance: List[int],
                      parents: Dict[Memristor, Memristor]):

        file_name = 'formula_' + ''.join(map(str, map(int, truth_instance))) + '.tex'

        with open(file_name, 'w') as f:
            f.write('\\documentclass{minimal}\n')
            f.write('\\usepackage{tikz}\n')
            f.write('\\usepackage[pass, paperwidth=24in, paperheight=24in]{geometry}\n')
            f.write('\\begin{document}\n')
            f.write('\\begin{tikzpicture}['
                    'OFF/.style={circle, draw, fill=gray!40, minimum size=8, inner sep=0pt, text width=6mm, align=center, font=\\footnotesize},'
                    'ON/.style={circle, draw, fill=green!40, minimum size=8, inner sep=0pt, text width=6mm, align=center, font=\\footnotesize}]\n')
            for c in range(columns):
                for r in range(rows):
                    v = '$' + str(int(matrix_instance[r][c].literal.positive)) + '$'
                    s = 'ON' if matrix_instance[r][c].literal.positive else 'OFF'
                    f.write('\\node[%s](n%d_%d) at (0.8*%d, 0.8*%d) {%s};\n' % (s, c, rows - 1 - r, c, rows - 1 - r, v))

            for c in range(columns - 1):
                for r in range(rows):
                    f.write('\\draw (n%d_%d) -- (n%d_%d);\n' % (c, r, c + 1, r))

            for c in range(columns):
                for r in range(rows - 1):
                    f.write('\\draw (n%d_%d) -- (n%d_%d);\n' % (c, r, c, r + 1))

            # F is in the last column of the truth table
            # If F == 1, then there is node_a path which we can reconstruct using 'parents'
            # We start reconstructing at the output at in the last column, first row

            # if truth_instance[-1] == 1:
            #     start_node = MemristorNode(0, columns - 1)
            #     previous_node = parents[start_node]
            #     f.write('\\draw[red,thick,dashed] (n%d_%d) -- (n%d_%d);\n' % (start_node.column, rows-1-start_node.row, previous_node.column, rows-1-previous_node.row))
            #
            #     end_node = MemristorNode(rows - 1, 0)
            #
            #     while previous_node != end_node:
            #         start_node = previous_node
            #         previous_node = parents[start_node]
            #         f.write('\\draw[red,thick,dashed] (n%d_%d) -- (n%d_%d);\n' % (start_node.column, rows-1-start_node.row, previous_node.column, rows-1-previous_node.row))

            f.write('\\end{tikzpicture}\n')
            f.write('\\end{document}\n')

        subprocess.call(["pdflatex", file_name], stdout=subprocess.DEVNULL)

    @staticmethod
    def draw_design(file_name: str, rows: int, columns: int, matrix_instance: List[List[Memristor]]):

        with open(file_name, 'w') as f:
            f.write('\\pdfpageheight=40in\n')
            f.write('\\pdfpagewidth=40in\n')
            f.write('\\documentclass{minimal}\n')
            f.write('\\usepackage{tikz}\n')
            # f.write('\\usepackage[pass, paperwidth=24in, paperheight=24in]{geometry}\n')
            f.write('\\begin{document}\n')
            f.write('\\begin{tikzpicture}['
                    'OFF/.style={circle, draw, fill = gray!40, minimum size=8, inner sep=0pt, text width=6mm, align=center},'
                    'ON/.style={circle, draw, fill = green!40, minimum size=8, inner sep=0pt, text width=6mm, align=center},'
                    'VAR/.style={circle, draw, fill = blue!40, minimum size=8, inner sep=0pt, text width=6mm, align=center}]\n')

            for c in range(columns):
                for r in range(rows):
                    if matrix_instance[r][c].literal.atom == 'False':
                        v = '$\\scriptscriptstyle 0$'
                        s = 'OFF'
                    elif matrix_instance[r][c].literal.atom == 'True':
                        v = '$\\scriptscriptstyle 1$'
                        s = 'ON'
                    else:
                        if not matrix_instance[r][c].literal.positive:
                            v = '$\\scriptscriptstyle \\neg ' + matrix_instance[r][c].literal.atom + '$'
                        else:
                            v = '$\\scriptscriptstyle ' + matrix_instance[r][c].literal.atom + '$'
                        s = 'VAR'
                    f.write('\\node[%s](n%d_%d) at (0.8*%d, 0.8*%d) {%s};\n' % (s, c, rows - 1 - r, c, rows - 1 - r, v))

            for c in range(columns - 1):
                for r in range(rows):
                    f.write('\\draw (n%d_%d) -- (n%d_%d);\n' % (c, r, c + 1, r))

            for c in range(columns):
                for r in range(rows - 1):
                    f.write('\\draw (n%d_%d) -- (n%d_%d);\n' % (c, r, c, r + 1))

            f.write('\\end{tikzpicture}\n')
            f.write('\\end{document}\n')

        subprocess.call(["pdflatex", file_name], stdout=subprocess.DEVNULL)

    @staticmethod
    def comparison_area(file_name: str, logs: Dict):
        with open(file_name, 'w') as f:
            f.write('\\begin{table}[ht]\n')
            f.write('\t \\centering\n')
            f.write('\t \\begin{tabular}{c | c c | c c | c c | c}\n')
            f.write('\t Benchmark & I/O & Nodes & \multicolumn{2}{c}{Chakraborty et al.\cite{automated}} & \multicolumn{2}{c}{Our approach} & Area improvement\\\\\n')
            f.write('\t  & & & Rows & Columns & Rows & Columns & \\\\\\hline\n')
            total_inputs = 0
            total_outputs = 0
            total_nodes = 0
            total_chakraborty_rows = 0
            total_chakraborty_columns = 0
            total_robdd_rows = 0
            total_robdd_columns = 0
            total_improvement = 0
            n = 0
            for benchmark, benchmark_logs in logs.items():
                chakraborty = benchmark_logs['chakraborty']
                robdd = benchmark_logs['robdd']
                inputs = benchmark_logs['inputs']
                outputs = benchmark_logs['outputs']
                nodes = benchmark_logs['nodes']
                total_inputs += inputs
                total_outputs += outputs
                total_nodes += nodes
                total_chakraborty_rows += chakraborty.rows
                total_chakraborty_columns += chakraborty.columns
                total_robdd_rows += robdd.rows
                total_robdd_columns += robdd.columns
                improvement = round(chakraborty.area / robdd.area * 100, 2)
                total_improvement += improvement
                n += 1
                row = '\t {} & {}/{} & {} & '.format(benchmark, inputs, outputs, nodes)
                row += '{} & {} & '.format(chakraborty.rows, chakraborty.columns)
                row += '{} & {} & '.format(robdd.rows, robdd.columns)
                row += '{}\%\\\\\n'.format(improvement)
                f.write(row)
            f.write('\t \\hline\n')
            f.write('\t Average & {}/{} & {} & {} & {} & {} & {} & {}\%\\\\\n'.format(int(total_inputs/n), int(total_outputs/n), int(total_nodes/n), round(total_chakraborty_rows/n, 2), round(total_chakraborty_columns/n, 2), round(total_robdd_rows/n, 2), round(total_robdd_columns/n, 2), round(total_improvement/n, 2)))
            f.write('\t \\end{tabular}\n')
            f.write('\t \\caption{Comparison of the area}\n')
            f.write('\t \\label{tab:comparison_area}\n')
            f.write('\\end{table}')

    @staticmethod
    def computation_delay(file_name: str, logs: Dict):
        with open(file_name, 'w') as f:
            f.write('\\begin{table}\n')
            f.write('\t \\centering\n')
            f.write('\t \\begin{tabular}{c | c | c | c}\n')
            f.write('\t Benchmark & Chakraborty et al.\cite{automated} & Our approach & Improvement\\\\\\hline\n')
            total_chakraborty = 0
            total_robdd = 0
            total_improvement = 0
            n = 0
            for benchmark, benchmark_logs in logs.items():
                chakraborty = benchmark_logs['chakraborty']
                robdd = benchmark_logs['robdd']
                total_chakraborty += chakraborty.computation_delay
                total_robdd += robdd.computation_delay
                improvement = round(chakraborty.computation_delay / robdd.computation_delay * 100, 2)
                total_improvement += improvement
                n += 1
                row = '\t {} &  '.format(benchmark)
                row += '{} & '.format(chakraborty.computation_delay)
                row += '{} & '.format(robdd.computation_delay)
                row += '{}\%\\\\\n'.format(improvement)
                f.write(row)
            f.write('\t \\hline\n')
            f.write('\t Average & {} & {} & {}\%\\\\\n'.format(round(total_chakraborty/n, 2), round(total_robdd/n, 2), round(total_improvement/n, 2)))
            f.write('\t \\end{tabular}\n')
            f.write('\t \\caption{Comparison of computation delay (ps)}\n')
            f.write('\t \\label{tab:comparison_computation_delay}\n')
            f.write('\\end{table}')

    @staticmethod
    def power_consumption(file_name: str, logs: Dict):
        with open(file_name, 'w') as f:
            f.write('\\begin{table}[ht]\n')
            f.write('\t \\centering\n')
            f.write('\t \\begin{tabular}{c | c | c | c}\n')
            f.write('\t Benchmark & Chakraborty et al.\cite{automated} & Our approach & Improvement\\\\\\hline\n')
            total_chakraborty = 0
            total_robdd = 0
            n = 0
            total_improvement = 0
            for benchmark, benchmark_logs in logs.items():
                chakraborty = benchmark_logs['chakraborty']
                robdd = benchmark_logs['robdd']
                total_chakraborty += chakraborty.power_consumption
                total_robdd += robdd.power_consumption
                improvement = round(chakraborty.power_consumption / robdd.power_consumption * 100, 2)
                total_improvement += improvement
                n += 1
                row = '\t {} &  '.format(benchmark)
                row += '{} & '.format(chakraborty.power_consumption)
                row += '{} & '.format(robdd.power_consumption)
                row += '{}\%\\\\\n'.format(improvement)
                f.write(row)
            f.write('\t \\hline\n')
            f.write('\t Average & {} & {} & {}\%\\\\\n'.format(round(total_chakraborty/n, 2), round(total_robdd/n, 2), round(total_improvement/n, 2)))
            f.write('\t \\end{tabular}\n')
            f.write('\t \\caption{Comparison of power consumption ($\\mu W$)}\n')
            f.write('\t \\label{tab:comparison_power_consumption}\n')
            f.write('\\end{table}')
