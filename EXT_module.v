`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:57:32 11/16/2019 
// Design Name: 
// Module Name:    EXT_module 
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
module EXT_module(
    input [15:0] imm,
    input [1:0] Ext_op,
    output [31:0] signimm
    );

	assign signimm = (Ext_op == 0)?{16'b0,imm}:
						  (Ext_op == 1)?{{16{imm[15]}},imm}:{imm,16'b0};
						  
endmodule
