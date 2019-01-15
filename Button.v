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
//		Testēšanai, nostādināšanās laiku var likt daudz mazāku
//////////////////////////////////////////////////////////////////////////////////
module Button(
    	clk,
    btn_north,
    btn_east,
    btn_south,
    btn_west,
    btn_out
    );
	 
input clk;
input btn_north, btn_east, btn_south, btn_west;
output reg [0:0] btn_out = 1'b0;
	 
// skaitītājs. pietiekoši ietilpīgs, lai ietvertu pogas stāvokļa nostādināšanās laiku.
reg [18:0] counter = 0;
// pogas stāvokļa nolasīšanas aiztures mainīgais
//[0]-sagaidītais stāvoklis
//[1]-patiesais stāvoklis
reg [1:0] btn_delay = 0;
// pogas nostādināšanās laiks (pulksteņa ciklu skaits) 500000 jeb 10ms
reg [18:0] stl_time = 8'b01111010000100100000;
// skaitīšanas karogs
reg cf = 0;

always @ (posedge clk) begin
	// atjaunina patieso stāvokli
	btn_delay[1] = (btn_north || btn_east || btn_south || btn_west);
	// ja patiesais stāvoklis atšķiras no sagaidītā, jāuzsāk skaitīšana
	if (btn_delay[0] != btn_delay[1]) begin
		// atjaunina sagaidīto stāvokli
		btn_delay[0] = btn_delay[1];
		// iestāda skaitīšanu
		cf = 1;
	end
	// ja skaitīšana jāturpina un nav sasniegts nostādināšanās ilgums
	if ((cf == 1) && (counter < stl_time)) begin
		// skaita līdz nostādināšanās ilgumam
		counter = counter + 1'b1;
	end
	// ja ievads ir gana ilgi bijis stabils un stāvokļi vēl projām sakrīt, un notiek skaitīšana
	if ((counter == stl_time) && ((btn_delay == 2'b00) || (btn_delay == 2'b11)) && cf == 1) begin
		// reģistrē pogas stāvokļa nomaiņu
		btn_out = ~btn_out;
		// atiestāda skaitīšanu
		cf = 0;
		// restartē skaitītāju
		counter = 19'b00000000000000000000;
	end
end
endmodule
