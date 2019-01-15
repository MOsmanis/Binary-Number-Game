`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Toms Mucenieks
// 
// Create Date:    12:26:15 01/15/2019 
// Design Name: 
// Module Name:    Salidzinatajs 
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

module Salidzinatajs(
		num_1,
		num_2,
		match 
    );
	 
	 input [0:3] num_1;
	 input [0:3] num_2;
	 output match;
	 
	 assign match = num_1 == num_2;
endmodule
