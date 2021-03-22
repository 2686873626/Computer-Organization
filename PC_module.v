`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:04:46 11/17/2019 
// Design Name: 
// Module Name:    PC_module 
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
module PC_module(
    input [31:0] nextPC,
    input clk,
    input reset,
	 input WE,
	 input rupt,
    output [31:0] PC
    );
	
	reg [31:0] PC_Reg;
	assign PC = PC_Reg;
	
	initial begin
		PC_Reg = 32'h00003000;
	end
	
	always @(posedge clk)begin
		if(reset == 1)begin
			PC_Reg = 32'h00003000;
		end
		else if(rupt == 1)begin
			PC_Reg = 32'h0000_4180;
		end
		else if(WE == 1)begin
			PC_Reg = nextPC;
		end
	end

endmodule
