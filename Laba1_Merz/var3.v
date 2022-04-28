`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2022 09:48:53
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


module var3(
    input clk,
    input [4:0] in,
    inout out
    );
    
    wire o1,o2,o3,final;
    encoder ed1(
        .in0(1),
        .in1(in[4]),
        .in2(0),
        .in3(in[3]),
        .out0(o1),
        .out1()
    ), ed2(
        .in0(1),
        .in1(!in[1]),
        .in2(0),
        .in3(in[0]),
        .out0(o2),
        .out1()
    );
    decoder dc1(
        .in0(o1),
        .in1(in[2]),
        .out0(),
        .out1(),
        .out2(),
        .out3(o3)
    ), dc2(
        .in0(o3),
        .in1(o2),
        .out0(),
        .out1(),
        .out2(),
        .out3(final)
    );

    assign out = final;
endmodule
