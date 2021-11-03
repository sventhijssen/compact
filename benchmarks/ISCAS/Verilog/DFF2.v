module DFF (Q, D, CK);
input   D, CK;
output  Q;
reg     Q;

// Basic Verilog statement for a Flip Flop
always @(posedge CK) Q <= D;
endmodule

