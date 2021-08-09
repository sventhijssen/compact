import os
from datetime import datetime

import config
from Chakraborty import Chakraborty
from ROBDD import ROBDD
from SBDD import SBDD


def main():
    """
    For each verification method, we execute all benchmarks.
    For each verification method, we record the run-time (or time-out) and the Z3 formulas.
    When all verification methods have ran, we compare the Z3 formulas for each benchmark for each verification method
     if it has not timed out.
    :return:
    """
    print(datetime.now())
    config.verbose = True
    config.log = True
    config.clean = False

    benchmarks = [
            # '5xp1.pla',
            # 'alu4.pla',
            # 'apex2.pla',
            # 'apex4.pla',
            'apex5.pla',
            # 'clip.pla',
            # 'cm150a.pla',
            # 'cm162a.blif',
            # 'cm163a.pla',
            # 'cordic.pla',
            # 'misex1.pla',
            # 'misex3.pla',
            # 'parity.pla',
            # 'seq.pla',
            # 't481.pla',
            # 'x2.pla',
            # 'dk17.pla',
            # 'f51m.pla',
            # 'pcler8.pla',
            # 'ryy16.pla',
            # 'tial.pla',
        ]

    for benchmark in benchmarks:
        print("BENCHMARK")
        print(benchmark)
        file_path = "Benchmarks" + os.path.sep + benchmark

        mapping_method = SBDD()  # Chakraborty, SBDD
        [_, _, _] = mapping_method.map(file_path, verbose=False)


if __name__ == "__main__":
    main()
