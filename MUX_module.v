`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:38 11/17/2019 
// Design Name: 
// Module Name:    MUXPC_module 
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
module MUX_PC_module(
    input [31:0] ADD4,
    input [31:0] NPC,
    input [31:0] jrPC,
    input [2:0] PC_sel,
    input CMP_out,
    output [31:0] nextPC
    );

	assign nextPC = (PC_sel == 3)?jrPC:
						 ((PC_sel == 2)||((PC_sel == 1)&&(CMP_out == 1)))?NPC:ADD4;
						 
endmodule

module MUX_ALU1_module(
	input [31:0] RS,
	input [31:0] Instr,
	input ALUsrc_rs,
	output [31:0] ALUsrc1
);
	
	assign ALUsrc1 = (ALUsrc_rs == 0)?RS:{27'b0,Instr[10:6]};

endmodule

module MUX_ALU2_module(
	input [31:0] RT,
	input [31:0] EXT_E,
	input ALUsrc_rt,
	output [31:0] ALUsrc2
);
	
	assign ALUsrc2 = (ALUsrc_rt == 0)?RT:EXT_E;

endmodule

module MUX_WD_M_module(
	input [31:0] PC4_E,
	input [31:0] ALUout,
	input [31:0] HI,
	input [31:0] LO,
	input [31:0] c0,
	input [2:0] WD_E_sel,
	output [31:0] WD_M
);
	
	assign WD_M = (WD_E_sel == 0)?ALUout:
					  (WD_E_sel == 1)?(PC4_E+4):
					  (WD_E_sel == 2)?HI:
					  (WD_E_sel == 3)?LO:c0;

endmodule

module MUX_WD_W_module(
	input [31:0] WD_M,
	input [31:0] DMout,
	input [1:0] WD_M_sel,
	output [31:0] WD_W
);
	
	assign WD_W = (WD_M_sel == 0)?WD_M:DMout;

endmodule

