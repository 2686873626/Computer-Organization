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
// Create Date:    12:26:13 11/23/2019 
// Design Name: 
// Module Name:    BE_EXT 
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
module BE_EXT(
    input [31:0] instr_M,
	 input [31:0] ALU_out,
    output [3:0] BE
    );
	 
	parameter sw = 6'b101011,
				 sb = 6'b101000,
				 sh = 6'b101001;
	
	assign BE = (instr_M[`op]==sw)?4'b1111:
					(instr_M[`op]==sh&&ALU_out[1]==0)?4'b0011:
					(instr_M[`op]==sh&&ALU_out[1]==1)?4'b1100:
					(instr_M[`op]==sb&&ALU_out[1:0]==2'b00)?4'b0001:
					(instr_M[`op]==sb&&ALU_out[1:0]==2'b01)?4'b0010:
					(instr_M[`op]==sb&&ALU_out[1:0]==2'b10)?4'b0100:
					(instr_M[`op]==sb&&ALU_out[1:0]==2'b11)?4'b1000:4'b0000;

endmodule
