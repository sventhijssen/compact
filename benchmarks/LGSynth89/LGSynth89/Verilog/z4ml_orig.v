// IWLS benchmark module "z4ml" printed on Wed May 29 16:25:53 2002
module z4ml(\1 , \2 , \3 , \4 , \5 , \6 , \7 , \24 , \25 , \26 , \27 );
input
  \1 ,
  \2 ,
  \3 ,
  \4 ,
  \5 ,
  \6 ,
  \7 ;
output
  \24 ,
  \25 ,
  \26 ,
  \27 ;
wire
  \[2] ,
  \[3] ,
  \[4] ,
  \[1] ;
assign
  \[2]  = (~\7  & (~\6  & (~\5  & (~\4  & \2 )))) | ((~\7  & (~\6  & (~\5  & (\2  & ~\1 )))) | ((~\7  & (~\6  & (\5  & (~\4  & ~\2 )))) | ((~\7  & (~\6  & (\5  & (~\2  & ~\1 )))) | ((~\7  & (~\5  & (~\4  & (~\3  & \2 )))) | ((~\7  & (~\5  & (~\3  & (\2  & ~\1 )))) | ((~\7  & (\5  & (~\4  & (~\3  & ~\2 )))) | ((~\7  & (\5  & (~\3  & (~\2  & ~\1 )))) | ((\7  & (\6  & (~\5  & (\4  & ~\2 )))) | ((\7  & (\6  & (~\5  & (~\2  & \1 )))) | ((\7  & (\6  & (\5  & (\4  & \2 )))) | ((\7  & (\6  & (\5  & (\2  & \1 )))) | ((\7  & (~\5  & (\4  & (\3  & ~\2 )))) | ((\7  & (~\5  & (\3  & (~\2  & \1 )))) | ((\7  & (\5  & (\4  & (\3  & \2 )))) | ((\7  & (\5  & (\3  & (\2  & \1 )))) | ((~\6  & (~\5  & (~\4  & (\2  & ~\1 )))) | ((~\6  & (\5  & (~\4  & (~\2  & ~\1 )))) | ((\6  & (~\5  & (\4  & (~\2  & \1 )))) | ((\6  & (\5  & (\4  & (\2  & \1 )))) | ((~\5  & (~\4  & (~\3  & (\2  & ~\1 )))) | ((~\5  & (\4  & (\3  & (~\2  & \1 )))) | ((\5  & (~\4  & (~\3  & (~\2  & ~\1 )))) | ((\5  & (\4  & (\3  & (\2  & \1 )))) | ((~\6  & (~\5  & (~\3  & \2 ))) | ((~\6  & (\5  & (~\3  & ~\2 ))) | ((\6  & (~\5  & (\3  & ~\2 ))) | (\6  & (\5  & (\3  & \2 ))))))))))))))))))))))))))))),
  \[3]  = (~\7  & (~\6  & (~\4  & \3 ))) | ((~\7  & (~\6  & (\3  & ~\1 ))) | ((~\7  & (\6  & (~\4  & ~\3 ))) | ((~\7  & (\6  & (~\3  & ~\1 ))) | ((\7  & (~\6  & (\4  & ~\3 ))) | ((\7  & (~\6  & (~\3  & \1 ))) | ((\7  & (\6  & (\4  & \3 ))) | ((\7  & (\6  & (\3  & \1 ))) | ((~\6  & (~\4  & (\3  & ~\1 ))) | ((~\6  & (\4  & (~\3  & \1 ))) | ((\6  & (~\4  & (~\3  & ~\1 ))) | (\6  & (\4  & (\3  & \1 ))))))))))))),
  \[4]  = (~\7  & (~\4  & \1 )) | ((~\7  & (\4  & ~\1 )) | ((\7  & (~\4  & ~\1 )) | (\7  & (\4  & \1 )))),
  \24  = \[1] ,
  \25  = \[2] ,
  \26  = \[3] ,
  \27  = \[4] ,
  \[1]  = (\7  & (\6  & (\5  & \4 ))) | ((\7  & (\6  & (\5  & \1 ))) | ((\7  & (\6  & (\4  & \2 ))) | ((\7  & (\6  & (\2  & \1 ))) | ((\7  & (\5  & (\4  & \3 ))) | ((\7  & (\5  & (\3  & \1 ))) | ((\7  & (\4  & (\3  & \2 ))) | ((\7  & (\3  & (\2  & \1 ))) | ((\6  & (\5  & (\4  & \1 ))) | ((\6  & (\4  & (\2  & \1 ))) | ((\5  & (\4  & (\3  & \1 ))) | ((\4  & (\3  & (\2  & \1 ))) | ((\6  & (\5  & \3 )) | ((\6  & (\3  & \2 )) | (\5  & \2 ))))))))))))));
endmodule

