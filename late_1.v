module late_1(clk,rst,rd_en,enable,tx,rx_data);
	
	input	[7:0]rx_data;
	input	clk,rst,rd_en,enable;
	output	tx;
	reg 	tx;
	reg		[3:0]state;
	reg		[3:0]next_state;
	reg		[7:0]tx_reg;
	
	//wire	[7:0]tx_reg;
	wire    clk,rst,rd_en,enable;
	
	parameter	IDLE   = 4'b0000,
				START  = 4'b0001,
				DATA_0 = 4'b0010,
				DATA_1 = 4'b0011,
				DATA_2 = 4'b0100,
				DATA_3 = 4'b0101,
				DATA_4 = 4'b0110,
				DATA_5 = 4'b0111,
				DATA_6 = 4'b1000,
				DATA_7 = 4'b1001,
				STOP   = 4'b1010;	

	//assign tx_reg = rx_data;
	//assign tx_reg = (next_state[STOP]) ? 1'd0:tx_reg;	
	//assign tx_reg = (next_state[STOP]) ? 1'd0:rx_data;		
	
	always@(posedge clk)
		begin:TX_REGISTER
			if(rst == 1'b1)
				tx_reg <= 0;
			else if(rd_en ==1 && enable == 1) 
			tx_reg <= rx_data;
		end
			
	
	always@(state or rd_en or enable)
		begin:COMB_LOGIC
		next_state = 4'b0000;
		
				case(state)
				
				 IDLE  : if(rd_en == 1'b1 && enable == 1'b1)
						
							begin
							next_state = START;
							end
						else begin
						next_state = IDLE;
						end
				 START :  //if(rd_en == 1'b1 && enable == 1'b1)
						begin
						//tx_reg<= 8'd0;
						next_state = DATA_0;
						end
				 DATA_0:  //if(tx == 1'b0)    if(rd_en == 1'b1 && enable == 1'b1)
						begin
						//tx_reg<= 0;
						next_state = DATA_1;
						end
				 DATA_1:// if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_2;
						end
				 DATA_2:// if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_3;
						end
				 DATA_3:// if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_4;
						end
				 DATA_4: //if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_5;
						end
				 DATA_5: //if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_6;
						end
				 DATA_6: //if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_7;
						end
				 DATA_7: //if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = STOP;
						end
				 STOP  : //if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = IDLE;
						end
				 default:begin
						next_state = IDLE;
					    end
				endcase
		end
			
	always@(posedge clk)
		begin:SEQ_LOGIC
		tx <= 1'b1;
			if(rst == 1'b1)
				begin
					tx     <= 1'b1;
					state  <= IDLE;
					tx_reg <= 1'd0;
				end
			else
			  begin
				state <= next_state;
				case(state)
				
				 IDLE  :
						begin
						tx    <= 1'b1;
						end
						
				 START : //if(rd_en == 1'b1 && enable == 1'b1)
						begin
						//tx_reg<= 8'd0;
						tx    <= 1'b0;
						end
				 
				 DATA_0: if(tx == 1'b0)
						begin
						//tx_reg<= 0;
						tx    <= tx_reg[0];
						end
						
				 DATA_1:begin
						//tx_reg<= 0;
						tx    <= tx_reg[1];
						end
						
				 DATA_2:begin
						//tx_reg<= 0;
						tx    <= tx_reg[2];
						end
						
				 DATA_3:begin
						//tx_reg<= 0;
						tx    <= tx_reg[3];
						end
						
				 DATA_4:begin
						//tx_reg<= 0;
						tx    <= tx_reg[4];
						end
						
				 DATA_5:begin
						//tx_reg<= 0;
						tx    <= tx_reg[5];
						end
						
				 DATA_6:begin
						//tx_reg<= 0;
						tx    <= tx_reg[6];
						end
						
				 DATA_7:begin
						//tx_reg<= 0;
						tx    <= tx_reg[7];
						end
						
				 STOP  :if(tx == tx_reg[7])
						begin
						state <= IDLE;
						tx    <= 1'b1;
						end
						
				 default:begin
						state <= IDLE;
					    end
				endcase
			end
		end
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			
			