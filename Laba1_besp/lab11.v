`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2022 20:25:42
// Design Name: 
// Module Name: lab11
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


module lab11(
    input clk,
    input [4:0] in,
    output out
    );
    
    assign out = in[4] & ~in[3] & in[2] | (~in[1] | ~in[0]);
endmodule
