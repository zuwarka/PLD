`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2022 20:25:42
// Design Name: 
// Module Name: lab12
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab12(
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
 out <= (x & ~y & z) | (~k | ~l);
 end

endmodule
