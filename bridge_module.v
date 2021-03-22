`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:30 12/07/2019 
// Design Name: 
// Module Name:    bridge_module 
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
module bridge_module(
    input [31:0] CPU_A,
    input [31:0] CPU_out,
	 input PrWE,
	 output [31:0] Timer_A,
    output [31:0] CPU_in,
    output WE0,
    output WE1,
    output [31:0] Timer_in,
    input [31:0] Timer_out1,
    input [31:0] Timer_out2
    );
	
	assign Timer_in = CPU_out;
	assign Timer_A = CPU_A;
	assign WE0 = (CPU_A>=32'h0000_7F00&&CPU_A<=32'h0000_7F0B)&PrWE;
	assign WE1 = (CPU_A>=32'h0000_7F10&&CPU_A<=32'h0000_7F1B)&PrWE;
	assign CPU_in = (CPU_A>=32'h0000_7F00&&CPU_A<=32'h0000_7F0B)?Timer_out1:Timer_out2;

endmodule
