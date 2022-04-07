module laba1(
    input clk,
    input [4:0] in,
    input out
    );
    
   assign out = (~in[4] & (~in[3] | in[2])) & (~in[1] ^ ~in[0]);
endmodule
