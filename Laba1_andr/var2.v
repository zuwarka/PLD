`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2022 11:00:55
// Design Name: 
// Module Name: var3
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


module var2(
    input clk,
    input [4:0] in,
    output reg out
    );
    
    reg x, y, z, k, l;
    
    always @(posedge clk)
    begin
    x <= in[4];
    y <= in[3];
    z <= in[2];
    k <= in[1];
    l <= in[0];
    out <= (x | y) ^ (~z & ~(~k & ~l));
    end

endmodule