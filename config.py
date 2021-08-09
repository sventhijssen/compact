import pathlib
import platform

from BenchmarkLog import BenchmarkLog

draw = False
verbose = True
log = False
clean = True
log_file = BenchmarkLog()
simulate = False
simulation_instance = None
simulation_size = 10
model_checking = False
root = pathlib.Path(__file__).parent.absolute()
use_cplex = True

if platform.system() == 'Windows':
    abc_cmd = ['bash', '-c', './abc']
    sbdd_cmd = ['bash', '-c', './main']
    ltspice_path = "C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe"
    cplex_path = '/opt/ibm/ILOG/CPLEX_Studio201/cplex/bin/x64_win64/cplex.exe'
elif platform.system() == 'Linux':
    abc_cmd = ['./abc']
    sbdd_cmd = ['./main']
    ltspice_path = None
    cplex_path = '/opt/ibm/ILOG/CPLEX_Studio201/cplex/bin/x86-64_linux/cplex'
elif platform.system() == 'Darwin':
    abc_cmd = ['./abc']
    sbdd_cmd = ['./main']
    ltspice_path = None
    cplex_path = '/Applications/CPLEX_Studio201/cplex/bin/x86-64_osx/cplex'
else:
    raise Exception("Unsupported OS")
