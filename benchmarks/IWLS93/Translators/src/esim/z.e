(edif netlist
  (edifVersion 2 0 0)
  (edifLevel 0)
  (keywordMap (keywordLevel 0))
  (status
    (written
      (timeStamp 1993 1 25 0 53 46)
      (author "David Rickel")
      (program "autologic")
    )
  )
  (external IWLS3
    (edifLevel 0)
    (technology
      (numberDefinition
      )
      (simulationInfo
        (logicValue H (booleanMap (true)))
        (logicValue L (booleanMap (false)))
      )
    )
    (cell NIV
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
        )
      )
    )
    (cell AN2
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
        )
      )
    )
    (cell NR2
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
        )
      )
    )
    (cell MX2
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A0 (direction input))
          (port A1 (direction input))
          (port S (direction input))
        )
      )
    )
    (cell EO
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
        )
      )
    )
    (cell MXI2
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A0 (direction input))
          (port A1 (direction input))
          (port S (direction input))
        )
      )
    )
    (cell ND3
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port C (direction input))
          (port B (direction input))
        )
      )
    )
    (cell OND1
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
          (port C (direction input))
        )
      )
    )
    (cell OAN1
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
          (port C (direction input))
        )
      )
    )
    (cell ND2I
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
        )
      )
    )
    (cell EN
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
        )
      )
    )
    (cell AN3
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
          (port C (direction input))
        )
      )
    )
    (cell ND4
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port C (direction input))
          (port B (direction input))
          (port D (direction input))
        )
      )
    )
    (cell OND4C
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
          (port C (direction input))
          (port D (direction input))
        )
      )
    )
    (cell ANR2
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
          (port C (direction input))
          (port D (direction input))
        )
      )
    )
    (cell OR4
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
          (port C (direction input))
          (port D (direction input))
        )
      )
    )
    (cell ANR3
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port B (direction input))
          (port A (direction input))
          (port C (direction input))
          (port D (direction input))
        )
      )
    )
    (cell IV
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
        )
      )
    )
    (cell OND3
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
          (port C (direction input))
          (port D (direction input))
        )
      )
    )
    (cell ANR4C
      (cellType GENERIC)
      (view INTERFACE
        (viewType NETLIST)
        (interface
          (port O (direction output))
          (port A (direction input))
          (port B (direction input))
          (port C (direction input))
          (port D (direction input))
        )
      )
    )
  )
  (library USER_LIB
    (edifLevel 0)
    (technology
      (numberDefinition
      )
      (simulationInfo
        (logicValue H (booleanMap (true)))
        (logicValue L (booleanMap (false)))
      )
    )
    (cell TOP
      (cellType GENERIC)
      (view NETLIST
        (viewType NETLIST)
        (interface
          (port o_9_ (direction output))
          (port o_8_ (direction output))
          (port o_7_ (direction output))
          (port o_6_ (direction output))
          (port o_5_ (direction output))
          (port o_4_ (direction output))
          (port o_3_ (direction output))
          (port o_2_ (direction output))
          (port o_1_ (direction output))
          (port o_0_ (direction output))
          (port i_6_ (direction input))
          (port i_5_ (direction input))
          (port i_4_ (direction input))
          (port i_3_ (direction input))
          (port i_2_ (direction input))
          (port i_1_ (direction input))
          (port i_0_ (direction input))
        )
        (contents
          (instance G_G0
            (viewRef INTERFACE (cellRef ANR4C (libraryRef IWLS3))))
          (instance G_G1
            (viewRef INTERFACE (cellRef OND3 (libraryRef IWLS3))))
          (instance G_G2
            (viewRef INTERFACE (cellRef IV (libraryRef IWLS3))))
          (instance G_G3
            (viewRef INTERFACE (cellRef ANR3 (libraryRef IWLS3))))
          (instance G_G4
            (viewRef INTERFACE (cellRef IV (libraryRef IWLS3))))
          (instance G_G5
            (viewRef INTERFACE (cellRef OR4 (libraryRef IWLS3))))
          (instance G_G6
            (viewRef INTERFACE (cellRef IV (libraryRef IWLS3))))
          (instance G_G7
            (viewRef INTERFACE (cellRef OR4 (libraryRef IWLS3))))
          (instance G_G8
            (viewRef INTERFACE (cellRef ANR2 (libraryRef IWLS3))))
          (instance G_G9
            (viewRef INTERFACE (cellRef OND4C (libraryRef IWLS3))))
          (instance G_G10
            (viewRef INTERFACE (cellRef IV (libraryRef IWLS3))))
          (instance G_G11
            (viewRef INTERFACE (cellRef OND3 (libraryRef IWLS3))))
          (instance G_G12
            (viewRef INTERFACE (cellRef OND3 (libraryRef IWLS3))))
          (instance G_G13
            (viewRef INTERFACE (cellRef ND4 (libraryRef IWLS3))))
          (instance G_G14
            (viewRef INTERFACE (cellRef AN3 (libraryRef IWLS3))))
          (instance G_G15
            (viewRef INTERFACE (cellRef EN (libraryRef IWLS3))))
          (instance G_G16
            (viewRef INTERFACE (cellRef ND2I (libraryRef IWLS3))))
          (instance G_G17
            (viewRef INTERFACE (cellRef OAN1 (libraryRef IWLS3))))
          (instance G_G18
            (viewRef INTERFACE (cellRef OND1 (libraryRef IWLS3))))
          (instance G_G19
            (viewRef INTERFACE (cellRef ND3 (libraryRef IWLS3))))
          (instance G_G20
            (viewRef INTERFACE (cellRef OND1 (libraryRef IWLS3))))
          (instance G_G21
            (viewRef INTERFACE (cellRef AN3 (libraryRef IWLS3))))
          (instance G_G22
            (viewRef INTERFACE (cellRef MXI2 (libraryRef IWLS3))))
          (instance G_G23
            (viewRef INTERFACE (cellRef EO (libraryRef IWLS3))))
          (instance G_G24
            (viewRef INTERFACE (cellRef MXI2 (libraryRef IWLS3))))
          (instance G_G25
            (viewRef INTERFACE (cellRef MX2 (libraryRef IWLS3))))
          (instance G_G26
            (viewRef INTERFACE (cellRef MXI2 (libraryRef IWLS3))))
          (instance G_G27
            (viewRef INTERFACE (cellRef NR2 (libraryRef IWLS3))))
          (instance G_G28
            (viewRef INTERFACE (cellRef IV (libraryRef IWLS3))))
          (instance G_G29
            (viewRef INTERFACE (cellRef EN (libraryRef IWLS3))))
          (instance G_G30
            (viewRef INTERFACE (cellRef EN (libraryRef IWLS3))))
          (instance G_G31
            (viewRef INTERFACE (cellRef AN2 (libraryRef IWLS3))))
          (instance G_G32
            (viewRef INTERFACE (cellRef EN (libraryRef IWLS3))))
          (instance G_G33
            (viewRef INTERFACE (cellRef EN (libraryRef IWLS3))))
          (instance G_G34
            (viewRef INTERFACE (cellRef NIV (libraryRef IWLS3))))
          (instance G_G35
            (viewRef INTERFACE (cellRef NIV (libraryRef IWLS3))))
          (instance G_G36
            (viewRef INTERFACE (cellRef NIV (libraryRef IWLS3))))
          (instance G_G37
            (viewRef INTERFACE (cellRef NIV (libraryRef IWLS3))))
          (instance G_G38
            (viewRef INTERFACE (cellRef NIV (libraryRef IWLS3))))
          (instance G_G39
            (viewRef INTERFACE (cellRef NIV (libraryRef IWLS3))))
          (instance G_G40
            (viewRef INTERFACE (cellRef NIV (libraryRef IWLS3))))
          (net N_N0
            (joined
              (portRef A (instanceRef G_G0))
              (portRef D (instanceRef G_G5))
              (portRef A (instanceRef G_G9))
              (portRef C (instanceRef G_G12))
              (portRef A (instanceRef G_G20))
              (portRef S (instanceRef G_G22))
              (portRef B (instanceRef G_G30))
              (portRef O (instanceRef G_G40))
            )
          )
          (net N_N1
            (joined
              (portRef B (instanceRef G_G21))
              (portRef S (instanceRef G_G24))
              (portRef S (instanceRef G_G25))
              (portRef S (instanceRef G_G26))
              (portRef A (instanceRef G_G32))
              (portRef O (instanceRef G_G39))
            )
          )
          (net N_N2
            (joined
              (portRef C (instanceRef G_G8))
              (portRef C (instanceRef G_G9))
              (portRef C (instanceRef G_G11))
              (portRef C (instanceRef G_G20))
              (portRef A (instanceRef G_G21))
              (portRef A (instanceRef G_G23))
              (portRef A0 (instanceRef G_G25))
              (portRef O (instanceRef G_G38))
            )
          )
          (net N_N3
            (joined
              (portRef A (instanceRef G_G1))
              (portRef A (instanceRef G_G3))
              (portRef B (instanceRef G_G14))
              (portRef A (instanceRef G_G16))
              (portRef A (instanceRef G_G28))
              (portRef O (instanceRef G_G37))
            )
          )
          (net N_N4
            (joined
              (portRef B (instanceRef G_G1))
              (portRef B (instanceRef G_G3))
              (portRef B (instanceRef G_G12))
              (portRef C (instanceRef G_G14))
              (portRef B (instanceRef G_G16))
              (portRef B (instanceRef G_G17))
              (portRef B (instanceRef G_G18))
              (portRef A (instanceRef G_G27))
              (portRef A (instanceRef G_G29))
              (portRef O (instanceRef G_G36))
            )
          )
          (net N_N5
            (joined
              (portRef C (instanceRef G_G1))
              (portRef C (instanceRef G_G3))
              (portRef A (instanceRef G_G12))
              (portRef A (instanceRef G_G14))
              (portRef A (instanceRef G_G15))
              (portRef A (instanceRef G_G17))
              (portRef A (instanceRef G_G18))
              (portRef B (instanceRef G_G27))
              (portRef O (instanceRef G_G35))
            )
          )
          (net N_N6
            (joined
              (portRef D (instanceRef G_G1))
              (portRef D (instanceRef G_G3))
              (portRef C (instanceRef G_G5))
              (portRef D (instanceRef G_G12))
              (portRef C (instanceRef G_G17))
              (portRef B (instanceRef G_G33))
              (portRef O (instanceRef G_G34))
            )
          )
          (net N_N7
            (joined
              (portRef O (instanceRef G_G4))
              (portRef B (instanceRef G_G9))
              (portRef B (instanceRef G_G13))
            )
          )
          (net N_N8
            (joined
              (portRef O (instanceRef G_G12))
              (portRef A (instanceRef G_G13))
            )
          )
          (net N_N9
            (joined
              (portRef O (instanceRef G_G1))
              (portRef A (instanceRef G_G2))
              (portRef D (instanceRef G_G13))
            )
          )
          (net N_N10
            (joined
              (portRef O (instanceRef G_G10))
              (portRef A1 (instanceRef G_G24))
            )
          )
          (net N_N11
            (joined
              (portRef D (instanceRef G_G0))
              (portRef O (instanceRef G_G6))
            )
          )
          (net N_N12
            (joined
              (portRef A (instanceRef G_G6))
              (portRef A (instanceRef G_G8))
              (portRef O (instanceRef G_G11))
            )
          )
          (net N_N13
            (joined
              (portRef O (instanceRef G_G7))
              (portRef A (instanceRef G_G30))
            )
          )
          (net N_N14
            (joined
              (portRef B (instanceRef G_G15))
              (portRef O (instanceRef G_G16))
            )
          )
          (net N_N15
            (joined
              (portRef A (instanceRef G_G5))
              (portRef D (instanceRef G_G7))
              (portRef O (instanceRef G_G14))
            )
          )
          (net N_N16
            (joined
              (portRef C (instanceRef G_G19))
              (portRef O (instanceRef G_G23))
              (portRef A1 (instanceRef G_G26))
            )
          )
          (net N_N17
            (joined
              (portRef O (instanceRef G_G8))
              (portRef A1 (instanceRef G_G25))
            )
          )
          (net N_N18
            (joined
              (portRef C (instanceRef G_G0))
              (portRef A0 (instanceRef G_G24))
              (portRef O (instanceRef G_G31))
            )
          )
          (net N_N19
            (joined
              (portRef O (instanceRef G_G0))
              (portRef A0 (instanceRef G_G26))
            )
          )
          (net N_N20
            (joined
              (portRef C (instanceRef G_G7))
              (portRef O (instanceRef G_G27))
            )
          )
          (net N_N21
            (joined
              (portRef O (instanceRef G_G5))
              (portRef D (instanceRef G_G8))
              (portRef D (instanceRef G_G9))
              (portRef C (instanceRef G_G13))
              (portRef A (instanceRef G_G19))
              (portRef C (instanceRef G_G21))
              (portRef A0 (instanceRef G_G22))
            )
          )
          (net N_N22
            (joined
              (portRef O (instanceRef G_G18))
              (portRef A (instanceRef G_G33))
            )
          )
          (net N_N23
            (joined
              (portRef O (instanceRef G_G13))
              (portRef B (instanceRef G_G19))
              (portRef B (instanceRef G_G32))
            )
          )
          (net N_N24
            (joined
              (portRef B (instanceRef G_G8))
              (portRef O (instanceRef G_G9))
              (portRef A (instanceRef G_G10))
            )
          )
          (net N_N25
            (joined
              (portRef A (instanceRef G_G11))
              (portRef O (instanceRef G_G20))
              (portRef B (instanceRef G_G31))
            )
          )
          (net N_N26
            (joined
              (portRef D (instanceRef G_G11))
              (portRef O (instanceRef G_G19))
              (portRef A (instanceRef G_G31))
            )
          )
          (net N_N27
            (joined
              (portRef O (instanceRef G_G22))
              (portRef B (instanceRef G_G23))
            )
          )
          (net N_N28
            (joined
              (portRef B (instanceRef G_G11))
              (portRef O (instanceRef G_G17))
            )
          )
          (net N_N29
            (joined
              (portRef B (instanceRef G_G0))
              (portRef O (instanceRef G_G2))
              (portRef B (instanceRef G_G5))
              (portRef B (instanceRef G_G7))
              (portRef B (instanceRef G_G20))
            )
          )
          (net N_N30
            (joined
              (portRef O (instanceRef G_G3))
              (portRef A (instanceRef G_G4))
              (portRef A (instanceRef G_G7))
              (portRef A1 (instanceRef G_G22))
            )
          )
          (net N_N164
            (joined
              (portRef i_0_)
              (portRef A (instanceRef G_G34))
            )
          )
          (net N_N163
            (joined
              (portRef i_1_)
              (portRef A (instanceRef G_G35))
            )
          )
          (net N_N162
            (joined
              (portRef i_2_)
              (portRef A (instanceRef G_G36))
            )
          )
          (net N_N160
            (joined
              (portRef i_4_)
              (portRef A (instanceRef G_G38))
            )
          )
          (net N_N159
            (joined
              (portRef i_5_)
              (portRef A (instanceRef G_G39))
            )
          )
          (net N_N158
            (joined
              (portRef i_6_)
              (portRef A (instanceRef G_G40))
            )
          )
          (net N_N157
            (joined
              (portRef o_0_)
              (portRef O (instanceRef G_G25))
            )
          )
          (net N_N156
            (joined
              (portRef o_1_)
              (portRef O (instanceRef G_G24))
            )
          )
          (net N_N155
            (joined
              (portRef o_2_)
              (portRef O (instanceRef G_G26))
            )
          )
          (net N_N154
            (joined
              (portRef o_3_)
              (portRef O (instanceRef G_G32))
            )
          )
          (net N_N153
            (joined
              (portRef o_4_)
              (portRef O (instanceRef G_G30))
            )
          )
          (net N_N152
            (joined
              (portRef o_5_)
              (portRef O (instanceRef G_G33))
            )
          )
          (net N_N151
            (joined
              (portRef o_6_)
              (portRef O (instanceRef G_G15))
            )
          )
          (net N_N150
            (joined
              (portRef o_7_)
              (portRef C (instanceRef G_G18))
              (portRef O (instanceRef G_G29))
            )
          )
          (net N_N149
            (joined
              (portRef o_9_)
              (portRef O (instanceRef G_G21))
            )
          )
          (net N_N31
            (joined
              (portRef o_8_)
              (portRef O (instanceRef G_G28))
              (portRef B (instanceRef G_G29))
            )
          )
          (net N_N161
            (joined
              (portRef i_3_)
              (portRef A (instanceRef G_G37))
            )
          )
        )
      )
    )
  )
)
