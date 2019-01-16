`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:19:32 01/16/2019
// Design Name:   Binaru_Skaitlu_Spele
// Module Name:   /home/martins/Downloads/Binaru_Skaitlu_Spele_IDP/Displejs_test.v
// Project Name:  Binaru_Skaitlu_Spele_IDP
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Binaru_Skaitlu_Spele
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Displejs_test;

	// Inputs
	reg clk;
	reg [1:0] game_state;

	// Outputs
	wire sf_e;
	wire e;
	wire rs;
	wire rw;
	wire d;
	wire c;
	wire b;
	wire a;

	// Instantiate the Unit Under Test (UUT)
	Displejs uut (
		.game_state(game_state),
		.clk(clk), 
		.sf_e(sf_e), 
		.e(e), 
		.rs(rs), 
		.rw(rw), 
		.d(d), 
		.c(c), 
		.b(b), 
		.a(a)
	);

initial begin
game_state=1;
clk =  0;
	forever begin
		#20 clk = ~clk;
		//monitor("e=%d \d=%d \c=%d \b=%d \a=%d \clk=%d",e, d,c,b,a, clk);
end end
		
endmodule

