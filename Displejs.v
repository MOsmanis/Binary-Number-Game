`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:40 01/15/2019 
// Design Name: 
// Module Name:    Displejs 
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
module Displejs(
		game_state,
		g_num,
		timeleft,
		level,
		clk,
		sf_e,
		e,
		rs,
		rw,
		d,
		c,
		b,
		a
    );
	 
	 input [1:0] game_state;
	 input [3:0] g_num;
	 input [4:0] timeleft;
	 input [7:0] level;
	 
	 (* LOC = "C9" *) input clk; //50-MHz
	 (* LOC = "D16" *) output reg sf_e; // 1 - LCD pieeja (0 = StrataFlash pieeja)
	 (* LOC = "M18" *) output reg e; // Enable - 1
	 (* LOC = "L18" *) output reg rs; //Register Select (1 prieks Read and Write)
	 (* LOC = "L17" *) output reg rw; //Read and Write
	 (* LOC = "M15" *) output reg d; //ceturtais bits (lai izveidotu nibble)
	 (* LOC = "P17" *) output reg c; //tresais bits (lai izveidotu nibble)
	 (* LOC = "R16" *) output reg b; //otrais bits (lai izveidotu nibble)
	 (* LOC = "R15" *) output reg a; //pirmais bits (lai izveidotu nibble)
	 
	 /*reg [ 18 : 0 ] count = 0;
	 reg [ 6 : 0 ] message_count;
	 reg send_messages;*/
	 reg [ 5 : 0 ] code;
	 /*reg jauns = 1;
	 reg refresh;
	 reg init = 1;*/
	 parameter [ 19 : 0 ] clk_1 = 1;
	 parameter [ 19 : 0 ] clk_2 = 2;
	 parameter [ 19 : 0 ] clk_12 = 12;//1100
	 parameter [ 19 : 0 ] clk_50 = 50;//110010  13;//
	 parameter [ 19 : 0 ] clk_2k = 2000;//11111010000 
	 parameter [ 19 : 0 ] clk_5k = 5000;//1001110001000 15;//
	 parameter [ 19 : 0 ] clk_82k = 82000;//1010000000101000 16;//
	 parameter [ 19 : 0 ] clk_205k = 205000;//17;//
	 parameter [ 19 : 0 ] clk_750k = 750000;//10110111000110110000 18;//
	 reg [ 19 : 0 ] clk_timer = 0;
	 reg read_next_nibbles = 0;
	 reg [ 5 : 0 ] next_upper_nibble;// dati, kurus pados atkarigi no ievada parametriem
	 reg [ 5 : 0 ] next_lower_nibble;
	 reg reset_timer=1;
	 reg flag_1=0,flag_2=0,flag_12=0,flag_50=0,flag_2k=0,flag_5k=0,flag_82k=0,flag_205k=0,flag_750k=0;
	 reg gatavs=0;
	 /*reg [ 5 : 0 ] current_state_nibbles[ 6 : 0 ];
	 reg [ 1 : 0 ] states[ 6 : 0 ];*/
	 reg [ 2 : 0 ] nibbles_size = 66;
	 reg [ 2 : 0 ] game_state_1_size = 68;
	 reg [ 5 : 0 ] game_state_1 [ 67 : 0 ];
	 reg [ 5 : 0 ] game_state_2 [ 3 : 0 ];
	 reg [ 5 : 0 ] game_state_3 [ 3 : 0 ];
	 reg [ 5 : 0 ] game_state_4 [ 3 : 0 ];
	 reg [ 6 : 0 ] game_state_index =0;
	 reg init_game_states=1;
	 reg game_state_changed=0;
	 integer i;
	 always@(game_state)begin
		game_state_changed<=0;
		game_state_index <=0;
	 end
	 always@(posedge clk) begin
			if(init_game_states)
				for (i=0; i<68; i=i+1) begin
					case(i)
						0:game_state_1[0]<=6'b000000;/*noliek kursoru ekrana sakuma*/
						1:game_state_1[1]<=6'b000010;
						2:game_state_1[2]<=6'b100010;/* */
						3:game_state_1[3]<=6'b100000;
						4:game_state_1[4]<=6'b100100;/*B*/
						5:game_state_1[5]<=6'b100010;
						6:game_state_1[6]<=6'b100110;/*i*/
						7:game_state_1[7]<=6'b101001;
						8:game_state_1[8]<=6'b100110;/*n*/
						9:game_state_1[9]<=6'b101110;
						10:game_state_1[10]<=6'b100101;/*T*/
						11:game_state_1[11]<=6'b100100;
						12:game_state_1[12]<=6'b100110;/*o*/
						13:game_state_1[13]<=6'b101111;
						14:game_state_1[14]<=6'b100100;/*D*/
						15:game_state_1[15]<=6'b100100;
						16:game_state_1[16]<=6'b100110;/*e*/
						17:game_state_1[17]<=6'b100101;
						18:game_state_1[18]<=6'b100110;/*c*/
						19:game_state_1[19]<=6'b100011;
						20:game_state_1[20]<=6'b100010;/* */
						21:game_state_1[21]<=6'b100000;
						22:game_state_1[22]<=6'b100101;/*S*/
						23:game_state_1[23]<=6'b100011;
						24:game_state_1[24]<=6'b100111;/*p*/
						25:game_state_1[25]<=6'b100000;
						26:game_state_1[26]<=6'b100110;/*e*/
						27:game_state_1[27]<=6'b100101;
						28:game_state_1[28]<=6'b100110;/*l*/
						29:game_state_1[29]<=6'b101100;
						30:game_state_1[30]<=6'b100110;/*e*/
						31:game_state_1[31]<=6'b100101;
						32:game_state_1[32]<=6'b100010;/* */
						33:game_state_1[33]<=6'b100000;
						34:game_state_1[34]<=6'b001100;/*noliek kursoru otraja linija*/
						35:game_state_1[35]<=6'b000000;
						36:game_state_1[36]<=6'b100011;/*<*/
						37:game_state_1[37]<=6'b101100;
						38:game_state_1[38]<=6'b100101;/*S*/
						39:game_state_1[39]<=6'b100011;
						40:game_state_1[40]<=6'b100110;/*a*/
						41:game_state_1[41]<=6'b100001;
						42:game_state_1[42]<=6'b100110;/*k*/
						43:game_state_1[43]<=6'b101011;
						44:game_state_1[44]<=6'b100111;/*t*/
						45:game_state_1[45]<=6'b100100;
						46:game_state_1[46]<=6'b100010;/* */
						47:game_state_1[47]<=6'b100000;
						48:game_state_1[48]<=6'b100010;/* */
						49:game_state_1[49]<=6'b100000;
						50:game_state_1[50]<=6'b100010;/* */
						51:game_state_1[51]<=6'b100000;
						52:game_state_1[52]<=6'b100010;/* */
						53:game_state_1[53]<=6'b100000;
						54:game_state_1[54]<=6'b100010;/* */
						55:game_state_1[55]<=6'b100000;
						56:game_state_1[56]<=6'b100010;/* */
						57:game_state_1[57]<=6'b100000;
						58:game_state_1[58]<=6'b100010;/* */
						59:game_state_1[59]<=6'b100000;
						60:game_state_1[60]<=6'b100010;/* */
						61:game_state_1[61]<=6'b100000;
						62:game_state_1[62]<=6'b100010;/* */
						63:game_state_1[63]<=6'b100000;
						64:game_state_1[64]<=6'b100010;/* */
						65:game_state_1[65]<=6'b100000;
						66:game_state_1[66]<=6'b100010;/* */
						67:game_state_1[67]<=6'b100000;
					endcase
					
				end
				for (i=0; i<4; i=i+1) begin
					case(i)
						0:game_state_2[0]<=6'b000000;/*noliek kursoru ekrana sakuma*/
						1:game_state_2[1]<=6'b000010;
						2:game_state_2[2]<=6'b100011;/*2*/
						3:game_state_2[3]<=6'b100010;
					endcase
				end
				for (i=0; i<4; i=i+1) begin
					case(i)
						0:game_state_3[0]<=6'b000000;/*noliek kursoru ekrana sakuma*/
						1:game_state_3[1]<=6'b000010;
						2:game_state_3[2]<=6'b100011;/*3*/
						3:game_state_3[3]<=6'b100011;
					endcase
				end
				for (i=0; i<4; i=i+1) begin
					case(i)
						0:game_state_4[0]<=6'b000000;/*noliek kursoru ekrana sakuma*/
						1:game_state_4[1]<=6'b000010;
						2:game_state_4[2]<=6'b100011;/*4*/
						3:game_state_4[3]<=6'b100100;
					endcase
				end
				init_game_states<=0;
	 end
	 always@(posedge clk) begin
		if (gatavs==1 && read_next_nibbles==0 && init_game_states==0 && game_state_changed)
		begin
			case(game_state)
				0: begin
						if(game_state_index<68)
						begin
						 next_upper_nibble <= game_state_1[game_state_index];
						 next_lower_nibble <= game_state_1[game_state_index + 1];
						 game_state_index <= game_state_index + 2;
						 read_next_nibbles <= 1;
						 $display("nibbles_size=%d,upper=%b , lower %b", nibbles_size, next_upper_nibble, next_lower_nibble);
						end
					end
				1: begin
						if(game_state_index<4)
						begin
						 next_upper_nibble <= game_state_2[game_state_index];
						 next_lower_nibble <= game_state_2[game_state_index + 1];
						 game_state_index <= game_state_index + 2;
						 read_next_nibbles <= 1;
						end
					end
				2:	begin
					if(game_state_index<4)
						begin
						 next_upper_nibble <= game_state_3[game_state_index];
						 next_lower_nibble <= game_state_3[game_state_index + 1];
						 game_state_index <= game_state_index + 2;
						 read_next_nibbles <= 1;
						end
				end
				3: begin
					if(game_state_index<4)
						begin
						 next_upper_nibble <= game_state_4[game_state_index];
						 next_lower_nibble <= game_state_4[game_state_index + 1];
						 game_state_index <= game_state_index + 2;
						 read_next_nibbles <= 1;
						end
				end
				endcase
		end
		else
		begin
			read_next_nibbles<=0;
		end
	 end
	 always @(posedge clk) begin
		if(reset_timer) begin
			flag_1 <= 0;
			flag_2 <= 0;
			flag_12 <= 0;
			flag_50 <= 0;
			flag_2k <= 0;
			flag_5k <= 0;
			flag_82k <= 0;
			flag_205k <= 0;
			flag_750k <= 0;
			clk_timer <= 0;
		end
		else begin
				if (clk_timer>=clk_1) begin
					flag_1 <= 1;
				end
				else begin
					flag_1 <= flag_1;
				end
				if (clk_timer>=clk_2) begin
					flag_2 <= 1;
				end
				else begin
					flag_2 <= flag_2;
				end
				if (clk_timer>=clk_12) begin
					flag_12 <= 1;
				end
				else begin
					flag_12 <= flag_12;
				end
				if (clk_timer>=clk_50) begin
					flag_50 <= 1;
				end
				else begin	
					flag_50<=flag_50;
				end
				if (clk_timer>=clk_2k) begin
					flag_2k <= 1;
				end
				else begin
					flag_2k <= flag_2k;
				end
				if (clk_timer>=clk_5k) begin
					flag_5k <= 1;
				end
				else begin 
					flag_5k <= flag_5k;
				end
				if (clk_timer>=clk_82k) begin
					flag_82k <= 1;
				end
				else begin
					flag_82k <= flag_82k;
				end
				if (clk_timer>=clk_205k) begin
					flag_205k <= 1;
				end
				else begin
					flag_205k <= flag_205k;
				end
				if (clk_timer>=clk_750k) begin
					flag_750k <= 1;
				end
				else begin
					flag_750k <= flag_750k;
				end
				clk_timer <= clk_timer + 1;
		end
	end
	reg [3:0] state=0;
	reg [3:0] substate=0;
	
	always @(posedge clk) begin
		sf_e<=1;
		$monitor("state=%d",state);
		$monitor("code=%b",code);
		case(state)
			0: begin //wait 750k cycles
			$display("starts");
					gatavs<=0;
					substate<=0;
					e<=0;
					rs<=0;
					rw<=0;
	
					if (!flag_750k) begin
						reset_timer <= 0;
						state <= state;
					end
					else begin
						state <= state+1;
						reset_timer <= 1;
					end
					$display("flag_750k=%d, clk_timer=%d, state=%d,reset_timer=%d",flag_750k,clk_timer,state,reset_timer);
			end
			1: begin 
					gatavs<=0;
					if(substate==0) begin
						$display("sutu kodu");
						e <=0;
						rs <=0;
						rw <=0;
						d <=0;
						c <=0;
						b<=1;
						a<=1;
						
						substate <= substate + 1;
					end
					if(substate==1) begin
						
						if(!flag_2) begin
						$display("sutu kodu");
							reset_timer <= 0;
							substate<=substate;
							state<=state;
						end
						else begin
						$display("sutu kodu");
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
					$display("e=1");
						e <= 1;
						substate<=substate+1;
					end
					if (substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate<=substate;
							state<=state;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							e<=0;
							substate <= 0;
							state <= state + 1;
							reset_timer <= 1;
						end
						else begin
							state <= state;
						   substate <= 0; 
							reset_timer <= 0;
						end
					end
			end
			2: begin
					if (!flag_205k) begin
						reset_timer <= 0;
						state <= state;
					end
					else begin
						state <= state + 1;
						reset_timer <= 1;
					end
			end
			3: begin 
					if(substate==0) begin
					$display("sutukodu2");
						gatavs<=0;
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000011 };
						substate<=substate+1;
					end
					if(substate==1) begin
						if(!flag_2) begin
							reset_timer <= 0;
							substate <= substate;
							state <= state;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
						e <= 1;
						substate<=substate+1;
					end
					if(substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							state <= state;
							substate <= substate;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							substate<=substate+1;
							state <= state;
							reset_timer <= 1;
						end
						else begin
							state <= state;
							substate<=substate;
							reset_timer <= 0;
						end
					end 
					if (substate==5) begin
						e<=0;
						substate <= 0;
						state <= state+1;
					end
			end
			4: begin
					gatavs <= 0;
					if (!flag_5k) begin
						state <= state;
						reset_timer <= 0;
					end
					else begin
						state <= state + 1;
						reset_timer <= 1;
					end
			end
			5:begin 
					if(substate==0) begin
						gatavs<=0;
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000011 };
						substate<=substate+1;
					end
					if(substate==1) begin
						if(!flag_2) begin
							reset_timer <= 0;
							substate <= substate;
							state <= state;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
						e <= 1;
						substate<=substate+1;
					end
					if(substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							state <= state;
							substate <= substate;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							substate<=substate+1;
							state <= state;
							reset_timer <= 1;
						end
						else begin
							state <= state;
							substate<=substate;
							reset_timer <= 0;
						end
					end 
					if (substate==5) begin
						e<=0;
						substate <= 0;
						state <= state+1;
					end
			end
			6: begin
					gatavs <= 0;
					if (!flag_2k) begin
						state <= state;
						substate <= substate;
						reset_timer <= 0;
					end
					else begin
						state <= state + 1;
						substate <= substate;
						reset_timer <= 1;
					end
			end
			7: begin 
					if(substate==0) begin
					   gatavs<=0;
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000010 };
						substate <= substate +1;
					end
					if(substate==1) begin
						if(!flag_2) begin
							substate <= substate;
							state <= state;
							reset_timer <= 0;
						end
						else begin
							substate <= substate + 1;
							state <= state;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
						e <= 1;
						substate <= substate +1;
					end
					if(substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							state <= state;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							state <= state;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							substate<=substate+1;
							state <= state;
							reset_timer <= 1;
						end
						else begin
							state <= state;
							substate<=substate;
							reset_timer <= 0;
						end
					end 
					if (substate==5) begin
						e<=0;
						substate <= 0;
						state <= state+1;
					end
			end
			8: begin
					gatavs <= 0;
					if (!flag_2k) begin
						reset_timer <= 0;
						state<= state;
					end
					else begin
						state <= state + 1;
						reset_timer <= 1;
					end
			end
			9: begin 
					$display("case 9, substate=%d",substate);
					gatavs<=0;
					if(substate==0) begin
					$display("sutu function set1");
						 //Function set, upper nibble 0010
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000010 };
						substate<= substate+1;
					end
					if(substate==1)begin
						if(!flag_2) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate<= substate;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if(substate==5) begin
						e<=0;
						substate <= substate + 1;
					end
					if (substate==6) begin
						if (!flag_50) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate<=substate+1;
							reset_timer <= 1;
						end
					end
					if (substate==7) begin
					$display("sutu function set2");
						//Function set, lower nibble 1000
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b001000 };
						substate<=substate+1;
					end
					if (substate==8) begin
						if(!flag_2) begin
							substate <= substate;
							reset_timer <= 0;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==9) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==10) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end
					if (substate==11) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if (substate==12) begin
						e<=0;
						substate <= substate +1;
					end
					if (substate==13) begin
						if (!flag_2k) begin
							reset_timer <= 0;
							substate <= substate;
							state <= state;
						end
						else begin
							state <= state + 1;
							substate <= 0;
							reset_timer <= 1;
							$monitor("end of 9, state=%d",state);
						end
					end
			end
			10: begin 
					gatavs<=0;
					if(substate==0) begin
					$display("sutu entry mode set");
					   //Entry mode set, upper nibble 0000
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000000 };
						substate<= substate+1;
					end
					if(substate==1)begin
						if(!flag_2) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate<= substate;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if(substate==5) begin
						e<=0;
						substate <= substate + 1;
					end
					if (substate==6) begin
						if (!flag_50) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate<=substate+1;
							reset_timer <= 1;
						end
					end
					if (substate==7) begin
					$display("sutu entry mode set2");
						//Entry mode set, lower nibble 0110;
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000110 };
						substate<=substate+1;
					end
					if (substate==8) begin
						if(!flag_2) begin
							substate <= substate;
							reset_timer <= 0;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==9) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==10) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end
					if (substate==11) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if (substate==12) begin
						e<=0;
						substate <= substate +1 ;
					end
					if (substate==13) begin
						if (!flag_2k) begin
							reset_timer <= 0;
							substate <= substate;
							state <= state;
						end
						else begin
							state <= state + 1;
							substate <= 0;
							reset_timer <= 1;
						end
					end
			end
			11: begin 
					gatavs<=0;
					if(substate==0) begin
					$display("sutu dispaly on");
						//Display on, upper nibble 0000
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000000};
						substate<= substate+1;
					end
					if(substate==1)begin
						if(!flag_2) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate<= substate;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if(substate==5) begin
						e<=0;
						substate <= substate + 1;
					end
					if (substate==6) begin
						if (!flag_50) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate<=substate+1;
							reset_timer <= 1;
						end
					end
					if (substate==7) begin
					$display("sutu dispaly on");
						//Display on, upper nibble 1100
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b001100 };
						substate<=substate+1;
					end
					if (substate==8) begin
						if(!flag_2) begin
							substate <= substate;
							reset_timer <= 0;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==9) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==10) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end
					if (substate==11) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if (substate==12) begin
						e<=0;
						substate <= substate +1 ;
					end
					if (substate==13) begin
						if (!flag_2k) begin
							reset_timer <= 0;
							substate <= substate;
							state <= state;
						end
						else begin
							state <= state + 1;
							substate <= 0;
							reset_timer <= 1;
						end
					end
			end
			12: begin 
					gatavs<=0;
					if(substate==0) begin
					$display("sutu clean display");
						//Clean Display, upper nibble 0000
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000000 };
						substate<= substate+1;
					end
					if(substate==1)begin
						if(!flag_2) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate<= substate;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if(substate==5) begin
						e<=0;
						substate <= substate + 1;
					end
					if (substate==6) begin
						if (!flag_50) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate<=substate+1;
							reset_timer <= 1;
						end
					end
					if (substate==7) begin
					$display("sutu clean display2");
						//Clean display, lower nibble 0001
						{ e, rs, rw, d, c, b, a } <= { 0, 6'b000001 };
						substate<=substate+1;
					end
					if (substate==8) begin
						if(!flag_2) begin
							substate <= substate;
							reset_timer <= 0;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==9) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==10) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end
					if (substate==11) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if (substate==12) begin
						e<=0;
						substate <= substate +1 ;
					end
					if (substate==13) begin
						if (!flag_82k) begin
							reset_timer <= 0;
							substate <= substate;
							state <= state;
						end
						else begin
							state <= 15;
							substate <= 0;
							reset_timer <= 1;
						end
					end
			end
			13: begin 
			$display("case 13, substate=%d",substate);
					gatavs<=0;
					if(substate==0) begin
					$display("sutu jaunus datus1");
						$display("befure upper:upper=%b , lower %b, code=%b", next_upper_nibble, next_lower_nibble, code);
						$display("after lower before output:upper=%b , lower=%b, code=%b", next_upper_nibble, next_lower_nibble, code);
						{ e, rs, rw, d, c, b, a } <= { 0, next_upper_nibble };//next upper nibble 
						$display("after upper:upper=%b , lower %b, code=%b", next_upper_nibble, next_lower_nibble,code);
						substate<= substate+1;
					end
					if(substate==1)begin
						if(!flag_2) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==2) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==3) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate<= substate;
							reset_timer <= 0;
						end
					end
					if (substate==4) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if(substate==5) begin
						e<=0;
						substate <= substate + 1;
					end
					if (substate==6) begin
						if (!flag_50) begin
							reset_timer <= 0;
							substate <= substate;
						end
						else begin
							substate<=substate+1;
							reset_timer <= 1;
						end
					end
					if (substate==7) begin
					$display("sutu jaunus datus2");
					$display("befure lower:upper=%b , lower %b, code=%b", next_upper_nibble, next_lower_nibble,code);
						$display("after lower before output:upper=%b , lower=%b, code=%b", next_upper_nibble, next_lower_nibble,code);
						{ e, rs, rw, d, c, b, a } <= { 0, next_lower_nibble };//next lower nibble;
						$display("after lower:upper=%b , lower=%b, code=%b", next_upper_nibble, next_lower_nibble,code);
						substate<=substate+1;
					end
					if (substate==8) begin
						if(!flag_2) begin
							substate <= substate;
							reset_timer <= 0;
						end
						else begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
					end
					if(substate==9) begin
						e <= 1;
						substate <= substate + 1;
					end
					if(substate==10) begin
						if(flag_12)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end
					if (substate==11) begin
						if(flag_1)begin
							substate <= substate + 1;
							reset_timer <= 1;
						end
						else begin
							substate <= substate;
							reset_timer <= 0;
						end
					end 
					if (substate==12) begin
						e<=0;
						substate <= substate +1 ;
					end
					if (substate==13) begin
						if (!flag_2k) begin
							reset_timer <= 0;
							substate <= substate;
							state <= state;
						end
						else begin
							state <= 15;
							substate <= 0;
							reset_timer <= 1;
						end
					end
			end
			default: begin //Idle
			$display("esmu idle");
				if (read_next_nibbles==1)begin
					state<=13;
					gatavs<=0;
				end
				else
				begin
					gatavs<=1;
				end
			end
		endcase
	end
endmodule
