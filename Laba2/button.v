module button(
    input clk,
    input gpio_sw_c,
    output gpio_sw_c_on
    );
    
     reg [19:0] timer = 20'b0;
     reg buffer = 1'b0;//признак нажатия кнопки
        
     always @(posedge clk) begin
          buffer <= 1'b0;
          if (gpio_sw_c) begin //сигнал с кнопки
              if (timer <= 20'd1000000)
                  timer <= timer + 1'b1;
    //антидребезг
          end
          else begin
              if (timer > 20'd1000000)
                  buffer <= 1'b1;
              timer <= 20'b0;//обнуляем счетчик
          end
      end
        
      assign gpio_sw_c_on = buffer;//передали сигнал
endmodule
