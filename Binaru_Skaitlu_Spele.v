`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Toms Mucenieks
// 
// Create Date:    16:47:07 01/10/2019 
// Design Name: 
// Module Name:    Binaru_Skaitlu_Spele 
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
module Binaru_Skaitlu_Spele(
	IN_GLOBAL_clk, 
	IN_GLOBAL_switch, 
	IN_GLOBAL_button_north,
	IN_GLOBAL_button_west,
	IN_GLOBAL_button_south,
	IN_GLOBAL_button_east
);
	input IN_GLOBAL_clk;
	input [0:3]IN_GLOBAL_switch;
	input IN_GLOBAL_button_north;
	input IN_GLOBAL_button_west;
	input IN_GLOBAL_button_south; 
	input IN_GLOBAL_button_east;

	wire [0:4]OUT_Timer_timeleft; 
	wire OUT_Timer_end_f;
	
	wire [0:7]OUT_Logic_level;
	wire [0:1]OUT_Logic_state; 
	wire OUT_Logic_set_f;
	wire [0:4]OUT_Logic_set_v;
	wire OUT_Logic_number_f;
	
	wire [0:3]OUT_Generator_result;
	
	wire OUT_Match_match;
	
	wire OUT_Button_out;
	
	Timer Timer(
		.clk(IN_GLOBAL_clk),
		.set_f(OUT_Logic_set_f),
		.set_v(OUT_Logic_set_v),
		.timeleft(OUT_Timer_timeleft),
		.end_f(OUT_Timer_end_f)
	);
	
	Speles_Logika Speles_Logika(
		.guess_b(OUT_Button_out), 
		.cmp_r(OUT_Match_match), 
		.end_f(OUT_Timer_end_f),
		.state(OUT_Logic_state), 
		.level(OUT_Logic_level), 
		.set_f(OUT_Logic_set_f), 
		.set_v(OUT_Logic_set_v),
		.number_f(OUT_Logic_number_f)
   );
	
	Generators Generators(
		.enable(OUT_Logic_number_f),
		.result(OUT_Generator_result)
   );

	Salidzinatajs Salidzinatajs(
		.num_1(IN_GLOBAL_switch),
		.num_2(OUT_Generator_result),
		.match(OUT_Match_match) 
   );
	
	Button Button(
		.clk(IN_GLOBAL_clk),
		.btn_north(IN_GLOBAL_button_north),
		.btn_east(IN_GLOBAL_button_east),
		.btn_south(IN_GLOBAL_button_south),
		.btn_west(IN_GLOBAL_button_west),
		.btn_out(OUT_Button_out)
   );

	//TODO: Add display module

endmodule
