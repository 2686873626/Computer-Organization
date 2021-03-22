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
// Create Date:    16:16:11 11/20/2019 
// Design Name: 
// Module Name:    CON_M_module 
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
module CON_M_module(
    input [31:0] instr,
	 output [1:0] WD_M_sel
    );

parameter r_op   = 6'b000000,
				 add    = 6'b100000,
				 addu   = 6'b100001,
				 sub    = 6'b100010,
				 subu   = 6'b100011,
				 And    = 6'b100100,
				 Or     = 6'b100101,
				 Xor    = 6'b100110,
				 Nor    = 6'b100111,
				 slt    = 6'b101010,
				 sltu   = 6'b101011,
				 sll    = 6'b000000,
				 srl    = 6'b000010,
				 sra    = 6'b000011,
				 sllv   = 6'b000100,
				 srlv   = 6'b000110,
				 srav   = 6'b000111,
				 jr     = 6'b001000,
				 jalr   = 6'b001001,
				 mult   = 6'b011000,
				 multu  = 6'b011001,
				 div    = 6'b011010,
				 divu   = 6'b011011,
				 mfhi   = 6'b010000,
				 mflo   = 6'b010010,
				 mthi   = 6'b010001,
				 mtlo   = 6'b010011,
				 
				 addi   = 6'b001000,
				 addiu  = 6'b001001,
				 andi   = 6'b001100,
				 ori    = 6'b001101,
				 xori   = 6'b001110,
				 lui    = 6'b001111,
				 slti   = 6'b001010,
				 sltiu  = 6'b001011,
				 lb     = 6'b100000,
				 lbu	  = 6'b100100,
				 lh     = 6'b100001,
				 lhu    = 6'b100101,
				 lw     = 6'b100011,
				 sb	  = 6'b101000,
				 sh     = 6'b101001,
				 sw     = 6'b101011,
				 beq    = 6'b000100,
				 bne    = 6'b000101,
				 blez   = 6'b000110,
				 bgtz   = 6'b000111,
				 bltz_bgez = 6'b000001,
				 jal    = 6'b000011,
				 COP0   = 6'b010000,
				 eret   = 6'b011000,
				 mtc0   = 5'b00100,
				 mfc0   = 5'b00000,
				 j      = 6'b000010;
	
	assign WD_M_sel = (instr[`op]==lb||instr[`op]==lbu||instr[`op]==lh||instr[`op]==lhu||instr[`op]==lw)?1:0;
	
endmodule
