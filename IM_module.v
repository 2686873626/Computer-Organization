`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:09:19 11/17/2019 
// Design Name: 
// Module Name:    IM_module 
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
module IM_module(
    input [31:0] PC,
    output [31:0] Instr
    );
	
	reg [31:0] ROM [4095:0];
	wire [31:0] PC_IM;
	assign PC_IM = PC - 32'h00003000;
	integer i;
	
	initial begin
		for(i = 0; i < 4096; i = i + 1)begin
			ROM [i] = 0;
		end
		$readmemh("code.txt",ROM);
		$readmemh("code_handler.txt",ROM,1120,2047);
	end
	
	assign Instr = ROM [PC_IM[13:2]];

endmodule
