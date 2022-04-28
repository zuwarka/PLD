`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2022 09:48:53
// Design Name: 
// Module Name: decoder
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


module decoder(
    input in0,
    input in1,
    output out0,
    output out1,
    output out2,
    output out3
    );
    
    reg [3:0] outpt;
    reg [1:0] inpt;
   
    always @*
    begin
    inpt[0]<=in0;
    inpt[1]<=in1;
    casex (inpt)
    2'b00:outpt = 4'b0001;
    2'b01:outpt = 4'b0010;
    2'b10:outpt = 4'b0100;
    2'b11:outpt = 4'b1000;
    default:outpt = 0;
    endcase
    end
    assign out0=outpt[0];
    assign out1=outpt[1];
    assign out2=outpt[2];
    assign out3=outpt[3];
    
    endmodule
