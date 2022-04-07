module coder(
    input in0,
    input in1,
    input in2,
    input in3,
    output out0,
    output out1
    );
    
    reg [1:0] outpt;
    reg [3:0] inpt;
    //always @*
    //assign outpt = (inpt == 0) ? 2'b00 : ( (inpt == 1) ? 2'b01 : ((inpt == 2) ? 2'b10 : 0));
    //assign out1=outpt;
    //assign out2=outpt[1];
   
    //endmodule
    
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
    
    //assign out1 = in3 + in2;
    //assign out0 = in3 + ((~in2)&in1);
    endmodule
