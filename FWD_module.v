`timescale 1ns / 1ps
`define op 31:26
`define func 5:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:17:31 11/17/2019 
// Design Name: 
// Module Name:    FWD_module 
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
module FWD_module(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
	 input [31:0] RD1,
	 input [31:0] RD2,
	 input [31:0] E_rs,
	 input [31:0] E_rt,
	 input [31:0] M_rt,
	 input [31:0] WD_W,
	 input [31:0] WD_M,
	 input [31:0] WD_E,
	 input [1:0] Tnew_E,
	 input [1:0] Tnew_M,
	 input [1:0] Tnew_W,
	 input [4:0] A3_E,
	 input [4:0] A3_M,
	 input [4:0] A3_W,
	 output [31:0] GRF_RD1,
	 output [31:0] GRF_RD2,
	 output [31:0] ALU_rs,
	 output [31:0] ALU_rt,
	 output [31:0] DM_rt
    );
	
	assign GRF_RD1 = ((IR_D[`rs] != 0) & (IR_D[`rs] == A3_E) & (Tnew_E == 0))?WD_E:
						  ((IR_D[`rs] != 0) & (IR_D[`rs] == A3_M) & (Tnew_M == 0))?WD_M:
						  ((IR_D[`rs] != 0) & (IR_D[`rs] == A3_W) & (Tnew_W == 0))?WD_W:RD1;
	assign GRF_RD2 = ((IR_D[`rt] != 0) & (IR_D[`rt] == A3_E) & (Tnew_E == 0))?WD_E:
						  ((IR_D[`rt] != 0) & (IR_D[`rt] == A3_M) & (Tnew_M == 0))?WD_M:
						  ((IR_D[`rt] != 0) & (IR_D[`rt] == A3_W) & (Tnew_W == 0))?WD_W:RD2;
	assign ALU_rs = ((IR_E[`rs] != 0) & (IR_E[`rs] == A3_M) & (Tnew_M == 0))?WD_M:
						 ((IR_E[`rs] != 0) & (IR_E[`rs] == A3_W) & (Tnew_W == 0))?WD_W:E_rs;
	assign ALU_rt = ((IR_E[`rt] != 0) & (IR_E[`rt] == A3_M) & (Tnew_M == 0))?WD_M:
						 ((IR_E[`rt] != 0) & (IR_E[`rt] == A3_W) & (Tnew_W == 0))?WD_W:E_rt;	
	assign DM_rt = ((IR_M[`rt] != 0) & (IR_M[`rt] == A3_W) & (Tnew_W == 0))?WD_W:M_rt;
							  
endmodule
