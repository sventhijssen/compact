# COMPACT: Flow-Based Computing on Nanoscale Crossbars with Minimal Semiperimeter

## Introduction
##### Flow-based computing
Flow-based computing is an in-memory computing paradigm on nanoscale memristor crossbars.
The memristors are assigned Boolean literals (Boolean variables and their negations), and the Boolean truth values '0' and '1'.

Definition:
Given a crossbar design for a Boolean function φ, then the Boolean function φ evaluates to true if and only if there exists a path along low resistive memristors from the input nanowire (bottom most nanowire) to the output nanowire (top most nanowire) when a high input voltage is applied to the input nanowire.

![Flow-based computing](Extra/demo.gif)

##### Publications
- Thijssen, S., Jha, S. K., & Ewetz, R. (2021, February). [COMPACT: Flow-Based Computing on Nanoscale Crossbars with Minimal Semiperimeter](https://ieeexplore.ieee.org/abstract/document/9473995). In 2021 Design, Automation & Test in Europe Conference & Exhibition (DATE) (pp. 232-237). IEEE. **Nominated for Best Paper Award.** 

## Requirements

##### Windows

- Install and enable [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10#install-windows-subsystem-for-linux). 
- Python 3.6 or higher
- Optional: LTspice
- Optional: CPLEX

##### Linux
- Python 3.6 or higher
- Optional: CPLEX

##### MacOS
- Python 3.6 or higher
- Optional: CPLEX

## Installation

Clone this git repository and the required submodule for ABC. Make sure to clone the submodule from [here](https://github.com/sventhijssen/abc).

(Optional for Windows) Download and install [LTspice](https://www.analog.com/en/design-center/design-tools-and-calculators/ltspice-simulator.html). Then, configure the path to LTspice in `config.py`:

```python
lt_spice = "C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe"
```

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install the Python dependencies in ``requirements.txt``.

```bash
pip3 install -r requirements.txt
```

Make sure the packages ``g++``, ``gcc`` and ``libreadline-dev`` are installed for your Linux environment.

```bash
sudo apt-get install gcc
sudo apt-get install g++
sudo apt-get install libreadline-dev
```

Compile the ``ABC`` tool in the directory _ABC_. 

```bash
make
```

Compile the ``SBDD`` tool in the directory _SBDD_. 

```bash
g++ main.cpp bdd.cpp export.cpp pla.cpp sbdd.cpp uniData.cpp -o main
```

By default, CPLEX is the ILP solver. 
Download and install [CPLEX](https://www.ibm.com/analytics/cplex-optimizer), 
and make sure CPLEX is installed and the variable `cplex_path` is set correctly for your OS. 
If the default ILP solver is to be used, set `use_cplex = False` in `config.py`.

## Usage

In the directory [_Examples_](/Examples), some examples are given on how to use COMPACT from command line.

```bash
python3 Main.py robdd Benchmarks/5xp1.pla --v -l
```

In the directory [_Experiments_](/Experiments), an example is given on how to use COMPACT with the Python API.

## Version
COMPACT version 1.0.0.  
A new major release is scheduled in the next months.

## Contact
_Sven Thijssen  
University of Central Florida  
sven.thijssen (at) knights.ucf.edu  
http://sventhijssen.com/_

## References
- [ABC](https://people.eecs.berkeley.edu/~alanmi/abc/)
- [SBDD](https://github.com/semencher/SBDD)
- [RevLib](http://www.informatik.uni-bremen.de/rev_lib/)
- [CPLEX](https://www.ibm.com/analytics/cplex-optimizer)
- [LTspice](https://www.analog.com/en/design-center/design-tools-and-calculators/ltspice-simulator.html)
- [Computation of boolean formulas using sneak paths in crossbar computing](https://patentimages.storage.googleapis.com/02/c8/90/398607d91adc90/US9319047.pdf)
- [Automated synthesis of compact crossbars for sneak-path based in-memory computing](https://ieeexplore.ieee.org/document/7927093)

## License
    Copyright 2020-2021 University of Central Florida

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
