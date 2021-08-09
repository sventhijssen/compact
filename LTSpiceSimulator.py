import copy
import subprocess
import time
from pathlib import Path

import numpy as np
from typing import List

from ltspice import ltspice

import config
from LTSpiceGenerator import LTSpiceGenerator
from MappingMethod import MappingMethod
from Memristor import Memristor


class LTSpiceSimulator:

    @staticmethod
    def simulate(rows: int, columns: int, input_variables: List[str], output_variables: List[str], truth_instances: List[List[int]], crossbar: List[List[Memristor]]):

        current_path = Path.cwd()

        raw_file = 'circuit.raw'

        ltg = LTSpiceGenerator()

        offset = len(input_variables)

        true_signals = []
        false_signals = []

        for truth_instance in truth_instances:
            matrix_instance = copy.deepcopy(crossbar)
            for r in range(rows):
                for c in range(columns):
                    variable_name = matrix_instance[r][c].literal.atom
                    if variable_name != "True" and variable_name != "False":
                        variable_index = input_variables.index(variable_name)
                        if not truth_instance[variable_index]:
                            matrix_instance[r][c].literal = matrix_instance[r][c].literal.negate()

            ltg.write_circuit(rows, columns, output_variables, matrix_instance)

            # "C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b "C:\Users\Desktop\file.net"
            subprocess.call([config.ltspice_path, "-b", str(current_path.joinpath("circuit.cir"))], stdout=subprocess.DEVNULL)

            while not Path.cwd().joinpath('circuit.raw').is_file():
                pass
            time.sleep(1)

            l = ltspice.Ltspice(raw_file)
            l.parse()  # Data loading sequence. It may take few minutes.

            output_values = truth_instance[offset:]
            print(truth_instance)
            for i in range(len(output_variables)):
                truth = output_values[i]
                signals = l.getData('I(Rout{})'.format(i))
                if truth:
                    signal = min(signals[1:])
                    true_signals.append(signal)
                else:
                    signal = max(signals[1:])
                    false_signals.append(signal)

                if config.verbose:
                    print("Output: {}".format(output_variables[i]))
                    print("Truth: {}".format(truth))
                    print("Signal: {}".format(signal))

            MappingMethod.clean([
                Path.cwd().joinpath('circuit.cir'),
                Path.cwd().joinpath('circuit.log'),
                Path.cwd().joinpath('circuit.op.raw'),
                Path.cwd().joinpath('circuit.raw')]
                                )

        if len(true_signals) != 0:
            min_true_signal = min(true_signals)
            avg_true_signal = np.average(true_signals)
        else:
            min_true_signal = 0
            avg_true_signal = 0
        if len(false_signals) != 0:
            max_false_signal = max(false_signals)
            avg_false_signal = np.average(false_signals)
        else:
            max_false_signal = 0
            avg_false_signal = 0

        return min_true_signal, max_false_signal, avg_true_signal, avg_false_signal

