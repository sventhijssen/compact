module s400(VDD,CK,CLR,FM,GRN1,GRN2,RED1,RED2,TEST,YLW1,YLW2);
input VDD,CK,FM,TEST,CLR;
output GRN2,YLW2,RED2,GRN1,YLW1,RED1;

  wire TESTL,TESTLVIINLATCHVCDAD,FML,FMLVIINLATCHVCDAD,OLATCH_Y2L,TCOMB_YA2,
    OLATCHVUC_6,Y1C,OLATCHVUC_5,R2C,OLATCH_R1L,TCOMB_RA1,OLATCH_G2L,TCOMB_GA2,
    OLATCH_G1L,TCOMB_GA1,OLATCH_FEL,TCOMB_FE_BF,C3_Q3,C3_Q3VD,C3_Q2,C3_Q2VD,
    C3_Q1,C3_Q1VD,C3_Q0,C3_Q0VD,UC_16,UC_16VD,UC_17,UC_17VD,UC_18,UC_18VD,
    UC_19,UC_19VD,UC_8,UC_8VD,UC_9,UC_9VD,UC_10,UC_10VD,UC_11,UC_11VD,
    TESTLVIINMUXVIIR1,TESTB,TESTLVIINMUX,TESTLVIINMUXVND1,TESTLVIINLATCHN,
    TESTLVIINLATCHVCDN,CLRB,FMLVIINMUXVIIR1,FMB,FMLVIINMUX,FMLVIINMUXVND1,
    FMLVIINLATCHN,FMLVIINLATCHVCDN,OUTBUFVBUFY2VIIR1,OUTBUFVBUFY1VIIR1,
    OLATCH_Y1L,OUTBUFVBUFR2VIIR1,OLATCH_R2L,OUTBUFVBUFR1VIIR1,
    OUTBUFVBUFG2VIIR1,OUTBUFVBUFG1VIIR1,II84,TCOMB_FE,FEN,CO2,C2_CO,UC_23,
    UC_24,UC_25,UC_26,C3VIINHN,UC_20,C2_QN2,UC_21,UC_22,C2VIINHN,CTST,C1VCO0,
    UC_15,UC_12,UC_13,UC_14,UC_11VZ,UC_11VUC_0,TCOMBVNQD,TCOMBVNQC,TCOMBVNQB,
    TCOMBVNQA,TCOMBVNFM,TCOMBVNFEL,TCOMBVNCLR,TESTBVIIR1,FMBVIIR1,CLRBVIIR1,
    CLKBVIIR1,Phi1H,TCOMB_GA2VAD4NF,TCOMB_GA2VAD3NF,TCOMB_GA2VAD2NF,
    TCOMB_GA2VAD1NF,TCOMB_GA1VAD1NF,TCOMBVNODE6,Y1CVAD2NF,TCOMB_YA1,Y1CVAD1NF,
    R2CVAD2NF,TCOMB_RA2,R2CVAD1NF,TESTLVIINMUXVOR2NF,TESTLVIINMUXVOR1NF,
    FMLVIINMUXVOR2NF,FMLVIINMUXVOR1NF,C3_Q3VZVOR1NF,C3VCO2,C3_Q2VZVOR1NF,
    C3VCO1,C3_Q1VZVOR1NF,C3VCO0,C3_Q0VZVOR1NF,UC_16VZVOR1NF,C2VCO2,
    UC_17VZVOR1NF,C2VCO1,UC_18VZVOR1NF,C2VCO0,UC_19VZVOR1NF,UC_8VZVOR1NF,
    C1VCO2,UC_9VZVOR1NF,C1VCO1,UC_10VZVOR1NF,TCOMBVNODE16VOR1NF,TCOMBVNODE18,
    TCOMB_RA2VOR3NF,TCOMB_RA2VOR2NF,TCOMB_RA2VOR1NF,TCOMBVNODE4VOR2NF,
    TCOMBVNODE4VOR1NF,TCOMBVNODE8VOR2NF,TCOMBVNODE8VOR1NF,TCOMB_RA1VOR2NF,
    TCOMB_RA1VOR1NF,C3_Q3VZ,C3_Q3VUC_0,C3_Q2VZ,C3_Q2VUC_0,C3_Q1VZ,C3_Q1VUC_0,
    C3_Q0VZ,C3_Q0VUC_0,UC_16VZ,UC_16VUC_0,UC_17VZ,UC_17VUC_0,UC_18VZ,
    UC_18VUC_0,UC_19VZ,UC_19VUC_0,UC_8VZ,UC_8VUC_0,UC_9VZ,UC_9VUC_0,UC_10VZ,
    UC_10VUC_0,TCOMBVNODE16,TCOMBVNODE19,TCOMBVNODE4,TCOMBVNODE12,TCOMBVNODE3,
    TCOMBVNODE14,TCOMBVNODE15,TCOMBVNODE8,C1_CO,UC_27,C3VCIIA,C2VCIIA,C1VCIIA;

  FD1 DFF_0(CK,TESTL,TESTLVIINLATCHVCDAD);
  FD1 DFF_1(CK,FML,FMLVIINLATCHVCDAD);
  FD1 DFF_2(CK,OLATCH_Y2L,TCOMB_YA2);
  FD1 DFF_3(CK,OLATCHVUC_6,Y1C);
  FD1 DFF_4(CK,OLATCHVUC_5,R2C);
  FD1 DFF_5(CK,OLATCH_R1L,TCOMB_RA1);
  FD1 DFF_6(CK,OLATCH_G2L,TCOMB_GA2);
  FD1 DFF_7(CK,OLATCH_G1L,TCOMB_GA1);
  FD1 DFF_8(CK,OLATCH_FEL,TCOMB_FE_BF);
  FD1 DFF_9(CK,C3_Q3,C3_Q3VD);
  FD1 DFF_10(CK,C3_Q2,C3_Q2VD);
  FD1 DFF_11(CK,C3_Q1,C3_Q1VD);
  FD1 DFF_12(CK,C3_Q0,C3_Q0VD);
  FD1 DFF_13(CK,UC_16,UC_16VD);
  FD1 DFF_14(CK,UC_17,UC_17VD);
  FD1 DFF_15(CK,UC_18,UC_18VD);
  FD1 DFF_16(CK,UC_19,UC_19VD);
  FD1 DFF_17(CK,UC_8,UC_8VD);
  FD1 DFF_18(CK,UC_9,UC_9VD);
  FD1 DFF_19(CK,UC_10,UC_10VD);
  FD1 DFF_20(CK,UC_11,UC_11VD);
  IV  NOT_0(TESTLVIINMUXVIIR1,TESTB);
  IV  NOT_1(TESTLVIINMUX,TESTLVIINMUXVND1);
  IV  NOT_2(TESTLVIINLATCHN,TESTL);
  IV  NOT_3(TESTLVIINLATCHVCDN,CLRB);
  IV  NOT_4(FMLVIINMUXVIIR1,FMB);
  IV  NOT_5(FMLVIINMUX,FMLVIINMUXVND1);
  IV  NOT_6(FMLVIINLATCHN,FML);
  IV  NOT_7(FMLVIINLATCHVCDN,CLRB);
  IV  NOT_8(YLW2,OUTBUFVBUFY2VIIR1);
  IV  NOT_9(OUTBUFVBUFY2VIIR1,OLATCH_Y2L);
  IV  NOT_10(YLW1,OUTBUFVBUFY1VIIR1);
  IV  NOT_11(OUTBUFVBUFY1VIIR1,OLATCH_Y1L);
  IV  NOT_12(RED2,OUTBUFVBUFR2VIIR1);
  IV  NOT_13(OUTBUFVBUFR2VIIR1,OLATCH_R2L);
  IV  NOT_14(RED1,OUTBUFVBUFR1VIIR1);
  IV  NOT_15(OUTBUFVBUFR1VIIR1,OLATCH_R1L);
  IV  NOT_16(GRN2,OUTBUFVBUFG2VIIR1);
  IV  NOT_17(OUTBUFVBUFG2VIIR1,OLATCH_G2L);
  IV  NOT_18(GRN1,OUTBUFVBUFG1VIIR1);
  IV  NOT_19(OUTBUFVBUFG1VIIR1,OLATCH_G1L);
  IV  NOT_20(OLATCH_Y1L,OLATCHVUC_6);
  IV  NOT_21(OLATCH_R2L,OLATCHVUC_5);
  IV  NOT_22(II84,TCOMB_FE);
  IV  NOT_23(TCOMB_FE_BF,II84);
  IV  NOT_24(FEN,TCOMB_FE);
  IV  NOT_25(CO2,C2_CO);
  IV  NOT_26(UC_23,C3_Q3);
  IV  NOT_27(UC_24,C3_Q2);
  IV  NOT_28(UC_25,C3_Q1);
  IV  NOT_29(UC_26,C3_Q0);
  IV  NOT_30(C3VIINHN,CO2);
  IV  NOT_31(UC_20,UC_16);
  IV  NOT_32(C2_QN2,UC_17);
  IV  NOT_33(UC_21,UC_18);
  IV  NOT_34(UC_22,UC_19);
  IV  NOT_35(C2VIINHN,CTST);
  IV  NOT_36(C1VCO0,UC_15);
  IV  NOT_37(UC_12,UC_8);
  IV  NOT_38(UC_13,UC_9);
  IV  NOT_39(UC_14,UC_10);
  IV  NOT_40(UC_11VZ,UC_11VUC_0);
  IV  NOT_41(UC_11VUC_0,UC_11);
  IV  NOT_42(UC_15,UC_11);
  IV  NOT_43(TCOMBVNQD,C3_Q3);
  IV  NOT_44(TCOMBVNQC,C3_Q2);
  IV  NOT_45(TCOMBVNQB,C3_Q1);
  IV  NOT_46(TCOMBVNQA,C3_Q0);
  IV  NOT_47(TCOMBVNFM,FML);
  IV  NOT_48(TCOMBVNFEL,OLATCH_FEL);
  IV  NOT_49(TCOMBVNCLR,CLRB);
  IV  NOT_50(TESTB,TESTBVIIR1);
  IV  NOT_51(TESTBVIIR1,TEST);
  IV  NOT_52(FMB,FMBVIIR1);
  IV  NOT_53(FMBVIIR1,FM);
  IV  NOT_54(CLRB,CLRBVIIR1);
  IV  NOT_55(CLRBVIIR1,CLR);
  IV  NOT_57(CLKBVIIR1,Phi1H);
  AN2 AND2_0(TESTLVIINLATCHVCDAD,TESTLVIINLATCHVCDN,TESTLVIINMUX);
  AN2 AND2_1(FMLVIINLATCHVCDAD,FMLVIINLATCHVCDN,FMLVIINMUX);
  AN2 AND2_2(TCOMB_GA2VAD4NF,OLATCH_FEL,TCOMBVNCLR);
  AN2 AND2_3(TCOMB_GA2VAD3NF,C3_Q2,TCOMBVNCLR);
  AN3 AND3_0(TCOMB_GA2VAD2NF,C3_Q0,C3_Q1,TCOMBVNCLR);
  AN3 AND3_1(TCOMB_GA2VAD1NF,TCOMBVNQA,C3_Q3,TCOMBVNCLR);
  AN2 AND2_4(TCOMB_GA1VAD1NF,TCOMBVNODE6,OLATCH_FEL);
  AN2 AND2_5(Y1CVAD2NF,FEN,TCOMB_YA1);
  AN3 AND3_2(Y1CVAD1NF,TCOMB_FE,TCOMB_YA1,C2_QN2);
  AN2 AND2_6(R2CVAD2NF,FEN,TCOMB_RA2);
  AN3 AND3_3(R2CVAD1NF,TCOMB_FE,TCOMB_RA2,C2_QN2);
  OR2 OR2_0(TESTLVIINMUXVOR2NF,TESTLVIINMUXVIIR1,TESTLVIINLATCHN);
  OR2 OR2_1(TESTLVIINMUXVOR1NF,TESTB,TESTL);
  OR2 OR2_2(FMLVIINMUXVOR2NF,FMLVIINMUXVIIR1,FMLVIINLATCHN);
  OR2 OR2_3(FMLVIINMUXVOR1NF,FMB,FML);
  OR2 OR2_4(C3_Q3VZVOR1NF,C3VCO2,C3_Q3);
  OR2 OR2_5(C3_Q2VZVOR1NF,C3VCO1,C3_Q2);
  OR2 OR2_6(C3_Q1VZVOR1NF,C3VCO0,C3_Q1);
  OR2 OR2_7(C3_Q0VZVOR1NF,C3VIINHN,C3_Q0);
  OR2 OR2_8(UC_16VZVOR1NF,C2VCO2,UC_16);
  OR2 OR2_9(UC_17VZVOR1NF,C2VCO1,UC_17);
  OR2 OR2_10(UC_18VZVOR1NF,C2VCO0,UC_18);
  OR2 OR2_11(UC_19VZVOR1NF,C2VIINHN,UC_19);
  OR2 OR2_12(UC_8VZVOR1NF,C1VCO2,UC_8);
  OR2 OR2_13(UC_9VZVOR1NF,C1VCO1,UC_9);
  OR2 OR2_14(UC_10VZVOR1NF,C1VCO0,UC_10);
  OR4 OR4_0(TCOMBVNODE16VOR1NF,TCOMBVNODE18,FML,C3_Q3,TCOMBVNQC);
  OR2 OR2_15(TCOMB_RA2VOR3NF,TCOMBVNQC,CLRB);
  OR2 OR2_16(TCOMB_RA2VOR2NF,TCOMBVNFEL,CLRB);
  OR4 OR4_1(TCOMB_RA2VOR1NF,C3_Q0,C3_Q1,TCOMBVNQD,CLRB);
  OR3 OR3_0(TCOMBVNODE4VOR2NF,C3_Q2,TCOMBVNQD,CLRB);
  OR4 OR4_2(TCOMBVNODE4VOR1NF,TCOMBVNQC,C3_Q3,TCOMBVNFM,CLRB);
  OR2 OR2_17(TCOMBVNODE8VOR2NF,TCOMBVNQD,TCOMBVNFM);
  OR3 OR3_1(TCOMBVNODE8VOR1NF,C3_Q0,C3_Q1,TCOMBVNFM);
  OR3 OR3_2(TCOMB_RA1VOR2NF,C3_Q2,C3_Q3,OLATCH_FEL);
  OR4 OR4_3(TCOMB_RA1VOR1NF,TCOMBVNQA,C3_Q1,C3_Q2,OLATCH_FEL);
  ND2 NAND2_0(TESTLVIINMUXVND1,TESTLVIINMUXVOR2NF,TESTLVIINMUXVOR1NF);
  ND2 NAND2_1(FMLVIINMUXVND1,FMLVIINMUXVOR2NF,FMLVIINMUXVOR1NF);
  ND2 NAND2_2(C3_Q3VZ,C3_Q3VZVOR1NF,C3_Q3VUC_0);
  ND2 NAND2_3(C3_Q3VUC_0,C3VCO2,C3_Q3);
  ND2 NAND2_4(C3_Q2VZ,C3_Q2VZVOR1NF,C3_Q2VUC_0);
  ND2 NAND2_5(C3_Q2VUC_0,C3VCO1,C3_Q2);
  ND2 NAND2_6(C3_Q1VZ,C3_Q1VZVOR1NF,C3_Q1VUC_0);
  ND2 NAND2_7(C3_Q1VUC_0,C3VCO0,C3_Q1);
  ND2 NAND2_8(C3_Q0VZ,C3_Q0VZVOR1NF,C3_Q0VUC_0);
  ND2 NAND2_9(C3_Q0VUC_0,C3VIINHN,C3_Q0);
  ND2 NAND2_10(UC_16VZ,UC_16VZVOR1NF,UC_16VUC_0);
  ND2 NAND2_11(UC_16VUC_0,C2VCO2,UC_16);
  ND2 NAND2_12(UC_17VZ,UC_17VZVOR1NF,UC_17VUC_0);
  ND2 NAND2_13(UC_17VUC_0,C2VCO1,UC_17);
  ND2 NAND2_14(UC_18VZ,UC_18VZVOR1NF,UC_18VUC_0);
  ND2 NAND2_15(UC_18VUC_0,C2VCO0,UC_18);
  ND2 NAND2_16(UC_19VZ,UC_19VZVOR1NF,UC_19VUC_0);
  ND2 NAND2_17(UC_19VUC_0,C2VIINHN,UC_19);
  ND2 NAND2_18(UC_8VZ,UC_8VZVOR1NF,UC_8VUC_0);
  ND2 NAND2_19(UC_8VUC_0,C1VCO2,UC_8);
  ND2 NAND2_20(UC_9VZ,UC_9VZVOR1NF,UC_9VUC_0);
  ND2 NAND2_21(UC_9VUC_0,C1VCO1,UC_9);
  ND2 NAND2_22(UC_10VZ,UC_10VZVOR1NF,UC_10VUC_0);
  ND2 NAND2_23(UC_10VUC_0,C1VCO0,UC_10);
  ND2 NAND2_24(TCOMBVNODE16,TCOMBVNODE19,TCOMBVNODE16VOR1NF);
  ND2 NAND2_25(TCOMBVNODE18,TCOMBVNQB,C3_Q0);
  ND3 NAND3_0(TCOMB_RA2,TCOMB_RA2VOR3NF,TCOMB_RA2VOR2NF,TCOMB_RA2VOR1NF);
  ND2 NAND2_26(TCOMBVNODE4,TCOMBVNODE4VOR2NF,TCOMBVNODE4VOR1NF);
  ND4 NAND4_0(TCOMBVNODE12,TCOMBVNCLR,TCOMBVNFEL,TCOMBVNQC,C3_Q1);
  ND3 NAND3_1(TCOMBVNODE3,TCOMBVNODE4,TCOMBVNQB,TCOMBVNQA);
  ND2 NAND2_27(TCOMB_YA1,TCOMBVNODE16,TCOMBVNODE3);
  ND2 NAND2_28(TCOMBVNODE14,TCOMBVNODE15,TCOMBVNQA);
  ND2 NAND2_29(TCOMB_FE,TCOMBVNODE16,TCOMBVNODE14);
  nand NAND4_1(TCOMBVNODE8,TCOMBVNCLR,C3_Q2,TCOMBVNODE8VOR2NF,
    TCOMBVNODE8VOR1NF);
  ND3 NAND3_2(TCOMB_RA1,TCOMBVNCLR,TCOMB_RA1VOR2NF,TCOMB_RA1VOR1NF);
  ND4 NAND4_2(TCOMBVNODE6,TCOMBVNFM,TCOMBVNQD,TCOMBVNQB,C3_Q0);
  NR2 NOR2_0(CTST,C1_CO,TESTL);
  NR4 NOR4_0(C3VCO2,CO2,UC_24,UC_25,UC_26);
  NR3 NOR3_0(C3VCO1,CO2,UC_25,UC_26);
  NR3 NOR3_1(UC_27,C3VCIIA,CO2,UC_23);
  NR3 NOR3_2(C3VCIIA,C3_Q2,C3_Q1,C3_Q0);
  NR2 NOR2_1(C3VCO0,CO2,UC_26);
  NR3 NOR3_3(C3_Q3VD,CLRB,C3_Q3VZ,UC_27);
  NR3 NOR3_4(C3_Q2VD,CLRB,C3_Q2VZ,UC_27);
  NR3 NOR3_5(C3_Q1VD,CLRB,C3_Q1VZ,UC_27);
  NR3 NOR3_6(C3_Q0VD,CLRB,C3_Q0VZ,UC_27);
  NR4 NOR4_1(C2VCO2,CTST,C2_QN2,UC_21,UC_22);
  NR3 NOR3_7(C2VCO1,CTST,UC_21,UC_22);
  NR3 NOR3_8(C2_CO,C2VCIIA,CTST,UC_20);
  NR3 NOR3_9(C2VCIIA,UC_17,UC_18,UC_19);
  NR2 NOR2_2(C2VCO0,CTST,UC_22);
  NR3 NOR3_10(UC_16VD,CLRB,UC_16VZ,C2_CO);
  NR3 NOR3_11(UC_17VD,CLRB,UC_17VZ,C2_CO);
  NR3 NOR3_12(UC_18VD,CLRB,UC_18VZ,C2_CO);
  NR3 NOR3_13(UC_19VD,CLRB,UC_19VZ,C2_CO);
  NR3 NOR3_14(C1VCO2,UC_13,UC_14,UC_15);
  NR2 NOR2_3(C1VCO1,UC_14,UC_15);
  NR2 NOR2_4(C1_CO,C1VCIIA,UC_12);
  NR3 NOR3_15(C1VCIIA,UC_9,UC_10,UC_11);
  NR3 NOR3_16(UC_8VD,CLRB,UC_8VZ,C1_CO);
  NR3 NOR3_17(UC_9VD,CLRB,UC_9VZ,C1_CO);
  NR3 NOR3_18(UC_10VD,CLRB,UC_10VZ,C1_CO);
  NR3 NOR3_19(UC_11VD,CLRB,UC_11VZ,C1_CO);
  NR2 NOR2_5(TCOMBVNODE19,CLRB,TCOMBVNFEL);
  nor NOR4_2(TCOMB_GA2,TCOMB_GA2VAD4NF,TCOMB_GA2VAD3NF,TCOMB_GA2VAD2NF,
    TCOMB_GA2VAD1NF);
  NR4 NOR4_3(TCOMBVNODE15,CLRB,TCOMBVNFM,TCOMBVNQC,C3_Q1);
  NR2 NOR2_6(TCOMB_YA2,TCOMBVNODE12,TCOMBVNQA);
  NR2 NOR2_7(TCOMB_GA1,TCOMBVNODE8,TCOMB_GA1VAD1NF);
  NR2 NOR2_8(Y1C,Y1CVAD2NF,Y1CVAD1NF);
  NR2 NOR2_9(R2C,R2CVAD2NF,R2CVAD1NF);

endmodule
