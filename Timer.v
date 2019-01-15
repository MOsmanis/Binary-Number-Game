`timescale 1s / 1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:16 01/15/2019 
// Design Name: 
// Module Name:    timer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Pārveido sistēmas pulksteni par uzstādāmu taimeri sekundēs. 
// 				 Ievados ir sistēmas frekvence, iestatīšanas karogs, iestatīšanas vērtība. 
// 				 Izvados ir laiks sekundēs un karogs, kas ziņo par <= 0 atlikušo laiku.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// 
// Testēšana notiek manuāli. 
// Lai testētu moduli, iestāda mainīgo sys_freq uz mazāku skaitli, piemēram, 50.
// Tad palaiž "Simulate Behavioral Model" uz Timer.v
// Iestāda konstantes un pulksteni:
// 	clk: Leading value: 1, Trailing value: 0, Period: 10;
// 	set_f: Value: 1, Cancel after: 100ns;
// 	set_v: Value: 00101;
// Konsolē palaiž simulāciju uz mazu laiku, atbilstošu 100ns + set_v*sys_freq
//
//////////////////////////////////////////////////////////////////////////////////
module Timer(
	clk,
	set_f,
	set_v,
	timeleft,
	end_f
	);

input      clk, set_f;
input      [4:0] set_v;
output reg [4:0] timeleft;
output reg [0:0] end_f;
integer    ticks, sys_freq;

initial ticks = 0;
initial sys_freq = 50000000;

// katru reizi, kad iekšējā pulksteņa signāls no 0 paceļas uz 1
always @ (posedge clk)
	if (set_f) begin
		timeleft = set_v;
		end_f = 0;
	// ja vēl ir laiks
	end else if (timeleft > 0) begin
		ticks = ticks + 1;
		// ja aprit apaļa sekunde
		if (ticks == sys_freq) begin
			timeleft = timeleft - 1'b1;
			ticks = 0;
			// ja taimeris iztek
			if (timeleft == 5'b00000) begin
				end_f = 1'b1;
			end
		end
	end
endmodule
