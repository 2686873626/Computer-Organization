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
// Create Date:    16:08:03 11/17/2019 
// Design Name: 
// Module Name:    STALL_module 
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
module STALL_module(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
	 input [1:0] Tuse_rs,
	 input [1:0] Tuse_rt,
	 input [1:0] Tnew_E,
	 input [4:0] A3_E,
	 input [1:0] Tnew_M,
	 input [4:0] A3_M,
	 input isMD,
	 input Busy,
    output PC_WE,
    output IF_ID_WE,
    output ID_EX_clr
    );
	 
	wire stall,stall_1,stall_2,stall_3,stall_4,stall_5;
	assign PC_WE = !stall,
			 IF_ID_WE = !stall,
			 ID_EX_clr = stall;
	
	assign stall_1 = (IR_D[`rs] == A3_E) & (Tuse_rs < Tnew_E) & (IR_D[`rs] != 0),
		    stall_2 = (IR_D[`rt] == A3_E) & (Tuse_rt < Tnew_E) & (IR_D[`rt] != 0),
			 stall_3 = (IR_D[`rs] == A3_M) & (Tuse_rs < Tnew_M) & (IR_D[`rs] != 0),
			 stall_4 = (IR_D[`rt] == A3_M) & (Tuse_rt < Tnew_M) & (IR_D[`rt] != 0),
			 stall_5 = Busy & isMD,
			 stall = stall_1 | stall_2 | stall_3 | stall_4 | stall_5;
	
endmodule

