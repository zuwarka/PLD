`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2022 20:26:55
// Design Name: 
// Module Name: TB_lab1
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

module TB_lab1();
reg clk = 0;
reg [4:0] r_in=0;
wire w_out;
wire w_out1;
wire w_out2;

lab11 out(
.clk (clk),
.in (r_in),
.out (w_out)
);

lab12 out1(
.clk (clk),
.in (r_in),
.out (w_out1)
);

lab13 out2(
.clk (clk),
.in (r_in),
.out (w_out2)
);

always #5 clk = !clk;


always @(posedge clk)
begin
r_in <= r_in + 5'h01;
end
endmodule

