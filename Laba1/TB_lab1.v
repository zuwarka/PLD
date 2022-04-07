module TB_lab1();
reg clk = 0;
reg [4:0] r_in=0;
wire w_out;
wire w_out1;
wire w_out2;

laba1 out(
.clk (clk),
.in (r_in),
.out (w_out)
);

laba11new out1(
.clk (clk),
.in (r_in),
.out (w_out1)
);

laba13 out2(
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
