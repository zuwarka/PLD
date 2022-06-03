module lcd (
	input clk_4Mhz, 
	input [7:0] inData, //data word //0-15 - first line, 16-31 - second line
	input [5:0] inAddr, 
	input isWrite, //0 - no Update data, 1 - update data
	input isShiftCursor,//0 - no shift, 1 - shift (cursor pos inData[6:0])
	input isUpdate,//if you change data, set 1
	output reg [3:0] LCD_DATA, //change to 4 bit bus
	output LCD_RW, //0
	output reg LCD_EN, //E - signal 
	output reg LCD_RS //RS - signal
	);

    assign LCD_RW = 1'b0; //Write

    reg [5:0] LUT_INDEX;//index of data
    reg [8:0] LUT_DATA;//data
    reg [2:0] mLCD_ST;//Step of transfers command
    reg [17:0] mDLY;//reg deley
    
    
    parameter START_INSTALL = 0;//index_out = 0
    parameter COUNT_START_INSTALLL_COMMAND = 4;
    
    parameter INSTALL_4_bit = COUNT_START_INSTALLL_COMMAND;//index_out = 4
    parameter COUNT_INSTALL_4_bit_COMMAND = 5;
    
    parameter SET_FIRST_LINE = INSTALL_4_bit + COUNT_INSTALL_4_bit_COMMAND;//index_out = 4 + 5 = 9
    
    parameter START_FIRST_LINE = SET_FIRST_LINE + 1; //index_out = 9 + 1 = 10
    parameter SWAP_TO_SECOND_LINE = START_FIRST_LINE + 16;//index_out = 10 + 16 = 26
    
    parameter START_SECOND_LINE = SWAP_TO_SECOND_LINE + 1;//index_out = 26 + 1 = 27
    parameter END_SECOND_LINE = START_SECOND_LINE + 15;//index_out = 27 + 15 = 42
	
    parameter CURSOR_BUF = START_SECOND_LINE + 16;//index_out = 42 + 1 = 43
    
    parameter MEM_SIZE = CURSOR_BUF + 1; //size = 44
    
    reg [8:0]memory_update[MEM_SIZE-1:0];
    
    reg [6:0]cursor_position = 0; //start first line
    reg [7:0]command_buf = 0;
    
    reg [3:0]step = 0;
    reg [5:0]index_out = 0;
    reg [15:0]delay_counter = 0;
    reg [15:0]delay_time = 16'd40500;
    reg is_4_bit_interfeise = 0;
    reg is_VDD_deley = 0;
    reg is_update_data = 1;
    reg is_update_data_start = 1;
    reg is_command = 0;
    reg is_command_start = 0;
    
    always @(posedge clk_4Mhz) begin
	
		if (is_update_data) begin
			//index_out <= SET_FIRST_LINE;
			is_update_data_start <= 1;
		end
			
		if (is_command)
			is_command_start <= 1;	
			
		if (is_4_bit_interfeise) begin
			//use command
			if (is_command_start) begin
				case(step)
					0: begin
						LCD_DATA <= command_buf[7:4];
						LCD_RS <= 0;
						step <= 4'd1;
					end
					1: begin
						LCD_EN <= 1'b1;
						step <= 4'd2;
					end
					2: begin
						LCD_EN <= 1'b0;
						step <= 4'd3;
					end
					3: begin
						LCD_DATA <= command_buf[3:0];
						step <= 4'd4;
					end
					4: begin
						LCD_EN <= 1'b1;
						step <= 4'd5;
					end
					5: begin
						LCD_EN <= 1'b0;
						step <= 4'd6;
					end
					6: begin
						if(delay_counter >= delay_time) begin //Delay 2ms (4 Mhz) delay_time = d8000
							delay_counter <= 0;
							step <= 4'd7;
						end else
							delay_counter <= delay_counter + 1'b1;
					end
					7: begin        
						step <= 4'd0;
						index_out <= SET_FIRST_LINE;
						is_command_start <= 0;
					end
				endcase
			end else begin
				//update data
				if (is_update_data_start) begin
					case(step)
						0: begin
							LCD_DATA <= memory_update[index_out][7:4];
							LCD_RS <= memory_update[index_out][8];
							step <= 4'd1;
						end
						1: begin
							LCD_EN <= 1'b1;
							step <= 4'd2;
						end
						2: begin
							LCD_EN <= 1'b0;
							step <= 4'd3;
						end
						3: begin
							LCD_DATA <= memory_update[index_out][3:0];
							step <= 4'd4;
						end
						4: begin
							LCD_EN <= 1'b1;
							step <= 4'd5;
						end
						5: begin
							LCD_EN <= 1'b0;
							step <= 4'd6;
						end
						6: begin
							if(delay_counter >= delay_time) begin //Delay 2ms (4 Mhz) delay_time = d8000
								delay_counter <= 0;
								step <= 4'd7;
							end else
								delay_counter <= delay_counter + 1'b1;
						end
						7: begin        
							step <= 4'd0;
							if (index_out == CURSOR_BUF) begin
								index_out <= SET_FIRST_LINE;
								is_update_data_start <= 0;
							end
							else
								index_out <= index_out + 1'd1;
						end
					endcase
				end
			end
		end
   
		//init block
        if (~is_VDD_deley) begin
            if (delay_counter >= delay_time) begin //Delay 15ms
                delay_counter <= 0;
                is_VDD_deley <= 1'd1;
            end else
                delay_counter <= delay_counter + 1'b1;
        end
        
        if (~is_4_bit_interfeise && is_VDD_deley) begin
        case(step)
            0: begin
                LCD_DATA <= memory_update[index_out][7:4];
                LCD_RS <= memory_update[index_out][8];
                step <= 4'd1;
            end
            1: begin
                LCD_EN <= 1'b1;
                step <= 4'd2;
            end
            2: begin
                LCD_EN <= 1'b0;
                step <= 4'd3;
            end
            3: begin
                case(index_out)
                    START_INSTALL + 0: delay_time <= 16'd16450;      //Delay 4.1 ms
                    START_INSTALL + 1: delay_time <= 16'd450;        //Delay 100 us                
                    START_INSTALL + 2: delay_time <= 16'd8000;       //Delay 2 ms             
                    START_INSTALL + 3: delay_time <= 16'd8000;       //Delay 2 ms             
                    default: delay_time <= 16'd8000; //Delay 2 ms               
                endcase
                if(delay_counter >= delay_time) begin
                   delay_counter <= 0;
                    step <= 4'd4;
                end
                else 
                    delay_counter <= delay_counter + 1'b1;
            end
            4: begin
                step <= 4'd0;
                index_out <= index_out + 1'd1;
                if (index_out == INSTALL_4_bit - 1)
                    is_4_bit_interfeise <= 1;
            end
        endcase
        end
    end
    
    //update output_data
    always @(isWrite, isShiftCursor) begin
        if (isWrite)
			if (inAddr <= 6'd31)
				if (inAddr < 6'd16)
					memory_update[inAddr + START_FIRST_LINE] <= {1'b1, inData};
				else
					memory_update[inAddr + START_SECOND_LINE - 6'd16] <= {1'b1, inData};
		if (isShiftCursor)
			if (inData <= 6'd31)
				if (inData < 6'd16)    
					memory_update[CURSOR_BUF] <= {2'b01, inData[6:0]};
				else
					memory_update[CURSOR_BUF] <= {2'b01, inData[6:0] - 7'd16 + 7'h40};
    end
    
    //set update
    always @(isUpdate) begin
		is_update_data <= isUpdate;
    end
	
	//set update
    always @(isShiftCursor) begin
        if (isShiftCursor) begin
			is_command <= 1;
			if (inData <= 6'd31)
				if (inData < 6'd16)
					command_buf <= {1'b1, inData[6:0]};     
				else
					command_buf <= {1'b1, inData[6:0] - 7'd16 + 7'h40};
		end
		else begin
			is_command <= 0;
            command_buf <= {1'b1, memory_update[CURSOR_BUF][6:0]};
	   end
    end
        initial begin
        
            LCD_EN <= 0;
            is_update_data <= 1;
        
            //install
            
            //start_ilstall
            memory_update[START_INSTALL + 0] <= 9'h030;
            memory_update[START_INSTALL + 1] <= 9'h030;
            memory_update[START_INSTALL + 2] <= 9'h030;
            memory_update[START_INSTALL + 3] <= 9'h020;
            
            //in_4_bit_interfeise
            memory_update[INSTALL_4_bit + 0] <= 9'h028; //DL=4D, N=2R, F=5*8 Style
            memory_update[INSTALL_4_bit + 1] <= 9'h008; //Off display
            memory_update[INSTALL_4_bit + 2] <= 9'h001; //Clear display
            memory_update[INSTALL_4_bit + 3] <= 9'h006; //Set write type left->right
            memory_update[INSTALL_4_bit + 4] <= 9'h00E; //On display D = 1, C = 1, B = 0 
            
            memory_update[SET_FIRST_LINE] <= 9'h080; //set fist line
            
            //line1
            memory_update[START_FIRST_LINE + 0] <= 9'h153;  //S
            memory_update[START_FIRST_LINE + 1] <= 9'h161;  //a
            memory_update[START_FIRST_LINE + 2] <= 9'h169;  //i
            memory_update[START_FIRST_LINE + 3] <= 9'h16E;  //n
            memory_update[START_FIRST_LINE + 4] <= 9'h174;  //t
            memory_update[START_FIRST_LINE + 5] <= 9'h12D;  //-
            memory_update[START_FIRST_LINE + 6] <= 9'h120;  //
            memory_update[START_FIRST_LINE + 7] <= 9'h120;  //
            memory_update[START_FIRST_LINE + 8] <= 9'h120;  //
            memory_update[START_FIRST_LINE + 9] <= 9'h120;  //
            memory_update[START_FIRST_LINE + 10] <= 9'h120; //
            memory_update[START_FIRST_LINE + 11] <= 9'h120; //
            memory_update[START_FIRST_LINE + 12] <= 9'h120; //
            memory_update[START_FIRST_LINE + 13] <= 9'h120; //
            memory_update[START_FIRST_LINE + 14] <= 9'h120; //
            memory_update[START_FIRST_LINE + 15] <= 9'h120; //
            
            memory_update[SWAP_TO_SECOND_LINE] <= 9'h0C0;  //start secondline
            
            //line2
            memory_update[START_SECOND_LINE + 0]  <= 9'h150;  //P
            memory_update[START_SECOND_LINE + 1]  <= 9'h165;  //e
            memory_update[START_SECOND_LINE + 2]  <= 9'h174;  //t
            memory_update[START_SECOND_LINE + 3]  <= 9'h165;  //e
            memory_update[START_SECOND_LINE + 4]  <= 9'h172;  //r
            memory_update[START_SECOND_LINE + 5]  <= 9'h173;  //s
            memory_update[START_SECOND_LINE + 6]  <= 9'h162;  //b
            memory_update[START_SECOND_LINE + 7]  <= 9'h175;  //u
            memory_update[START_SECOND_LINE + 8]  <= 9'h172;  //r
            memory_update[START_SECOND_LINE + 9]  <= 9'h167;  //g
            memory_update[START_SECOND_LINE + 10] <= 9'h120;  //
            memory_update[START_SECOND_LINE + 11] <= 9'h120;  //
            memory_update[START_SECOND_LINE + 12] <= 9'h120;  //
            memory_update[START_SECOND_LINE + 13] <= 9'h120;  //
            memory_update[START_SECOND_LINE + 14] <= 9'h120;  //
            memory_update[START_SECOND_LINE + 15] <= 9'h120;  //
            
            
            memory_update[CURSOR_BUF] <= 9'h080;  //
            
            
        end

endmodule
