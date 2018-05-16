`timescale 1ns / 1ps

module late_1_rx_TB;

	// Inputs
	reg clk;
	reg rst;
	reg enable;
	reg wr_en;
	reg rx;

	// Outputs
	wire [7:0]rx_data;

	// Instantiate the Unit Under Test (UUT)
	late_1_rx uut (
		.clk(clk), 
		.rst(rst), 
		.enable(enable), 
		.wr_en(wr_en), 
		.rx(rx), 
		.rx_data(rx_data)
	);

	initial 
	begin
		clk = 0;
		forever 
		begin
		clk = #5! clk;
		end
	end
		// Initialize Inputs
	initial
		begin
		rst = 0;
		enable = 0;
		wr_en = 0;
		rx = 0;

		// Wait 100 ns for global reset to finish
		#30;
        
		
		#15 rst     = 1'b1;
		#15 rst     = 1'b0;
		
		#50 enable  = 1'b1;
		#10 wr_en   = 1'b1;
		
		#15 rx	    = 1;
		#15 rx	    = 0;
		#15 rx	    = 0;
		#15 rx	    = 1;
		#15 rx	    = 1;
		#15 rx	    = 0;
		#15 rx	    = 0;
		#15 rx	    = 1;
		
		
		//#50 enable  = 1'b0;
		//#50 wr_en   = 1'b0;
		//#100
		//#50 enable  = 1'b1;
		//#10 wr_en   = 1'b1;
		//#50 enable  = 1'b0;
		//#50 wr_en   = 1'b0;
		#20 rx	    = 0;
		//#20 rx	    = 0;
		//#20 rx	    = 0;
		//#20 rx	    = 1;
		//#20 rx	    = 1;
		//#20 rx	    = 0;
		//#20 rx	    = 0;
		//#20 rx	    = 0;
		
		
		#500 $finish;        // Add stimulus here

	end
      
endmodule

