`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:55:56 01/12/2019
// Design Name:   Generators
// Module Name:   /home/anger/Desktop/Binary-Number-Game/Generators_Test.v
// Project Name:  Binaru_Skaitlu_Spele_IDP
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Generators
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Generators_Test;

	// Inputs
	reg clk;
	reg enable;

	// Outputs
	wire [0:3] result;

	// Instantiate the Unit Under Test (UUT)
	Generators uut (
		.clk(clk), 
		.enable(enable), 
		.result(result)
	);

	initial begin
		// Initialize Inputs     
		clk = 0;
		enable = 1;
		repeat(32) #10 clk = ~clk;
		enable = 0; // Izslēgta moduļa vērtības uzturēšanas tests
		repeat(8) #10 clk = ~clk;
		enable = 1;
		repeat(128) #10 clk = ~clk;
	end
      
endmodule

