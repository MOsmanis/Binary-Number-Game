`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Toms Mucenieks
// 
// Create Date:    15:08:18 01/15/2019 
// Design Name: 
// Module Name:    Speles_Logika 
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
module Speles_Logika(
		guess_b, cmp_r, end_f,
		state, level, set_f, set_v, number_f
    );
	input guess_b, cmp_r, end_f;
	output reg [0:1]state;
	output reg [0:7]level;
	output reg set_f, number_f; 
	output reg [0:4]set_v;
	
	reg [0:1]currentState;
	reg [0:7]currentLevel;
	reg [0:4]totalTime;
	
	//Temps
	reg [0:7] calculatedTime;
	
	initial begin
    currentLevel = 0;
	 level = 0;
	 
	 currentState = 0;
	 state = 0;
	 
	 totalTime = 30;
	 
	 set_f = 0;
	 set_v = 30;
	 
	 number_f = 0;
	end
	
	always@(posedge guess_b) begin
		if(currentState == 0) begin //Sveicin�ti
			currentState = 1;
			state = 1;
		end 
		else if(currentState == 1) begin //S�kt Sp�li
			currentState = 2;
			state = 2;
			
			//Laika uzst�d��ana == min(totaltime-(2*l�m),3)
			calculatedTime = totalTime - (2 * currentLevel);
			if (calculatedTime > 3) set_v = calculatedTime;
			else set_v = 3;
			set_f = 1;
			
			//Generate number
			number_f = 1;
		end 
		else if(currentState == 2) begin //Ieg�t rezult�tu
			if(cmp_r && !end_f)
			begin //Pareizi un laiks nav beidzies.
				currentLevel = currentLevel + 1;
				level = currentLevel + 1;
				
				currentState = 1;
				state = 1;
			end else begin //Nepareizi 
				currentState = 3;
				state = 3;
			end
		end
		else if(currentState == 3) begin //L�zeris
			//Generate number
			number_f = 0;
		
			currentState = 1;
			state = 1;
			
			currentLevel = 1;
			level = 1;
		end
	end
	
	always@(posedge end_f) begin //Laiks beidzies
		level = currentLevel;
	
		currentState = 3;
		state = 3;
	end
endmodule
