`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:52 11/23/2019 
// Design Name: 
// Module Name:    ADD4_module 
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
module ADD4_module(
    input [31:0] PC,
    output [31:0] ADD4_out
    );

	assign ADD4_out = PC + 4;
	
endmodule
