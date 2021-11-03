import os
import subprocess
import time

import numpy as np
import matplotlib.pyplot as plt

from ltspice import Ltspice

import config
from MemristorCrossbar import MemristorCrossbar
from FileMover import FileMover
from LTSpiceGenerator import LTSpiceGenerator


class LTSpiceSimulator:

    @staticmethod
    def simulate(instance: dict, crossbar: MemristorCrossbar):

        raw_file = config.lt_spice_dir.joinpath('circuit.raw')

        ltg = LTSpiceGenerator()

        true_signals = []
        false_signals = []

        crossbar_instance = crossbar.instantiate(instance)

        ltg.write_circuit(crossbar_instance)

        FileMover.move('circuit.cir', str(config.lt_spice_dir.joinpath('circuit.cir')))

        # "C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b "C:\Users\Desktop\file.net"
        lt_spice_cmd = config.lt_spice_cmd.copy()
        lt_spice_cmd.append('circuit.cir')
        subprocess.call(lt_spice_cmd, cwd=str(config.lt_spice_dir), stderr=subprocess.STDOUT, stdout=subprocess.DEVNULL)

        while not raw_file.is_file():
            pass
        time.sleep(1)

        lt_spice = Ltspice(str(raw_file))
        lt_spice.parse()  # Data loading sequence. It may take few minutes.

        for (output_variable, row) in crossbar.output_nanowires.items():
            print(output_variable)
            print(row)
            signals = lt_spice.getData('I(R_{})'.format(output_variable))
            # if truth:
            #     signal = min(signals[1:])
            #     true_signals.append(signal)
            # else:
            #     signal = max(signals[1:])
            #     false_signals.append(signal)
            #
            # if config.verbose:
            #     print("Output: {}".format(crossbar.output_variables[i]))
            #     print("Truth: {}".format(truth))
            #     print("Signal: {}".format(signal))
            print(signals)

            plt.plot(signals[:20], label='{}'.format(output_variable))
            plt.ylabel("Voltage (V)")
            plt.xlabel("Time (ms)")
            plt.title("Output signals")
            plt.legend(loc='best')
            plt.show()

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

        os.remove(config.lt_spice_dir.joinpath('circuit.raw'))
        os.remove(config.lt_spice_dir.joinpath('circuit.cir'))
        os.remove(config.lt_spice_dir.joinpath('circuit.log'))
        os.remove(config.lt_spice_dir.joinpath('circuit.op.raw'))
        return min_true_signal, max_false_signal, avg_true_signal, avg_false_signal
