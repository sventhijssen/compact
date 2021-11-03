// IWLS benchmark module "s208.1.bench" printed on Wed May 29 21:27:57 2002
module \s208.1.bench (\P.0 , \C.8 , \C.7 , \C.6 , \C.5 , \C.4 , \C.3 , \C.2 , \C.1 , \C.0 , Z);
input
  \P.0 ,
  \C.0 ,
  \C.1 ,
  \C.2 ,
  \C.3 ,
  \C.4 ,
  \C.5 ,
  \C.6 ,
  \C.7 ,
  \C.8 ;
output
  Z;
reg
  \X.1 ,
  \X.2 ,
  \X.3 ,
  \X.4 ,
  \X.5 ,
  \X.6 ,
  \X.7 ,
  \X.8 ;
wire
  I110,
  I111,
  I112,
  I113,
  \I188.1 ,
  \I205.2 ,
  \I270.2 ,
  \I270.3 ,
  I159,
  \I291.1 ,
  \I291.2 ,
  I162,
  \[10] ,
  I163,
  I165,
  I314,
  \[11] ,
  \[12] ,
  \I207.2 ,
  \[13] ,
  \[14] ,
  I12,
  I13,
  I14,
  I15,
  \I95.1 ,
  \[15] ,
  \I105.3 ,
  \I105.4 ,
  \I182.3 ,
  \I182.4 ,
  \[16] ,
  \I170.1 ,
  \I315.1 ,
  \I315.2 ,
  \I88.3 ,
  \I88.4 ,
  \I209.1 ,
  \I2.1 ,
  \P.1 ,
  \P.2 ,
  \P.3 ,
  \P.4 ,
  \P.5 ,
  \P.6 ,
  \I191.1 ,
  \P.7 ,
  \P.8 ,
  \I7.3 ,
  \I7.4 ,
  I62,
  I64,
  I66,
  I69,
  \I295.1 ,
  \I295.2 ,
  I222,
  I224,
  \I206.2 ,
  \[8] ,
  \I73.3 ,
  \I73.4 ,
  \[9] ,
  I249,
  I251,
  \I269.1 ,
  \I269.2 ,
  \I70.1 ,
  \I208.2 ,
  \I319.1 ,
  \I319.2 ,
  \I1.2 ,
  I290,
  \I167.1 ;
assign
  I110 = ~I159 | ~\I167.1 ,
  I111 = I162 | ~\I170.1 ,
  I112 = ~\I105.4  & ~\I105.3 ,
  I113 = \I182.4  | \I182.3 ,
  \I188.1  = I163 | (~\X.6  | ~\X.7 ),
  \I205.2  = \X.5  & \P.0 ,
  \I270.2  = \I269.2  | \I269.1 ,
  \I270.3  = \C.8  & \P.8 ,
  I159 = ~\X.8  | ~\I188.1 ,
  \I291.1  = ~\P.3  | ~\C.3 ,
  \I291.2  = ~\P.2  | ~\C.2 ,
  I162 = ~\I191.1  & \X.7 ,
  \[10]  = I13,
  I163 = ~\I1.2  | ~\X.5 ,
  I165 = I163 | ~\X.6 ,
  Z = \[8] ,
  I314 = ~\I319.2  & ~\I319.1 ,
  \[11]  = I14,
  \[12]  = I15,
  \I207.2  = ~I249 & \X.7 ,
  \[13]  = I110,
  \[14]  = I111,
  I12 = ~I62 | ~\I70.1 ,
  I13 = \I73.4  | \I73.3 ,
  I14 = ~\I7.4  & ~\I7.3 ,
  I15 = \I88.4  | \I88.3 ,
  \I95.1  = I64 | (~\X.3  | ~\P.0 ),
  \[15]  = I112,
  \I105.3  = I163 & ~\X.6 ,
  \I105.4  = ~I163 & \X.6 ,
  \I182.3  = ~\I1.2  & \X.5 ,
  \I182.4  = \I1.2  & ~\X.5 ,
  \[16]  = I113,
  \I170.1  = \X.7  | I165,
  \I315.1  = ~\P.7  | ~\C.7 ,
  \I315.2  = ~\P.6  | ~\C.6 ,
  \I88.3  = \X.1  & ~\P.0 ,
  \I88.4  = ~\X.1  & \P.0 ,
  \I209.1  = ~\X.1  & (~\X.3  & (~\X.2  & ~\X.4 )),
  \I2.1  = ~I64 & (\X.3  & \X.4 ),
  \P.1  = \X.1  & \P.0 ,
  \P.2  = ~I224 & \X.2 ,
  \P.3  = ~I222 & \X.3 ,
  \P.4  = ~I222 & (~\X.3  & \X.4 ),
  \P.5  = \I205.2  & \I209.1 ,
  \P.6  = \I206.2  & \I209.1 ,
  \I191.1  = ~I163 & \X.6 ,
  \P.7  = \I207.2  & \I209.1 ,
  \P.8  = \I208.2  & \I209.1 ,
  \I7.3  = I66 & ~\X.2 ,
  \I7.4  = ~I66 & \X.2 ,
  I62 = ~\X.4  | ~\I95.1 ,
  I64 = ~\X.2  | ~\X.1 ,
  I66 = ~\P.0  | ~\X.1 ,
  I69 = ~I64 & \P.0 ,
  \I295.1  = \C.1  & \P.1 ,
  \I295.2  = \C.0  & \P.0 ,
  I222 = I224 | \X.2 ,
  I224 = \X.1  | ~\P.0 ,
  \I206.2  = ~I251 & \X.6 ,
  \[8]  = \I270.3  | \I270.2 ,
  \I73.3  = I69 & ~\X.3 ,
  \I73.4  = ~I69 & \X.3 ,
  \[9]  = I12,
  I249 = I251 | \X.6 ,
  I251 = \X.5  | ~\P.0 ,
  \I269.1  = ~I290 | (~\I291.2  | ~\I291.1 ),
  \I269.2  = ~I314 | (~\I315.2  | ~\I315.1 ),
  \I70.1  = ~I69 | (~\X.3  | \X.4 ),
  \I208.2  = ~I249 & (~\X.7  & \X.8 ),
  \I319.1  = \C.5  & \P.5 ,
  \I319.2  = \C.4  & \P.4 ,
  \I1.2  = \P.0  & \I2.1 ,
  I290 = ~\I295.2  & ~\I295.1 ,
  \I167.1  = I165 | (~\X.7  | \X.8 );
always begin
  \X.1  = \[12] ;
  \X.2  = \[11] ;
  \X.3  = \[10] ;
  \X.4  = \[9] ;
  \X.5  = \[16] ;
  \X.6  = \[15] ;
  \X.7  = \[14] ;
  \X.8  = \[13] ;
end
initial begin
  \X.1  = 0;
  \X.2  = 0;
  \X.3  = 0;
  \X.4  = 0;
  \X.5  = 0;
  \X.6  = 0;
  \X.7  = 0;
  \X.8  = 0;
end
endmodule
