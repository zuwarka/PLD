`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2022 09:48:53
// Design Name: 
// Module Name: encoder
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


module encoder(
    input in0,
    input in1,
    input in2,
    input in3,
    output out0,
    output out1
    );
    
    reg [1:0] outpt;
       reg [3:0] inpt;
        always @*
        begin
        inpt[0]<=in0;
        inpt[1]<=in1;
        inpt[2]<=in2;
        inpt[3]<=in3;
        casex (inpt)
        4'b0001:outpt = 2'b00;
        4'b001x:outpt = 2'b01;
        4'b01xx:outpt = 2'b10;
        4'b1xxx:outpt = 2'b11;
        default:outpt = 0;
        endcase
        end
        assign out0=outpt[0];
        assign out1=outpt[1];

endmodule
