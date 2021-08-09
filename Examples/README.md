## Command line

Using command line, one can run the program using the following template:
```bash
python3 Main.py MAPPING_METHOD BENCHMARK [OPTIONAL_ARGUMENTS]
```

#### Mapping method
- ROBDD (COMPACT)
- SBDD (COMPACT)
- Chakraborty (always ROBDD-based)

#### Benchmark
Benchmarks are located in the folder [_Benchmarks_](/Benchmarks).
Depending on the OS, locate the relative file path as follows (make sure to use the correct file separator `\ ` or `/ `):

```
Benchmarks\5xp1.pla
```

##### Optional arguments
- Verbose `--v`  
A verbose output is printed to the screen.
- Model checking `-m`  
Using brute-force enumeration, the Boolean function is verified for functional correctness.
- Draw `-d`  
The crossbar design is drawn in a PDF file. This requires _pdflatex_.
- Clean `-c`  
The auxiliary files are removed.
- Simulate `-s`  
Using LTspice, the crossbar design is simulated for a given input instance. An instance is passed as follows `{'VAR':True|False}`. For example: `{'a':True,'b':False,'c':True}`.

## Examples
Below, a small set of examples is provided:

```bash
python3 Main.py robdd Benchmarks/5xp1.pla --v -l
```

```bash
python3 Main.py sbdd Benchmarks/f51m.pla -d -m
```

```bash
python3 Main.py chakraborty Benchmarks/sym10.pla -r -s {'x0':True,'x1':False,'x2':False,'x3':False,'x4':True,'x5':True,'x6':False,'x7':False,'x8':True,'x9':False}
```