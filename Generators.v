`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Komanda Alpha
// Engineer: Mārtiņ Kurmis
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
	 output reg [3:0] result = 0;
	 //reg [3:0] last_result = 0;
	 reg [3:0] m_count = 0;		// Galvenais skaitītājs (skat. kol A)
	 reg [2:0] s_count = 0;		// Sekundārais skaitītājs (ik pēc 4 nosac.)
	 reg [3:0] c_count = 0;		// Skaita ciklus
	 
	 /*always @ (posedge enable) begin
		while(result == last_result) begin
			result = $random%8;
		end
		last_result = result;		
		result <= result;
	 end*/
	 
	 always @ (posedge clk) begin
		c_count = c_count + 1;
		if(enable) begin
			if(s_count == 3 || s_count == 7) begin
				m_count = ~m_count;
			end 
			if(s_count < 4) begin
				m_count = m_count +1;
			end else begin
				m_count = m_count -1;
			end
			s_count = s_count + 1;
			result = (m_count  << 2  | m_count >> 2) + c_count; // 2 bitu samainīana vietām
		end
	end
	 
	 // Iekomentētais kods strādā, pēc realizācijas atradu valodā iebūvētu funkciju...
	 /*input enable;
	 output reg [3:0] result = 0;
	 reg [3:0] last_result = 0;
	 
	 always @ (posedge enable) begin
		while(result == last_result) begin
			result = $random%8;
		end
		last_result = result;		
		result <= result;
	 end*/

endmodule
