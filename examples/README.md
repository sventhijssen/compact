## Command line

Using command line, one can run the program using the following template:

If no BDD is available:
```bash
python3 new_log LOG_NAME | read BENCHMARK_NAME | BDD_TYPE | write_bdd BDD_FILENAME | COMPACT 
```

If a BDD is available:
```bash
python3 new_log LOG_NAME | read_bdd BDD_FILENAME | COMPACT 
```

#### Log file
It is best to record your experiments with a log. To set up a new log, use ```new_log LOG_FILENAME```. It is best practice to use the file extension ``.log``. Note that a log file will be overridden when the same log name is used.

#### Benchmark
Benchmarks are located in the folder [_benchmarks_](/benchmarks).
Depending on the OS, locate the relative file path as follows (make sure to use the correct file separator `\ ` or `/ `):

```
benchmarks/revlib/5xp1.pla
```

#### BDD type
Two BDD types can be used: ```robdd``` and ```sbdd```.

#### BDD file
One can write a BDD to file using the command ```write_bdd BDD_FILENAME```. It is best practice to use the file extension ``.bdd``.

#### COMPACT
COMPACT can be called using an optional argument.

#### Timeout
One can define a timeout on the ILP formulation. The duration for the timeout is defined in seconds.
```bash
-t DURATION
```

#### Gamma
One can define the hyperparameter gamma to change the pressure towards minimizing the semiperimeter or minimizing the maximum dimension of the crossbar design.
When gamma is zero, the objective is to find a minimal semiperimter. Otherwise, when gamma is equal to one, the objective is to minimize the maximum dimension. The latter will result in more square crossbar designs.
Any value between zero and one will result in a weighted sum of the two objectives.
```bash
-g GAMMA
```


## Examples
Below, a small set of examples is provided:

```bash
python3 cli/main.py new_log t481.log | read_bdd t481.bdd | compact
```

```bash
python3 cli/main.py new_log t481.log | read_bdd t481.bdd | compact -g 0.5
```

```bash
python3 cli/main.py new_log t481.log | read benchmarks/revlib/t481.pla | robdd | compact -t 60
```

```bash
python3 cli/main.py new_log t481.log | read benchmarks/revlib/t481.pla | sbdd | compact -t 900 -g 0.5
```