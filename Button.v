`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:29 01/15/2019 
// Design Name: 
// Module Name:    Button 
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
//		Testē�anai, nostādinā�anās laiku var likt daudz mazāku
//////////////////////////////////////////////////////////////////////////////////
module Button(
    	clk,
    btn_north
    btn_out
    );
	 
input clk;
input btn_north, btn_east, btn_south, btn_west;
output reg [0:0] btn_out = 1'b0;

// skaitītājs. pietieko�i ietilpīgs, lai ietvertu pogas stāvokļa nostādinā�anās laiku.
reg [18:0] counter = 0;
// pogas stāvokļa nolasī�anas aiztures mainīgais
//[0]-sagaidītais stāvoklis
//[1]-patiesais stāvoklis
reg [1:0] btn_delay = 0;
// pogas nostādinā�anās laiks (pulksteņa ciklu skaits) 500000 jeb 10ms
	reg [18:0] stl_time = 19'b1111010000100100000;
// skaitī�anas karogs
reg cf = 0;

always @ (posedge clk) begin
	// atjaunina patieso stāvokli
	btn_delay[1] <= btn_north;
	// ja patiesais stāvoklis at�ķiras no sagaidītā, jāuzsāk skaitī�ana
	if (btn_delay[0] != btn_delay[1]) begin
		// atjaunina sagaidīto stāvokli
		btn_delay[0] <= btn_delay[1];
		// iestāda skaitī�anu
		cf = 1;
	end
	// ja skaitī�ana jāturpina un nav sasniegts nostādinā�anās ilgums
	if ((cf == 1) && (counter < stl_time)) begin
		// skaita līdz nostādinā�anās ilgumam
		counter = counter + 1'b1;
	end
	// ja ievads ir gana ilgi bijis stabils un stāvokļi vēl projām sakrīt, un notiek skaitī�ana
	if ((counter == stl_time) && ((btn_delay == 2'b00) || (btn_delay == 2'b11)) && cf == 1) begin
		// reģistrē pogas stāvokļa nomaiņu
		btn_out = ~btn_out;
		// atiestāda skaitī�anu
		cf = 0;
		// restartē skaitītāju
		counter = 19'b0000000000000000000;
	end
end
endmodule
