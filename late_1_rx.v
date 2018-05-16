module late_1_rx(clk,rst,wr_en,enable,rx,rx_data);
	input 		clk,rst,wr_en,enable;
	input 		rx;
	output reg  [7:0] rx_data;
	reg			[7:0] rx_reg;
	reg			[4:0] state;
	reg			[4:0] next_state;
	wire    	rx,clk,rst,wr_en,enable;
	reg			[4:0] count;
	
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
				
	always@(posedge clk)
		
		begin:RX_REGISTER
		rx_reg <= 0;
			if(rst == 1)begin
			rx_data <= 8'b0;
			end
		    else if(wr_en == 1 && enable == 1) begin
			rx_reg[7:0] <= {rx_reg[6:0],rx};
			//rx_reg[7:0] <= {rx,rx_reg[7:1]};
			count  <= count + 1;
			end
			
			//if (count == 8)begin
			//state <= STOP;
			//end
			//else begin
			//count <= count + 1;
			//end												 						
		end
		
		
	always@(state or wr_en or enable)
		begin:COMB_LOGIC
		next_state = 4'b0000;
				
				case(state)
				
				 IDLE  : //if(wr_en == 1'b1 && enable == 1'b1)
						begin
						next_state = START;
						end
						//else begin
						//next_state = IDLE;
						//end
				 START :  if(wr_en == 1'b1 && enable == 1'b1)
						begin
						//tx_reg<= 8'd0;
						next_state = DATA_0;
						end
				 DATA_0: if(count == 0) //if(tx == 1'b0)    if(wr_en == 1'b1 && enable == 1'b1)
						begin
						//tx_reg<= 0;
						next_state = DATA_1;
						end
				 DATA_1:if(count == 1)// if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_2;
						end
				 DATA_2:if(count == 2)// if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_3;
						end
				 DATA_3:if(count == 3)// if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_4;
						end
				 DATA_4:if(count == 4) //if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_5;
						end
				 DATA_5:if(count == 5) //if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_6;
						end
				 DATA_6: if(count == 6)//if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = DATA_7;
						end
				 DATA_7: if(count == 7)//if(tx_reg)
						begin
						//tx_reg<= 0;
						next_state = STOP;
						end
				 STOP  : if(count == 8)//if(tx_reg)
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
			
			  begin
				state <= next_state;
				case(state)
				
				 IDLE  : //if(wr_en == 1'b1 && enable == 1'b1)
						begin
						rx_data <= 0;
						end
						
				 START :
						begin
						//tx_reg<= 8'd0;
						//rx_data <= 1'b0;
						count   <= 0;
						end
				 
				 DATA_0://if(count == 0)
						begin
						//tx_reg<= 0;
						rx_data[count] <= rx_reg[count];
						//count   <= count + 1;
						end
						
				 DATA_1://if(count == 1)
						begin
						//tx_reg<= 0;
						rx_data[count] <= rx_reg[count];
						//count   <= count + 1;
						end
						
				 DATA_2://if(count == 2)
						begin
						//tx_reg<= 0;
						rx_data[count] <= rx_reg[count];
						//count   <= count + 1;
						end
						
				 DATA_3://if(count == 3)
						begin
						//tx_reg<= 0;
						rx_data[count] <= rx_reg[count];
						//count   <= count + 1;
						end
						
				 DATA_4://if(count == 4)
						begin
						//tx_reg<= 0;
						rx_data[count] <= rx_reg[count];
						count   <= count + 1;
						end
						
				 DATA_5://if(count == 5)
						begin
						//tx_reg<= 0;
						rx_data[count] <= rx_reg[count];
						//count   <= count + 1;
						end
						
				 DATA_6://if(count == 6)
						begin
						//tx_reg<= 0;
						rx_data[count] <= rx_reg[count];
						//count   <= count + 1;
						end
						
				 DATA_7://if(count == 7)
						begin
						//tx_reg<= 0;
						rx_data[count] <= rx_reg[count];
						//count   <= count + 1;
						end
						
				 STOP  : //if(count == 8)
						begin
						state  <= IDLE;
						rx_reg <= 8'b00000000;
						count  <= 0;
						end
						
				 default:begin
						state <= IDLE;
					    end
				endcase
			end
		end
endmodule
		