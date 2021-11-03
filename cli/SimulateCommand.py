import config
from cli.Command import Command
from LTSpiceSimulator import LTSpiceSimulator
from InstanceFileReader import InstanceFileReader


class SimulateCommand(Command):

    def __init__(self, args):
        super().__init__()
        if len(args) < 1:
            raise Exception("Unknown simulation file.")
        self.simulation_file = args[0]

    def execute(self) -> bool:
        crossbar = config.context_manager.get_context().crossbar
        simulation_file_reader = InstanceFileReader(self.simulation_file)
        instance = simulation_file_reader.parse()
        lt_spice_simulator = LTSpiceSimulator()
        lt_spice_simulator.simulate(instance, crossbar)
        return False
