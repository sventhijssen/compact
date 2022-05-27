import pathlib
import platform

from Log import Log
from cli.ContextManager import ContextManager

context_manager = ContextManager()
log = Log()

# Settings for BDD
vh_labeling = True
time_limit_bdd = 60
bdd = "robdd"
bdd_parser = None

# Settings for COMPACT
# Apply a time limit
time_limit = None
# Keep auxiliary files from CPLEX
keep_files = False

gamma = 1

mapping_method = "compact"

root = pathlib.Path(__file__).parent.absolute()
benchmark_path = root.joinpath('benchmarks')
abc_path = root.joinpath('abc')

if platform.system() == 'Windows':
    bash_cmd = ['bash', '-c']
    lt_spice_dir = pathlib.Path('C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe')
    lt_spice_cmd = ['./XVIIx64.exe', '-Run', '-b']
    cplex_path = '/opt/ibm/ILOG/CPLEX_Studio201/cplex/bin/x64_win64/cplex.exe'
elif platform.system() == 'Linux':
    bash_cmd = ['/bin/bash', '-c']
    lt_spice_dir = pathlib.Path('/home/sven/.wine/drive_c/Program Files/LTC/LTspiceXVII')
    lt_spice_cmd = ['wine', './XVIIx64.exe', '-Run', '-b']
    cplex_path = '/opt/ibm/ILOG/CPLEX_Studio201/cplex/bin/x86-64_linux/cplex'
elif platform.system() == 'Darwin':
    bash_cmd = []
    lt_spice_dir = None
    lt_spice_cmd = None
    cplex_path = '/Applications/CPLEX_Studio201/cplex/bin/x86-64_osx/cplex'
else:
    raise Exception("Unsupported OS: {}".format(platform.system()))

abc_cmd = bash_cmd.copy()
abc_cmd.extend(['"./abc"'])
abc_cmd = ' '.join(abc_cmd)
