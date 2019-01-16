`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:14:19 01/16/2019
// Design Name:   Generators
// Module Name:   /home/anger/Desktop/BN/Binary-Number-Game/Generators_Test.v
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
	wire [3:0] result;

	// Instantiate the Unit Under Test (UUT)
	Generators uut (
		.clk(clk), 
		.enable(enable), 
		.result(result)
	);
	
	always begin
		#10 clk = !clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		enable = 1;
		#320
		enable = 0; // Izslēgta moduļa vērtības uzturēšanas tests
		#80
		enable = 1;
        
		// Add stimulus here

	end
      
endmodule

