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
// Create Date:    00:18:50 11/17/2019 
// Design Name: 
// Module Name:    CMP_module 
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
module CMP_module(
	 input [31:0] Instr_D,
    input [31:0] RD1,
    input [31:0] RD2,
    output CMP_out
    );
	
	parameter beq  = 6'b000100,
				 bne  = 6'b000101,
				 b_   = 6'b000001,
				 bgtz = 6'b000111,
				 blez = 6'b000110,
				 bltz = 5'b00000,
				 bgez = 5'b00001;
				 
	assign CMP_out = (Instr_D[`op]==beq && RD1==RD2)|
						  (Instr_D[`op]==bne && RD1!=RD2)|
						  (Instr_D[`op]==bgtz && $signed(RD1)>0)|
						  (Instr_D[`op]==blez && $signed(RD1)<=0)|
						  (Instr_D[`op]==b_ && Instr_D[20:16]==bltz && $signed(RD1)<0)|
						  (Instr_D[`op]==b_ && Instr_D[20:16]==bgez && $signed(RD1)>=0);

endmodule
