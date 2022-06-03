module var_outprint(
	 input clk_p,
input clk_n,
output LCD_RW,
output LCD_EN,
output LCD_RS,
output [3:0] LCD_DATA //LCD Data Bus 8

);

wire clk_mid;
wire clk;

IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) 
    IBUFDS_inst (.O(clk_mid), .I(clk_p), .IB(clk_n));

BUFG BUFG_inst (.O(clk), .I(clk_mid));

 

 reg clk_4Mhz = 1'd0;
 reg [5:0] clk_4Mhz_counter = 6'd0;



   always @(posedge clk) begin
   clk_4Mhz_counter <= clk_4Mhz_counter + 1'd1;
   if (&clk_4Mhz_counter) clk_4Mhz = ~clk_4Mhz;
   //if (clk_4Mhz_counter == 6'd3) clk_4Mhz = ~clk_4Mhz;
   end
  
   lcd lcd_display(
   .clk_4Mhz(clk_4Mhz),
   .LCD_DATA(LCD_DATA),
   .LCD_RW(LCD_RW),
   .LCD_EN(LCD_EN),
   .LCD_RS(LCD_RS)
   );

Endmodule
