`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:07 01/15/2019 
// Design Name: 
// Module Name:    Salidzinatajs_Test 
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
module Salidzinatajs_Test;

	// Inputs
	reg [0:3]num_1;
	reg [0:3]num_2;

	// Outputs
	wire match;

	// Instantiate the Unit Under Test (UUT)
	Salidzinatajs uut (
		.num_1(num_1), 
		.num_2(num_2), 
		.match(match)
	);

	initial begin
		// Initialize Inputs     
		num_1 = 4'b0000;
		num_2 = 4'b1111;
		#20
		num_1 = 4'b0000;
		num_2 = 4'b0111;
		#20
		num_1 = 4'b0000;
		num_2 = 4'b0000;
	end
      
endmodule
