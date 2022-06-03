module run_light(
    input clk,
    input gpio_sw,
    input pulse,
    output [7:0] leds
    );
    
    reg dir = 1'b1; //направление
    reg [7:0] bits = 8'b10000000;
    //******************************************************************
    //контроль нажатия кнопки
    always @(posedge clk) begin
    if(gpio_sw && (leds[4] == 1 || leds[3] == 1)) 
    begin //кнопку нажимать только один раз, огоньки сменят направление, но после задержки (3 сек)
            if(dir == 1'b0) 
            begin
                dir <= 1'b1;    
            end
            if(dir == 1'b1) 
            begin
                dir <= 1'b0;
            end
    end
    end
    //****************************************************
    //бьегущий огонь, кеонтроль пульса
    
    always @(posedge clk) begin
    if(pulse) 
    begin
            if(dir == 1'b0) 
            begin
                case (bits)
                    8'b00000001: bits <= 8'b00000010;
                    8'b00000010: bits <= 8'b00000100;
                    8'b00000100: bits <= 8'b00001000;
                    8'b00001000: bits <= 8'b00010000;
                    8'b00010000: bits <= 8'b00100000;
                    8'b00100000: bits <= 8'b01000000;
                    8'b01000000: bits <= 8'b10000000;
                    8'b10000000: bits <= 8'b00000001;
                    default: bits <= 8'b00000001;
                endcase 
            end
            else
            begin
                case (bits)
                    8'b10000000: bits <= 8'b01000000;
                    8'b01000000: bits <= 8'b00100000;
                    8'b00100000: bits <= 8'b00010000;
                    8'b00010000: bits <= 8'b00001000;
                    8'b00001000: bits <= 8'b00000100;
                    8'b00000100: bits <= 8'b00000010;
                    8'b00000010: bits <= 8'b00000001;
                    8'b00000001: bits <= 8'b10000000;
                    default: bits <= 8'b10000000;
            endcase 
            end
    end
    end
    assign leds = bits;
endmodule
