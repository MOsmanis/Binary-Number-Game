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
		state, level, time_f, time_v, g_enable
    );
	input guess_b, cmp_r, end_f;
	output reg [0:1]state;
	output reg [0:7]level;
	output reg time_f, g_enable; 
	output reg [0:4]time_v;
	
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
	 
	 time_f = 0;
	 time_v = 30;
	 
	 g_enable = 0;
	end
	
	always@(posedge guess_b) begin
		if(currentState == 0) begin //Sveicinâti
			currentState = 1;
			state = 1;
		end 
		else if(currentState == 1) begin //Sâkt Spçli
			currentState = 2;
			state = 2;
			
			//Laika uzstâdîðana == min(totaltime-(2*lîm),3)
			calculatedTime = totalTime - (2 * currentLevel);
			if (calculatedTime > 3) time_v = calculatedTime;
			else time_v = 3;
			time_f = 1;
			
			//Generate number
			g_enable = 1;
		end 
		else if(currentState == 2) begin //Iegût rezultâtu
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
		else if(currentState == 3) begin //Lûzeris
			//Generate number
			g_enable = 0;
		
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
