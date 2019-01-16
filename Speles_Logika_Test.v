`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:07 01/15/2019 
// Design Name: 
// Module Name:    Speles_Logika_Test
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Speles_Logika_Test;

	//INPUT
	reg guess_b, cmp_r, end_f;
	
	//OUTPUT
	wire [1:0]state;
	wire [7:0]level;
	wire time_f; 
	wire [4:0]time_v;
	wire g_enable;

	// Instantiate the Unit Under Test (UUT)
	Speles_Logika uut(
		//INPUT
		.guess_b(guess_b), 
		.cmp_r(cmp_r), 
		.end_f(end_f),
		//OUTPUT
		.state(state), 
		.level(level), 
		.time_f(time_f), 
		.time_v(time_v),
		.g_enable(g_enable)
   );

	initial begin
		// Initialize Inputs    
		guess_b = 0;
		end_f = 0;
		cmp_r = 0;
		#20
		guess_b = 1; //state 1
		#20
		guess_b = 0; //state 1
		#20
		guess_b = 1; //state 2
		#20
		guess_b = 0; //state 2
		cmp_r = 1; //Set compare result true
		#20
		guess_b = 1; // State 1 - win
		#20
		guess_b = 0; //State 1 - win	
	end
      
endmodule
