`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2022 20:25:42
// Design Name: 
// Module Name: lab13
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


module lab13(
    input clk,
    input [4:0] in,
    output out
    );
    
    wire o1,o2,o3,o4,o5,o6,final;
    decoder dc1(
    .in0(in[4]),
    .in1(~in[3]),
    .out0(),
    .out1(),
    .out2(),
    .out3(o1)
    ), dc2(
    .in0(~in[1]),
    .in1(~in[0]),
    .out0(o2),
    .out1(),
    .out2(),
    .out3()
    ), dc3(
    .in0(o1),
    .in1(in[2]),
    .out0(),
    .out1(),
    .out2(),
    .out3(o3)
    ), dc4(
    .in0(o3),
    .in1(~o2),
    .out0(final),
    .out1(),
    .out2(),
    .out3()
    );
    
    assign out = ~final;

endmodule
