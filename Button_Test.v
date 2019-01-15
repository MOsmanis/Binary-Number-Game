`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:46:35 01/15/2019
// Design Name:   Button
// Module Name:   /home/ise/kp-button/Button_Test.v
// Project Name:  kp-button
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Button
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Button_Test;

	// Inputs
	reg clk;
	reg btn_north;
	reg btn_east;
	reg btn_south;
	reg btn_west;

	// Outputs
	wire btn_out;
	
	// Instantiate the Unit Under Test (UUT)
	Button uut (
		.clk(clk), 
		.btn_north(btn_north), 
		.btn_east(btn_east), 
		.btn_south(btn_south), 
		.btn_west(btn_west), 
		.btn_out(btn_out)
	);
	
	// simulate clock
	always begin
		#10 clk = !clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		btn_north = 0;
		btn_east = 0;
		btn_south = 0;
		btn_west = 0;
		
		#100;
		
		#20 btn_north = 1;
		#30 btn_north = 0;
		#20 btn_north = 1;
		#20 btn_north = 0;
		#10 btn_north = 1;
		
		#300;
		
	   btn_north = 0;
		#30 btn_north = 1;
		#10 btn_north = 0;
		
//		#100;
	end
	
endmodule

