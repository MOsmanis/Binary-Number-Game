`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Komanda Alpha
// Engineer: Mārtiņš Kurmis
// 
// Create Date:    19:12:05 01/11/2019 
// Design Name: 
// Module Name:    Generators 
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
module Generators(
		clk,			// Sistēmas pulkstenis
		enable, 	// On/Off
		result 		// Izvada skaitlis   
    );
	 input clk;
	 input enable;
	 output reg [0:3] result = 0;
	 reg [0:3] m_count = 0;		// Galvenais skaitītājs (skat. kol A)
	 reg [0:2] s_count = 0;		// Sekundārais skaitītājs (ik pēc 4 nosac.)
	 reg [0:3] nm_count = 0;	// Rotētais (negatīvais) skaitītājs
	 reg nflag = 0;							// Rotēšanas karogs
	 
	 always @ (posedge clk) begin
		if(enable) begin
			if(s_count != 4) begin
				s_count <= s_count + 1;
				m_count <= m_count + 1;
			end else begin
				s_count <= 0;
				nflag = ~nflag;
			end
			if(nflag) begin
				nm_count <= !m_count;
			else
				nm_count <= m_count;
			end
			result <= nm_count;
		end
	end

endmodule
