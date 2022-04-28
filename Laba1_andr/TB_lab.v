`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2022 11:02:14
// Design Name: 
// Module Name: TB_lab
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


module TB_lab();
reg clk = 0;
reg [4:0] r_in=0;
wire w_out1;
wire w_out2;
wire w_out3;

var1 out1(
.clk (clk),
.in (r_in),
.out (w_out1)
);

var2 out2(
.clk (clk),
.in (r_in),
.out (w_out2)
);

var3 out3(
.clk (clk),
.in (r_in),
.out (w_out3)
);

always #10 clk = !clk;


always @(posedge clk)
begin
r_in <= r_in + 10'h01;
end

endmodule
