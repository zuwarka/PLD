module laba13(
    input clk,
    input [4:0] in,
    output out
    );
    
    wire o1,o2,o3,o4,o5,final;
    coder cd1(
    .in0(1),
    .in1(~in[3]),
    .in2(0),
    .in3(in[2]),
    .out0(o1),
    .out1()
    ), cd2(
    .in0(1),
    .in1(in[1]),
    .in2(in[0]),
    .in3(0),
    .out0(o2),
    .out1()
    ), cd3(
    .in0(1),
    .in1(in[0]),
    .in2(in[1]),
    .in3(0),
    .out0(o3),
    .out1()
    ), cd4(
    .in0(1),
    .in1(o1),
    .in2(in[4]),
    .in3(0),
    .out0(o4),
    .out1()
    ), cd5(
    .in0(1),
    .in1(o2),
    .in2(0),
    .in3(o3),
    .out0(o5),
    .out1()
    ), cd6(
    .in0(1),
    .in1(o4),
    .in2(~o5),
    .in3(0),
    .out0(final),
    .out1()
    );
    
    assign out = final;

endmodule
