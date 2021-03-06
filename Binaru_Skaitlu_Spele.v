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
	STATE_TEST_LEDS,
	GENERATOR_TEST_LEDS,
	OUT_DISPLAY_sf_e,
	OUT_DISPLAY_e,
	OUT_DISPLAY_rs,
	OUT_DISPLAY_rw,
	OUT_DISPLAY_d,
	OUT_DISPLAY_c,
	OUT_DISPLAY_b,
	OUT_DISPLAY_a
);
	input IN_GLOBAL_clk;
	input [3:0]IN_GLOBAL_switch;
	input IN_GLOBAL_button_north;
	 
	
	wire [4:0]OUT_Timer_timeleft; 
	wire OUT_Timer_end_f;
	
	wire [7:0]OUT_Logic_level;
	wire [1:0]OUT_Logic_state; 
	wire OUT_Logic_time_f;
	wire [4:0]OUT_Logic_time_v;
	wire OUT_Logic_g_enable;
	
	wire [3:0]OUT_Generator_result;
	
	wire OUT_Match_match;
	
	wire OUT_Button_out;
	
	//Display
	output OUT_DISPLAY_sf_e;
	output OUT_DISPLAY_e;
	output OUT_DISPLAY_rs;
	output OUT_DISPLAY_rw;
	output OUT_DISPLAY_d;
	output OUT_DISPLAY_c;
	output OUT_DISPLAY_b;
	output OUT_DISPLAY_a;
	
	output [1:0]STATE_TEST_LEDS;
	output [3:0]GENERATOR_TEST_LEDS;
	
	assign STATE_TEST_LEDS = OUT_Logic_state;
	
	assign GENERATOR_TEST_LEDS = OUT_Generator_result; 
	
	Timer Timer(
		.clk(IN_GLOBAL_clk),
		.time_f(OUT_Logic_time_f),
		.time_v(OUT_Logic_time_v),
		.timeleft(OUT_Timer_timeleft),
		.end_f(OUT_Timer_end_f)
	);
	
	Speles_Logika Speles_Logika(
		.guess_b(OUT_Button_out), 
		.cmp_r(OUT_Match_match), 
		.end_f(OUT_Timer_end_f),
		.state(OUT_Logic_state), 
		.level(OUT_Logic_level), 
		.time_f(OUT_Logic_time_f), 
		.time_v(OUT_Logic_time_v),
		.g_enable(OUT_Logic_g_enable)
   );
	
	Generators Generators(
		.clk(IN_GLOBAL_clk),
		.enable(OUT_Logic_g_enable),
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
		.btn_out(OUT_Button_out)
   );
	
	Displejs Displejs(
		.game_state(OUT_Logic_state),
		.g_num(OUT_Generator_result),
		.timeleft(OUT_Timer_timeleft),
		.level(OUT_Logic_level),
		.clk(IN_GLOBAL_clk),
		.sf_e(OUT_DISPLAY_sf_e),
		.e(OUT_DISPLAY_e),
		.rs(OUT_DISPLAY_rs),
		.rw(OUT_DISPLAY_rw),
		.d(OUT_DISPLAY_d),
		.c(OUT_DISPLAY_c),
		.b(OUT_DISPLAY_b),
		.a(OUT_DISPLAY_a)
   );
endmodule
