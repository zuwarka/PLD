module var19(
    input clk_p,
    input clk_n,
    input GPIO_SW_C,
    output [7:0] o_led
    );
    
    wire clk_mid;
    wire clk;
    
    IBUFDS #(
         .DIFF_TERM("FALSE"), 
         .IBUF_LOW_PWR("TRUE"),
         .IOSTANDARD("DEFAULT")
     ) IBUFDS_inst (
         .O(clk_mid),
         .I(clk_p),
         .IB(clk_n)
     );
     BUFG BUFG_inst (
         .O(clk),
         .I(clk_mid)
     );
     
     //19. К порту GPIO_LED подключены 8 светодиодов.
     //Организовать «бегущий огонь» со скоростью 1
     //сдвиг в 3 сек. Кнопка, подключенная к GPIO_SW,
     //меняет направление "бега", если в момент нажатия
     //на кнопку горит 3-й или 4-й светодиод в линейке.
     
     //******************************************************************
     
     //таймер обработки импульсов
     reg [63:0] delay_timer = 0; //задрежка для бегущего огня
     wire pulse;
     assign pulse = (delay_timer == 600000000) ? 1'b1 : 1'b0; 
    
     // пукльс стоит в ноль пока задержка 599...
     // в тысячные доли секунд пульс смещается в единицу
     // в этот момент происхордит смещение огонька
     
     always @(posedge clk) begin
     if(delay_timer == 600000000) begin
     delay_timer <= 0;
     end
     else begin
     delay_timer <= delay_timer + 1;
     end
     end
     //под три секунды
     
     //******************************************************************
     
     //зажигаем огоньки
     reg [7:0] shifting = 8'b10000000;
     assign o_led = shifting;
     
     //контроль нажатия кнопки
     
     wire GPIO_SW_C_ON;
     button btn(clk, GPIO_SW_C, GPIO_SW_C_ON);
     
     //бегущий огонь. Если кнопка зажата и  - меняем направлние
     wire [7:0] run_led;
     run_light(clk, GPIO_SW_C_ON, pulse, run_led);
     
     always @(posedge clk)
     begin
     shifting <= run_led;
     end
     
     //инкрементируем задержку по положительному фронту (подсчет срабатывания фронта)
     //200млн раз сработал = 1 секунда. Это проверяется по задрежке
     //900млн - это уже три секнуды. То, что нам нужно
     //******************************************************************
endmodule
