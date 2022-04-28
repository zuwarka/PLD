`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2022 09:48:53
// Design Name: 
// Module Name: var1
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


module var1(
    input clk,
    input [4:0] in,
    output out
    );
    
    assign out = (in[4] || in[3]) && in[2] && (!in[1] || in[0]);
endmodule
