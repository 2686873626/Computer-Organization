`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:55:23 11/17/2019 
// Design Name: 
// Module Name:    NPC_module 
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
module NPC_module(
	 input [31:0] PC,
    input [25:0] imm26,
    input [2:0] PC_sel,
    output [31:0] NPC_out
    );

	assign NPC_out = (PC_sel==1)?(PC+{{14{imm26[15]}},imm26[15:0],2'b00}):{PC[31:28],imm26,2'b00};//branch = 1 -> beq,else j/jal

endmodule
