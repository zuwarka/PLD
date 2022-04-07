module laba11new(
    clk, 
    in, 
    out
    );
    
    input clk;
    input [4:0] in;
    reg x, y, z, k, l;
    output reg out;
    
    always @(posedge clk)
    begin
     x <= in[4];
     y <= in[3];
     z <= in[2];
     k <= in[1];
     l <= in[0];
     out <= (~x & (~y | z)) & (~k ^ ~l);
     end

endmodule
