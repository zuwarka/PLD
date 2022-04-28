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


module var3(
    input clk,
    input [4:0] in,
    output out
    );
        wire o1,o2,o3,o4,o5,final;
    decoder dc1(
        .in0(~in[1]),
        .in1(~in[0]),
        .out0(),
        .out1(),
        .out2(),
        .out3(o1)
    ), dc2(
        .in0(~in[2]),
        .in1(~o1),
        .out0(),
        .out1(),
        .out2(),
        .out3(o2)
    ),  dc3(
        .in0(in[4]),
        .in1(in[3]),
        .out0(o3),
        .out1(),
        .out2(),
        .out3()
     ), dc4(
        .in0(~o2),
        .in1(~o3),
        .out0(),
        .out1(),
        .out2(),
        .out3(o4)
     ), dc5(
        .in0(o2),
        .in1(o3),
        .out0(),
        .out1(),
        .out2(),
        .out3(o5)
     ),  dc6(
        .in0(o4),
        .in1(o5),
        .out0(final),
        .out1(),
        .out2(),
        .out3()
     );
    assign out = ~final;
endmodule
