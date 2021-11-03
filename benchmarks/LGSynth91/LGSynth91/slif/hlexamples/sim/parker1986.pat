# parker1986 input pattern file
#
# simulation outputs verified; traces saved in parker1986.trace.gold
#
# R Gupta 7/17/90
#
#
.inputs in1[7:7] in1[6:6] in1[5:5] in1[4:4] in1[3:3] in1[2:2] in1[1:1] in1[0:0] in2[7:7] in2[6:6] in2[5:5] in2[4:4] in2[3:3] in2[2:2] in2[1:1] in2[0:0] in3[7:7] in3[6:6] in3[5:5] in3[4:4] in3[3:3] in3[2:2] in3[1:1] in3[0:0] in4[7:7] in4[6:6] in4[5:5] in4[4:4] in4[3:3] in4[2:2] in4[1:1] in4[0:0] in5[7:7] in5[6:6] in5[5:5] in5[4:4] in5[3:3] in5[2:2] in5[1:1] in5[0:0] in6[7:7] in6[6:6] in6[5:5] in6[4:4] in6[3:3] in6[2:2] in6[1:1] in6[0:0] ; 
#
# all zeros; => t6 = 8, out1 = -5 ( BF ); 
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ;
#
# in1=6; t6 = 8; out1 = 1 ; 
0000 0110 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ;
#
# (7, 0, 0, 6, 1, 0) t1=1; t2=0; t3=1; t4=1; t5=6 t6=7; t7=0 out1=2
0000 0111 0000 0000 0000 0000 0000 0110 0000 0001 0000 0000 ;
#
# (in1, in2, ..., in6) => (t1, t2, ..., t7)
# ( 24 63 64 67 74 92 ) = > ( -18 127 20 67 0 134 0 ); out1 = 19
# ( 18 3F 40 43 4A 5C ) = > 13
0001 1000 0011 1111 0100 0000 0100 0011 0100 1010 0101 1100 ;
#
# ( 97 1  53 39 52 37 ) => ( 15 54 93 5 0 44 0 ); out1 = 92
# ( 61 01 35 27 34 25 ) => 5C
0110 0001 0000 0001 0011 0101 0010 0111 0011 0100 0010 0101 ;
#
# ( 56 47 72 87 76 49 ) => ( 27 119 52 51 0 138 0 ); out1 = 51
# ( 38 2F 48 57 4C 31 ) => 33
0011 1000 0010 1111 0100 1000 0101 0111 0100 1100 0011 0001 ;
#
# ( 81 61 59 54 42 60 ) => ( -18 120 77 65 0 119 0 ); out1 = 76
# ( 51 33 3B 36 2A 32 ) => 4C 
0101 0001 0011 0011 0011 1011 0011 0110 0010 1010 0011 0010  ;
#
# ( 89 81 61 59 54 42 ) => ( 12 142 85 85 0 144 0 ); out1 = 84
# ( 59 51 3d 3b 36 2a ) => out1 = 54
0101 1001 0101 0001 0011 1101 0011 1011 0011 0110 0010 1010 ;
#
# ( 51 3d 3b 36 2a 3c ) => ( EE 87 d4 14 0 77 0 ); out1 = c4  
0101 0001 0011 1101 0011 1011 0011 0110 0010 1010 0011 1100 ;
#
# ( 73 89 81 61 59 54 ) => ( 5 170 69 93 0 154 0 ); out1 = 68
# ( 49 59 51 3d 3b 36 ) => ( 05 aa 45 5d 0 9a 0 ); out1 = 44
0100 1001 0101 1001 0101 0001 0011 1101 0011 1011 0011 0110 ;
#
# ( 13 35 42 60 57 49 ) => ( 8 77 9 39 0 99 0 ); out1 = 8
# ( 0d 23 2a 3c 39 31 ) => ( 8 4d 9 27 0 63 0 ); out1 = 8
0000 1101 0010 0011 0010 1010  0011 1100 0011 1001 0011 0001 ;
#
# ( 1 53 39 52 37 47 ) => ( -10 92 -3 57 0 109 0 ); out1 = -4
# ( 1 35 27 34 25 2f ) => ( f6 5c fd 39 0 6d 0 ); out1 = fc
0000 0001 0011 0101 0010 0111 0011 0100 0010 0101 0010 1111 ;
#
# ( 59 54 42 60 57 49 ) => ( 8 96 55 58 0 118 0 ); out1 = 54
# ( 3b 36 2a 3c 39 31 ) => ( 8 60 37 3a 0 76 0 ); out1 = 36
0011 1011 0011 0110 0010 1010 0011 1100 0011 1001 0011 0001 ;
#
# ( 87 76 49 77 51 34 ) => ( 17 125 83 80 0 157 0 ); out1 = 82
# ( 57 4c 31 4d 33 22 ) => ( 11 7d 53 50 0 9d 0 ); out1 = 52
0101 0111 0100 1100 0011 0001 0100 1101 0011 0011 0010 0010 ;
#
# ( 47 72 87 76 49 77 ) => ( -28 159 43 76 0 152 0 ); out1 = 42
# ( 2f 48 57 4c 31 4d ) => ( e4 9f 2b 4c 0 98 0 ); out1 = 2a
0010 1111 0100 1000 0101 0111 0100 1100 0011 0001 0100 1101 ;
#
# ( 5 15 40 55 44 65 ) => ( -21 55 1 19 0 74 0 ); out1 = 0
# ( 5 0f 28 37 2c 41 ) => ( eb 37 1 13 0 4a 0 ); out1 = 0
0000 0101 0000 1111 0010 1000 0011 0111 0010 1100 0100 0001 ;
#
# ( 72 87 76 49 77 51 ) => ( 26 163 68 91 0 140 0 ); out1 = 67
# ( 48 57 4c 31 4d 33 ) => ( 1a a3 44 5b 0 8c 0 ); out1 = 43
0100 1000 0101 0111 0100 1100 0011 0001 0100 1101 0011 0011 ;
#
# ( 18 48 75 46 70 82 ) => ( -12 123 14 52 0 98 0 ); out1 = 13
# ( 12 30 4b 2e 46 52 ) => ( f4 7b e 34 0 62 0 ); out1 = d
0001 0010 0011 0000 0100 1011 0010 1110 0100 0110 0101 0010 ;