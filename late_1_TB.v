`timescale 1ns / 1ps

module late_1_TB;

	// Inputs
	reg clk;
	reg rst;
	reg enable;
	reg rd_en;
	reg [7:0] rx_data;

	// Outputs
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	late_1 uut (
		.clk(clk), 
		.rst(rst), 
		.enable(enable), 
		.rd_en(rd_en), 
		.tx(tx), 
		.rx_data(rx_data)
	);
	
	initial 
		begin
			clk = 0;
			forever 
				begin
					clk = #5 !clk;
				end
		end
	initial 
	begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		enable = 0;
		rd_en = 0;
		rx_data = 0;

		// Wait 100 ns for global reset to finish
		#30;
        
		
		#15 rst     = 1'b1;
		#15 rst     = 1'b0;
		#10 enable  = 1'b1;
		#10 rd_en   = 1'b1;
		#20 rx_data = 8'b10101010;				
		#70 enable  = 1'b0;
		#70 rd_en   = 1'b0;
		#10 enable  = 1'b1;
		#10 rd_en   = 1'b1;
		#20 rx_data = 8'b00011000;
		#70 enable  = 1'b0;
		#70 rd_en   = 1'b0;
		
		//#15	rx_data = 0;
		
		#500 $finish;        // Add stimulus here

	end
      
endmodule

