(edif netlist
  (edifVersion 2 0 0)
  (keywordMap (keywordLevel 0))
  (external PRIMLIB
     (edifLevel 0)
     (technology
	(numberDefinition)
	(simulationInfo
	   (logicValue H (booleanMap (true)))
	   (logicValue L (booleanMap (false)))
	)
     )
     (cell TRUE
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	   )
	)
     )
     (cell FALSE
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	   )
	)
     )
     (cell DC
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	   )
	)
     )
     (cell BUF
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	   )
	)
     )
     (cell INV
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	   )
	)
     )
     (cell MUX2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in0 (direction input))
	      (port in1 (direction input))
	      (port sel (direction input))
	   )
	)
     )
     (cell LATCH
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port clk (direction input))
	   )
	)
     )
     (cell LATCHR
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port clk (direction input))
	      (port reset (direction input))
	   )
	)
     )
     (cell LATCHSR
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port clk (direction input))
	      (port set (direction input))
	      (port reset (direction input))
	   )
	)
     )
     (cell LATCHS
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port clk (direction input))
	      (port set (direction input))
	   )
	)
     )
     (cell DFF
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port clk (direction input))
	   )
	)
     )
     (cell DFFR
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port clk (direction input))
	      (port reset (direction input))
	   )
	)
     )
     (cell DFFSR
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port clk (direction input))
	      (port set (direction input))
	      (port reset (direction input))
	   )
	)
     )
     (cell DFFS
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port clk (direction input))
	      (port set (direction input))
	   )
	)
     )
     (cell TRI
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in (direction input))
	      (port en (direction input))
	   )
	)
     )
     (cell AND2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell XOR2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell OR2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell AND3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell XOR3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell OR3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell AND4
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell XOR4
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell OR4
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell AND5
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell XOR5
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell OR5
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell AND6
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell XOR6
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell OR6
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell AND7
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in6 (direction input))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell XOR7
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in6 (direction input))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell OR7
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in6 (direction input))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell AND8
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in7 (direction input))
	      (port in6 (direction input))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell XOR8
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in7 (direction input))
	      (port in6 (direction input))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
     (cell OR8
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port out (direction output))
	      (port in7 (direction input))
	      (port in6 (direction input))
	      (port in5 (direction input))
	      (port in4 (direction input))
	      (port in3 (direction input))
	      (port in2 (direction input))
	      (port in1 (direction input))
	      (port in0 (direction input))
	   )
	)
     )
  )
  (library iwls93
     (edifLevel 0)
     (cell AN2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 990 -3))))
	      (port B (direction input)
		 (property cap (number (e 1030 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref B)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell AN3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 780 -3))))
	      (port B (direction input)
		 (property cap (number (e 770 -3))))
	      (port C (direction input)
		 (property cap (number (e 820 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef AND3 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref C)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell AN4
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1080 -3))))
	      (port B (direction input)
		 (property cap (number (e 990 -3))))
	      (port C (direction input)
		 (property cap (number (e 1030 -3))))
	      (port D (direction input)
		 (property cap (number (e 1010 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef AND4 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in3 (instanceRef G0))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell AN6
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 790 -3))))
	      (port B (direction input)
		 (property cap (number (e 810 -3))))
	      (port C (direction input)
		 (property cap (number (e 880 -3))))
	      (port D (direction input)
		 (property cap (number (e 790 -3))))
	      (port E (direction input)
		 (property cap (number (e 790 -3))))
	      (port F (direction input)
		 (property cap (number (e 790 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef AND6 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in3 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in4 (instanceRef G0))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in5 (instanceRef G0))
		     (portref F)
		 )
	      )
	   )
	   (property area (number (e 8 0)))
	)
     )
     (cell AN8
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 910 -3))))
	      (port B (direction input)
		 (property cap (number (e 900 -3))))
	      (port C (direction input)
		 (property cap (number (e 910 -3))))
	      (port D (direction input)
		 (property cap (number (e 980 -3))))
	      (port E (direction input)
		 (property cap (number (e 940 -3))))
	      (port F (direction input)
		 (property cap (number (e 940 -3))))
	      (port G (direction input)
		 (property cap (number (e 910 -3))))
	      (port H (direction input)
		 (property cap (number (e 920 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef AND8 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in3 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in4 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in5 (instanceRef G0))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in6 (instanceRef G0))
		     (portref F)
		 )
	      )
	      (net G
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref G)
		 )
	      )
	      (net H
		 (joined
		     (portRef in7 (instanceRef G0))
		     (portref H)
		 )
	      )
	   )
	   (property area (number (e 9 0)))
	)
     )
     (cell ND2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1000 -3))))
	      (port B (direction input)
		 (property cap (number (e 1000 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 3 0)))
	)
     )
     (cell ND3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1000 -3))))
	      (port B (direction input)
		 (property cap (number (e 1020 -3))))
	      (port C (direction input)
		 (property cap (number (e 1000 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND3 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell ND4
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 12000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1080 -3))))
	      (port B (direction input)
		 (property cap (number (e 1010 -3))))
	      (port C (direction input)
		 (property cap (number (e 1080 -3))))
	      (port D (direction input)
		 (property cap (number (e 1010 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND4 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in3 (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell ND6
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 910 -3))))
	      (port B (direction input)
		 (property cap (number (e 910 -3))))
	      (port C (direction input)
		 (property cap (number (e 900 -3))))
	      (port D (direction input)
		 (property cap (number (e 920 -3))))
	      (port E (direction input)
		 (property cap (number (e 920 -3))))
	      (port F (direction input)
		 (property cap (number (e 880 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND6 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in3 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in4 (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in5 (instanceRef G1))
		     (portref F)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 9 0)))
	)
     )
     (cell ND8
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 890 -3))))
	      (port B (direction input)
		 (property cap (number (e 900 -3))))
	      (port C (direction input)
		 (property cap (number (e 920 -3))))
	      (port D (direction input)
		 (property cap (number (e 970 -3))))
	      (port E (direction input)
		 (property cap (number (e 940 -3))))
	      (port F (direction input)
		 (property cap (number (e 870 -3))))
	      (port G (direction input)
		 (property cap (number (e 930 -3))))
	      (port H (direction input)
		 (property cap (number (e 910 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND8 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in3 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in4 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in5 (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in6 (instanceRef G1))
		     (portref F)
		 )
	      )
	      (net G
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref G)
		 )
	      )
	      (net H
		 (joined
		     (portRef in7 (instanceRef G1))
		     (portref H)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 10 0)))
	)
     )
     (cell OR2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1020 -3))))
	      (port B (direction input)
		 (property cap (number (e 990 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref B)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell OR3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port A (direction input)
		 (property cap (number (e 790 -3))))
	      (port B (direction input)
		 (property cap (number (e 790 -3))))
	      (port C (direction input)
		 (property cap (number (e 790 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref C)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell OR4
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1020 -3))))
	      (port B (direction input)
		 (property cap (number (e 1020 -3))))
	      (port C (direction input)
		 (property cap (number (e 980 -3))))
	      (port D (direction input)
		 (property cap (number (e 1090 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef OR4 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in3 (instanceRef G0))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell OR6
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 17000 -3))))
	      (port A (direction input)
		 (property cap (number (e 880 -3))))
	      (port B (direction input)
		 (property cap (number (e 790 -3))))
	      (port C (direction input)
		 (property cap (number (e 790 -3))))
	      (port D (direction input)
		 (property cap (number (e 760 -3))))
	      (port E (direction input)
		 (property cap (number (e 760 -3))))
	      (port F (direction input)
		 (property cap (number (e 790 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef OR6 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in3 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in4 (instanceRef G0))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in5 (instanceRef G0))
		     (portref F)
		 )
	      )
	   )
	   (property area (number (e 8 0)))
	)
     )
     (cell OR8
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 17000 -3))))
	      (port A (direction input)
		 (property cap (number (e 910 -3))))
	      (port B (direction input)
		 (property cap (number (e 970 -3))))
	      (port C (direction input)
		 (property cap (number (e 930 -3))))
	      (port D (direction input)
		 (property cap (number (e 910 -3))))
	      (port E (direction input)
		 (property cap (number (e 910 -3))))
	      (port F (direction input)
		 (property cap (number (e 930 -3))))
	      (port G (direction input)
		 (property cap (number (e 970 -3))))
	      (port H (direction input)
		 (property cap (number (e 910 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef OR8 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in3 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in4 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in5 (instanceRef G0))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in6 (instanceRef G0))
		     (portref F)
		 )
	      )
	      (net G
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref G)
		 )
	      )
	      (net H
		 (joined
		     (portRef in7 (instanceRef G0))
		     (portref H)
		 )
	      )
	   )
	   (property area (number (e 9 0)))
	)
     )
     (cell NR2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1000 -3))))
	      (port B (direction input)
		 (property cap (number (e 1000 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	   )
	   (property area (number (e 3 0)))
	)
     )
     (cell NR3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 8000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1010 -3))))
	      (port B (direction input)
		 (property cap (number (e 1000 -3))))
	      (port C (direction input)
		 (property cap (number (e 1090 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref C)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell NR4
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 6000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1010 -3))))
	      (port B (direction input)
		 (property cap (number (e 1010 -3))))
	      (port C (direction input)
		 (property cap (number (e 1000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR4 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in3 (instanceRef G1))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell NR6
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 970 -3))))
	      (port B (direction input)
		 (property cap (number (e 930 -3))))
	      (port C (direction input)
		 (property cap (number (e 950 -3))))
	      (port D (direction input)
		 (property cap (number (e 970 -3))))
	      (port E (direction input)
		 (property cap (number (e 940 -3))))
	      (port F (direction input)
		 (property cap (number (e 960 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR6 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in3 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in4 (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in5 (instanceRef G1))
		     (portref F)
		 )
	      )
	   )
	   (property area (number (e 8 0)))
	)
     )
     (cell NR8
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 790 -3))))
	      (port B (direction input)
		 (property cap (number (e 740 -3))))
	      (port C (direction input)
		 (property cap (number (e 790 -3))))
	      (port D (direction input)
		 (property cap (number (e 790 -3))))
	      (port E (direction input)
		 (property cap (number (e 790 -3))))
	      (port F (direction input)
		 (property cap (number (e 790 -3))))
	      (port G (direction input)
		 (property cap (number (e 740 -3))))
	      (port H (direction input)
		 (property cap (number (e 790 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR8 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in3 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in4 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in5 (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in6 (instanceRef G1))
		     (portref F)
		 )
	      )
	      (net G
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref G)
		 )
	      )
	      (net H
		 (joined
		     (portRef in7 (instanceRef G1))
		     (portref H)
		 )
	      )
	   )
	   (property area (number (e 10 0)))
	)
     )
     (cell EO
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1680 -3))))
	      (port B (direction input)
		 (property cap (number (e 1670 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef XOR2 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref B)
		 )
	      )
	   )
	   (property area (number (e 6 0)))
	)
     )
     (cell QEO
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 10000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1130 -3))))
	      (port B (direction input)
		 (property cap (number (e 1000 -3))))
	      (port C (direction input)
		 (property cap (number (e 1000 -3))))
	      (port D (direction input)
		 (property cap (number (e 990 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in1 (instanceRef G4))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef out (instanceRef G4))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN4
		 (joined
		     (portRef in0 (instanceRef G4))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 6 0)))
	)
     )
     (cell EN
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1680 -3))))
	      (port B (direction input)
		 (property cap (number (e 1690 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef XOR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 6 0)))
	)
     )
     (cell QEN
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 990 -3))))
	      (port B (direction input)
		 (property cap (number (e 1010 -3))))
	      (port C (direction input)
		 (property cap (number (e 1000 -3))))
	      (port D (direction input)
		 (property cap (number (e 990 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN3
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 6 0)))
	)
     )
     (cell AOR1
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 880 -3))))
	      (port B (direction input)
		 (property cap (number (e 880 -3))))
	      (port C (direction input)
		 (property cap (number (e 890 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref C)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell AOR2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 950 -3))))
	      (port B (direction input)
		 (property cap (number (e 990 -3))))
	      (port C (direction input)
		 (property cap (number (e 950 -3))))
	      (port D (direction input)
		 (property cap (number (e 980 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net NN4
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 6 0)))
	)
     )
     (cell AOR22
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1060 -3))))
	      (port B (direction input)
		 (property cap (number (e 950 -3))))
	      (port C (direction input)
		 (property cap (number (e 990 -3))))
	      (port D (direction input)
		 (property cap (number (e 970 -3))))
	      (port E (direction input)
		 (property cap (number (e 930 -3))))
	      (port F (direction input)
		 (property cap (number (e 980 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef AND3 (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND3 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G0))
		     (portref C)
		 )
	      )
	      (net NN5
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref F)
		 )
	      )
	   )
	   (property area (number (e 7 0)))
	)
     )
     (cell ANR1
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 990 -3))))
	      (port B (direction input)
		 (property cap (number (e 990 -3))))
	      (port C (direction input)
		 (property cap (number (e 1010 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref C)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell ANR11
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 12000 -3))))
	      (port A (direction input)
		 (property cap (number (e 980 -3))))
	      (port B (direction input)
		 (property cap (number (e 980 -3))))
	      (port C (direction input)
		 (property cap (number (e 980 -3))))
	      (port D (direction input)
		 (property cap (number (e 1010 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND3 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell ANR2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 990 -3))))
	      (port B (direction input)
		 (property cap (number (e 990 -3))))
	      (port C (direction input)
		 (property cap (number (e 1010 -3))))
	      (port D (direction input)
		 (property cap (number (e 1040 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G2))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell ANR3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 8000 -3))))
	      (port A (direction input)
		 (property cap (number (e 990 -3))))
	      (port B (direction input)
		 (property cap (number (e 990 -3))))
	      (port C (direction input)
		 (property cap (number (e 1020 -3))))
	      (port D (direction input)
		 (property cap (number (e 1020 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in2 (instanceRef G2))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell ANR4C
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 8000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1020 -3))))
	      (port B (direction input)
		 (property cap (number (e 980 -3))))
	      (port C (direction input)
		 (property cap (number (e 990 -3))))
	      (port D (direction input)
		 (property cap (number (e 1020 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN3
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell ANR56
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 8000 -3))))
	      (port A (direction input)
		 (property cap (number (e 990 -3))))
	      (port B (direction input)
		 (property cap (number (e 990 -3))))
	      (port C (direction input)
		 (property cap (number (e 990 -3))))
	      (port D (direction input)
		 (property cap (number (e 970 -3))))
	      (port E (direction input)
		 (property cap (number (e 990 -3))))
	      (port F (direction input)
		 (property cap (number (e 990 -3))))
	      (port G (direction input)
		 (property cap (number (e 990 -3))))
	      (port H (direction input)
		 (property cap (number (e 990 -3))))
	      (port I (direction input)
		 (property cap (number (e 990 -3))))
	      (port J (direction input)
		 (property cap (number (e 1030 -3))))
	      (port K (direction input)
		 (property cap (number (e 990 -3))))
	      (port L (direction input)
		 (property cap (number (e 1020 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND4 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND4 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef AND4 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G4))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in1 (instanceRef G4))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in3 (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net NN7
		 (joined
		     (portRef in0 (instanceRef G4))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net E
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in2 (instanceRef G2))
		     (portref F)
		 )
	      )
	      (net G
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portref G)
		 )
	      )
	      (net H
		 (joined
		     (portRef in3 (instanceRef G2))
		     (portref H)
		 )
	      )
	      (net NN12
		 (joined
		     (portRef in2 (instanceRef G4))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net I
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref I)
		 )
	      )
	      (net J
		 (joined
		     (portRef in2 (instanceRef G3))
		     (portref J)
		 )
	      )
	      (net K
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portref K)
		 )
	      )
	      (net L
		 (joined
		     (portRef in3 (instanceRef G3))
		     (portref L)
		 )
	      )
	   )
	   (property area (number (e 13 0)))
	)
     )
     (cell ANR5C
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1970 -3))))
	      (port B (direction input)
		 (property cap (number (e 1950 -3))))
	      (port C (direction input)
		 (property cap (number (e 990 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G4))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN3
		 (joined
		     (portRef in0 (instanceRef G4))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net NN6
		 (joined
		     (portRef in1 (instanceRef G4))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref C)
		 )
	      )
	   )
	   (property area (number (e 6 0)))
	)
     )
     (cell NR2I
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1000 -3))))
	      (port B (direction input)
		 (property cap (number (e 1000 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell OAN1
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 850 -3))))
	      (port B (direction input)
		 (property cap (number (e 830 -3))))
	      (port C (direction input)
		 (property cap (number (e 860 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G1))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref C)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell OND1
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1010 -3))))
	      (port B (direction input)
		 (property cap (number (e 990 -3))))
	      (port C (direction input)
		 (property cap (number (e 1030 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref C)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell OND11
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 8000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1020 -3))))
	      (port B (direction input)
		 (property cap (number (e 1000 -3))))
	      (port C (direction input)
		 (property cap (number (e 990 -3))))
	      (port D (direction input)
		 (property cap (number (e 1030 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in2 (instanceRef G1))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref D)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell OND2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1000 -3))))
	      (port B (direction input)
		 (property cap (number (e 1010 -3))))
	      (port C (direction input)
		 (property cap (number (e 1030 -3))))
	      (port D (direction input)
		 (property cap (number (e 1020 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in1 (instanceRef G4))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in0 (instanceRef G4))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G4))
		 )
	      )
	      (net NN3
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net NN4
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref D)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell OND3
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 990 -3))))
	      (port B (direction input)
		 (property cap (number (e 980 -3))))
	      (port C (direction input)
		 (property cap (number (e 1020 -3))))
	      (port D (direction input)
		 (property cap (number (e 1020 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND3 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in2 (instanceRef G2))
		     (portref D)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell OND4C
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A (direction input)
		 (property cap (number (e 990 -3))))
	      (port B (direction input)
		 (property cap (number (e 1020 -3))))
	      (port C (direction input)
		 (property cap (number (e 990 -3))))
	      (port D (direction input)
		 (property cap (number (e 1010 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref D)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell OND56
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 6000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1160 -3))))
	      (port B (direction input)
		 (property cap (number (e 1010 -3))))
	      (port C (direction input)
		 (property cap (number (e 960 -3))))
	      (port D (direction input)
		 (property cap (number (e 970 -3))))
	      (port E (direction input)
		 (property cap (number (e 1030 -3))))
	      (port F (direction input)
		 (property cap (number (e 960 -3))))
	      (port G (direction input)
		 (property cap (number (e 960 -3))))
	      (port H (direction input)
		 (property cap (number (e 980 -3))))
	      (port I (direction input)
		 (property cap (number (e 1000 -3))))
	      (port J (direction input)
		 (property cap (number (e 990 -3))))
	      (port K (direction input)
		 (property cap (number (e 970 -3))))
	      (port L (direction input)
		 (property cap (number (e 960 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef OR4 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef OR4 (libraryRef PRIMLIB))))
	      (instance G5
		 (viewRef INTERFACE (cellRef OR4 (libraryRef PRIMLIB))))
	      (instance G6
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in2 (instanceRef G6))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in1 (instanceRef G6))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in0 (instanceRef G6))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G6))
		 )
	      )
	      (net NN4
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G5))
		 )
	      )
	      (net NN5
		 (joined
		     (portRef in (instanceRef G2))
		     (portRef out (instanceRef G4))
		 )
	      )
	      (net NN6
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net A
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in2 (instanceRef G3))
		     (portref B)
		 )
	      )
	      (net C
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portref C)
		 )
	      )
	      (net D
		 (joined
		     (portRef in3 (instanceRef G3))
		     (portref D)
		 )
	      )
	      (net E
		 (joined
		     (portRef in1 (instanceRef G4))
		     (portref E)
		 )
	      )
	      (net F
		 (joined
		     (portRef in2 (instanceRef G4))
		     (portref F)
		 )
	      )
	      (net G
		 (joined
		     (portRef in0 (instanceRef G4))
		     (portref G)
		 )
	      )
	      (net H
		 (joined
		     (portRef in3 (instanceRef G4))
		     (portref H)
		 )
	      )
	      (net I
		 (joined
		     (portRef in1 (instanceRef G5))
		     (portref I)
		 )
	      )
	      (net J
		 (joined
		     (portRef in2 (instanceRef G5))
		     (portref J)
		 )
	      )
	      (net K
		 (joined
		     (portRef in0 (instanceRef G5))
		     (portref K)
		 )
	      )
	      (net L
		 (joined
		     (portRef in3 (instanceRef G5))
		     (portref L)
		 )
	      )
	   )
	   (property area (number (e 14 0)))
	)
     )
     (cell ND2I
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1010 -3))))
	      (port B (direction input)
		 (property cap (number (e 1010 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in (instanceRef G0))
		     (portref B)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G1))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell IV
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port A (direction input)
		 (property cap (number (e 890 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 2 0)))
	)
     )
     (cell IVS
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 29000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1560 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 3 0)))
	)
     )
     (cell IVM
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 36000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1970 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 3 0)))
	)
     )
     (cell IVML
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 46000 -3))))
	      (port A (direction input)
		 (property cap (number (e 2920 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell IVH
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 64000 -3))))
	      (port A (direction input)
		 (property cap (number (e 3850 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell IVU
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 107000 -3))))
	      (port A (direction input)
		 (property cap (number (e 7750 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	   )
	   (property area (number (e 9 0)))
	)
     )
     (cell NIV
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A (direction input)
		 (property cap (number (e 980 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef BUF (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	   )
	   (property area (number (e 3 0)))
	)
     )
     (cell NIVM
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 36000 -3))))
	      (port A (direction input)
		 (property cap (number (e 710 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef BUF (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	   )
	   (property area (number (e 4 0)))
	)
     )
     (cell NIVH
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 64000 -3))))
	      (port A (direction input)
		 (property cap (number (e 1990 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef BUF (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	   )
	   (property area (number (e 7 0)))
	)
     )
     (cell NIVU
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 107000 -3))))
	      (port A (direction input)
		 (property cap (number (e 2090 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef BUF (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net A
		 (joined
		     (portRef in (instanceRef G0))
		     (portref A)
		 )
	      )
	   )
	   (property area (number (e 11 0)))
	)
     )
     (cell MX2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 20000 -3))))
	      (port A0 (direction input)
		 (property cap (number (e 1030 -3))))
	      (port A1 (direction input)
		 (property cap (number (e 1010 -3))))
	      (port S (direction input)
		 (property cap (number (e 1980 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G1))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net S
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef in0 (instanceRef G2))
		     (portref S)
		 )
	      )
	      (net A0
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portref A0)
		 )
	      )
	      (net NN5
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net A1
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref A1)
		 )
	      )
	   )
	   (property area (number (e 6 0)))
	)
     )
     (cell MX2G
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A0 (direction input)
		 (property cap (number (e 1020 -3))))
	      (port A1 (direction input)
		 (property cap (number (e 1030 -3))))
	      (port S (direction input)
		 (property cap (number (e 1970 -3))))
	      (port GN (direction input)
		 (property cap (number (e 980 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G5
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G6
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in1 (instanceRef G6))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN2
		 (joined
		     (portRef in (instanceRef G2))
		     (portRef out (instanceRef G6))
		 )
	      )
	      (net NN3
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G5))
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G2))
		     (portref O)
		 )
	      )
	      (net GN
		 (joined
		     (portRef in0 (instanceRef G6))
		     (portref GN)
		 )
	      )
	      (net NN6
		 (joined
		     (portRef in0 (instanceRef G5))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net S
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef in0 (instanceRef G4))
		     (portref S)
		 )
	      )
	      (net A0
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref A0)
		 )
	      )
	      (net NN9
		 (joined
		     (portRef in1 (instanceRef G5))
		     (portRef out (instanceRef G4))
		 )
	      )
	      (net A1
		 (joined
		     (portRef in1 (instanceRef G4))
		     (portref A1)
		 )
	      )
	   )
	   (property area (number (e 7 0)))
	)
     )
     (cell MXI2
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 11000 -3))))
	      (port A0 (direction input)
		 (property cap (number (e 1020 -3))))
	      (port A1 (direction input)
		 (property cap (number (e 1010 -3))))
	      (port S (direction input)
		 (property cap (number (e 1980 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef out (instanceRef G4))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net NN3
		 (joined
		     (portRef in0 (instanceRef G4))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net S
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef in0 (instanceRef G3))
		     (portref S)
		 )
	      )
	      (net A0
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portref A0)
		 )
	      )
	      (net NN6
		 (joined
		     (portRef in1 (instanceRef G4))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net A1
		 (joined
		     (portRef in1 (instanceRef G3))
		     (portref A1)
		 )
	      )
	   )
	   (property area (number (e 5 0)))
	)
     )
     (cell MXI2G
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 10000 -3))))
	      (port A0 (direction input)
		 (property cap (number (e 740 -3))))
	      (port A1 (direction input)
		 (property cap (number (e 740 -3))))
	      (port S (direction input)
		 (property cap (number (e 1730 -3))))
	      (port GN (direction input)
		 (property cap (number (e 760 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G4))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in0 (instanceRef G3))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O
		 (joined
		     (portref O)
		     (portRef out (instanceRef G4))
		 )
	      )
	      (net NN3
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net GN
		 (joined
		     (portRef in1 (instanceRef G4))
		     (portref GN)
		 )
	      )
	      (net A0
		 (joined
		     (portRef in0 (instanceRef G2))
		     (portref A0)
		 )
	      )
	      (net S
		 (joined
		     (portRef in1 (instanceRef G2))
		     (portRef in1 (instanceRef G3))
		     (portref S)
		 )
	      )
	      (net NN7
		 (joined
		     (portRef in2 (instanceRef G4))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net A1
		 (joined
		     (portRef in (instanceRef G1))
		     (portref A1)
		 )
	      )
	   )
	   (property area (number (e 8 0)))
	)
     )
     (cell DEC24L
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O0 (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port O1 (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port O2 (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port O3 (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port A0 (direction input)
		 (property cap (number (e 1390 -3))))
	      (port A1 (direction input)
		 (property cap (number (e 1390 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G5
		 (viewRef INTERFACE (cellRef OR2 (libraryRef PRIMLIB))))
	      (instance G6
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G7
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G8
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in0 (instanceRef G7))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net NN1
		 (joined
		     (portRef in1 (instanceRef G6))
		     (portRef out (instanceRef G1))
		 )
	      )
	      (net O0
		 (joined
		     (portref O0)
		     (portRef out (instanceRef G5))
		 )
	      )
	      (net A0
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef in0 (instanceRef G5))
		     (portRef in0 (instanceRef G6))
		     (portRef in0 (instanceRef G8))
		     (portref A0)
		 )
	      )
	      (net A1
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef in1 (instanceRef G5))
		     (portRef in1 (instanceRef G7))
		     (portRef in1 (instanceRef G8))
		     (portref A1)
		 )
	      )
	      (net NN5
		 (joined
		     (portRef in (instanceRef G4))
		     (portRef out (instanceRef G6))
		 )
	      )
	      (net O1
		 (joined
		     (portRef out (instanceRef G4))
		     (portref O1)
		 )
	      )
	      (net NN7
		 (joined
		     (portRef in (instanceRef G3))
		     (portRef out (instanceRef G7))
		 )
	      )
	      (net O2
		 (joined
		     (portRef out (instanceRef G3))
		     (portref O2)
		 )
	      )
	      (net NN9
		 (joined
		     (portRef in (instanceRef G2))
		     (portRef out (instanceRef G8))
		 )
	      )
	      (net O3
		 (joined
		     (portRef out (instanceRef G2))
		     (portref O3)
		 )
	      )
	   )
	   (property area (number (e 14 0)))
	)
     )
     (cell HA
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port S (direction output)
		 (property maxcap (number (e 8000 -3))))
	      (port CO (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port A (direction input)
		 (property cap (number (e 2580 -3))))
	      (port B (direction input)
		 (property cap (number (e 2480 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef XOR2 (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (net S
		 (joined
		     (portRef out (instanceRef G0))
		     (portref S)
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portRef in0 (instanceRef G1))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portRef in1 (instanceRef G1))
		     (portref B)
		 )
	      )
	      (net CO
		 (joined
		     (portRef out (instanceRef G1))
		     (portref CO)
		 )
	      )
	   )
	   (property area (number (e 9 0)))
	)
     )
     (cell FA
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port S (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port CO (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port A (direction input)
		 (property cap (number (e 780 -3))))
	      (port B (direction input)
		 (property cap (number (e 2280 -3))))
	      (port CI (direction input)
		 (property cap (number (e 1480 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef XOR2 (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef XOR2 (libraryRef PRIMLIB))))
	      (instance G2
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G3
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G4
		 (viewRef INTERFACE (cellRef AND2 (libraryRef PRIMLIB))))
	      (instance G5
		 (viewRef INTERFACE (cellRef OR3 (libraryRef PRIMLIB))))
	      (net CO
		 (joined
		     (portref CO)
		     (portRef out (instanceRef G5))
		 )
	      )
	      (net S
		 (joined
		     (portRef out (instanceRef G1))
		     (portref S)
		 )
	      )
	      (net NN2
		 (joined
		     (portRef out (instanceRef G0))
		     (portRef in0 (instanceRef G1))
		 )
	      )
	      (net A
		 (joined
		     (portRef in0 (instanceRef G0))
		     (portRef in0 (instanceRef G2))
		     (portRef in0 (instanceRef G3))
		     (portref A)
		 )
	      )
	      (net B
		 (joined
		     (portRef in1 (instanceRef G0))
		     (portRef in1 (instanceRef G2))
		     (portRef in0 (instanceRef G4))
		     (portref B)
		 )
	      )
	      (net CI
		 (joined
		     (portRef in1 (instanceRef G1))
		     (portRef in1 (instanceRef G3))
		     (portRef in1 (instanceRef G4))
		     (portref CI)
		 )
	      )
	      (net NN6
		 (joined
		     (portRef in1 (instanceRef G5))
		     (portRef out (instanceRef G2))
		 )
	      )
	      (net NN7
		 (joined
		     (portRef in0 (instanceRef G5))
		     (portRef out (instanceRef G3))
		 )
	      )
	      (net NN8
		 (joined
		     (portRef in2 (instanceRef G5))
		     (portRef out (instanceRef G4))
		 )
	      )
	   )
	   (property area (number (e 16 0)))
	)
     )
     (cell FF
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef DFF (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 18 0)))
	)
     )
     (cell FFP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef DFF (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 21 0)))
	)
     )
     (cell FFR
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port RESET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef DFFR (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net RESET
		 (joined
		     (portRef reset (instanceRef G1))
		     (portref RESET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 23 0)))
	)
     )
     (cell FFRP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port RESET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef DFFR (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net RESET
		 (joined
		     (portRef reset (instanceRef G1))
		     (portref RESET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 26 0)))
	)
     )
     (cell FFS
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port SET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef DFFS (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net SET
		 (joined
		     (portRef set (instanceRef G1))
		     (portref SET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 23 0)))
	)
     )
     (cell FFSP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port SET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef DFFS (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net SET
		 (joined
		     (portRef set (instanceRef G1))
		     (portref SET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 26 0)))
	)
     )
     (cell FFSR
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port SET (direction input)
		 (property cap (number (e 2100 -3))))
	      (port RESET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef DFFSR (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net RESET
		 (joined
		     (portRef reset (instanceRef G1))
		     (portref RESET)
		 )
	      )
	      (net SET
		 (joined
		     (portRef set (instanceRef G1))
		     (portref SET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 27 0)))
	)
     )
     (cell FFSRP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port SET (direction input)
		 (property cap (number (e 2100 -3))))
	      (port RESET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef DFFSR (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net RESET
		 (joined
		     (portRef reset (instanceRef G1))
		     (portref RESET)
		 )
	      )
	      (net SET
		 (joined
		     (portRef set (instanceRef G1))
		     (portref SET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 30 0)))
	)
     )
     (cell LAT
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef LATCH (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 18 0)))
	)
     )
     (cell LATP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef LATCH (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 21 0)))
	)
     )
     (cell LATR
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port RESET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef LATCHR (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net RESET
		 (joined
		     (portRef reset (instanceRef G1))
		     (portref RESET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 23 0)))
	)
     )
     (cell LATRP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port RESET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef LATCHR (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net RESET
		 (joined
		     (portRef reset (instanceRef G1))
		     (portref RESET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 26 0)))
	)
     )
     (cell LATS
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port SET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef LATCHS (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net SET
		 (joined
		     (portRef set (instanceRef G1))
		     (portref SET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 23 0)))
	)
     )
     (cell LATSP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port SET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef LATCHS (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net SET
		 (joined
		     (portRef set (instanceRef G1))
		     (portref SET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 26 0)))
	)
     )
     (cell LATSR
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 15000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port SET (direction input)
		 (property cap (number (e 2100 -3))))
	      (port RESET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef LATCHSR (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net RESET
		 (joined
		     (portRef reset (instanceRef G1))
		     (portref RESET)
		 )
	      )
	      (net SET
		 (joined
		     (portRef set (instanceRef G1))
		     (portref SET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 27 0)))
	)
     )
     (cell LATSRP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port Q (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port QB (direction output)
		 (property maxcap (number (e 28000 -3))))
	      (port D (direction input)
		 (property cap (number (e 1000 -3))))
	      (port CLK (direction input)
		 (property cap (number (e 1730 -3))))
	      (port SET (direction input)
		 (property cap (number (e 2100 -3))))
	      (port RESET (direction input)
		 (property cap (number (e 2100 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef LATCHSR (libraryRef PRIMLIB))))
	      (net Q
		 (joined
		     (portRef in (instanceRef G0))
		     (portRef out (instanceRef G1))
		     (portref Q)
		 )
	      )
	      (net D
		 (joined
		     (portRef in (instanceRef G1))
		     (portref D)
		 )
	      )
	      (net CLK
		 (joined
		     (portRef clk (instanceRef G1))
		     (portref CLK)
		 )
	      )
	      (net RESET
		 (joined
		     (portRef reset (instanceRef G1))
		     (portref RESET)
		 )
	      )
	      (net SET
		 (joined
		     (portRef set (instanceRef G1))
		     (portref SET)
		 )
	      )
	      (net QB
		 (joined
		     (portRef out (instanceRef G0))
		     (portref QB)
		 )
	      )
	   )
	   (property area (number (e 30 0)))
	)
     )
     (cell TBUF
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port IN (direction input)
		 (property cap (number (e 1600 -3))))
	      (port EN (direction input)
		 (property cap (number (e 1600 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef TRI (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net IN
		 (joined
		     (portRef in (instanceRef G0))
		     (portref IN)
		 )
	      )
	      (net EN
		 (joined
		     (portRef en (instanceRef G0))
		     (portref EN)
		 )
	      )
	   )
	   (property area (number (e 8 0)))
	)
     )
     (cell TBUFI
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 19000 -3))))
	      (port IN (direction input)
		 (property cap (number (e 1600 -3))))
	      (port EN (direction input)
		 (property cap (number (e 1600 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef TRI (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G1))
		     (portref O)
		 )
	      )
	      (net IN
		 (joined
		     (portRef in (instanceRef G0))
		     (portref IN)
		 )
	      )
	      (net EN
		 (joined
		     (portRef en (instanceRef G1))
		     (portref EN)
		 )
	      )
	   )
	   (property area (number (e 7 0)))
	)
     )
     (cell TBUFP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 30000 -3))))
	      (port IN (direction input)
		 (property cap (number (e 1600 -3))))
	      (port EN (direction input)
		 (property cap (number (e 1600 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef TRI (libraryRef PRIMLIB))))
	      (net O
		 (joined
		     (portRef out (instanceRef G0))
		     (portref O)
		 )
	      )
	      (net IN
		 (joined
		     (portRef in (instanceRef G0))
		     (portref IN)
		 )
	      )
	      (net EN
		 (joined
		     (portRef en (instanceRef G0))
		     (portref EN)
		 )
	      )
	   )
	   (property area (number (e 10 0)))
	)
     )
     (cell TBUFIP
	(cellType GENERIC)
	(view INTERFACE
	   (viewType NETLIST)
	   (interface
	      (port O (direction output)
		 (property maxcap (number (e 30000 -3))))
	      (port IN (direction input)
		 (property cap (number (e 1600 -3))))
	      (port EN (direction input)
		 (property cap (number (e 1600 -3))))
	   )
	   (contents
	      (instance G0
		 (viewRef INTERFACE (cellRef INV (libraryRef PRIMLIB))))
	      (instance G1
		 (viewRef INTERFACE (cellRef TRI (libraryRef PRIMLIB))))
	      (net NN0
		 (joined
		     (portRef in (instanceRef G1))
		     (portRef out (instanceRef G0))
		 )
	      )
	      (net O
		 (joined
		     (portRef out (instanceRef G1))
		     (portref O)
		 )
	      )
	      (net IN
		 (joined
		     (portRef in (instanceRef G0))
		     (portref IN)
		 )
	      )
	      (net EN
		 (joined
		     (portRef en (instanceRef G1))
		     (portref EN)
		 )
	      )
	   )
	   (property area (number (e 9 0)))
	)
     )
  )
)
