`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:35 11/17/2019 
// Design Name: 
// Module Name:    MEM_WB_module 
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
module MEM_WB_module(
    input [31:0] Instr,
	 input [4:0] A3,
	 input [1:0] Tnew,
	 input [31:0] PC4_M,
	 input [31:0] WD,
	 input clk,
	 input reset,
    output [31:0] Instr_W,
	 output [4:0] A3_FWD_W,
	 output [1:0] Tnew_FWD_W,
	 output [31:0] WD_FWD_W,
	 output [31:0] PC4_W
    );
	
	reg [31:0] Instr_W_Reg,WD_W_Reg,PC4_W_Reg;
	reg [4:0] A3_W_Reg;
	reg [1:0] Tnew_W_Reg;
	
	initial begin
		Instr_W_Reg = 0;
		A3_W_Reg = 0;
		Tnew_W_Reg = 0;
		WD_W_Reg = 0;
		PC4_W_Reg = 0;
	end
	
	assign Instr_W = Instr_W_Reg,
			 A3_FWD_W = A3_W_Reg,
			 Tnew_FWD_W = (Tnew_W_Reg==0)?2'b0:(Tnew_W_Reg-2'b1),
			 PC4_W = PC4_W_Reg,
			 WD_FWD_W = WD_W_Reg;
			 
	always @(posedge clk)begin
		if(reset == 1)begin
			Instr_W_Reg = 0; 
			A3_W_Reg = 0;
			Tnew_W_Reg = 0;
			WD_W_Reg = 0;
			PC4_W_Reg = 0;
		end
		else begin
			Instr_W_Reg = Instr;
			A3_W_Reg = A3;
			Tnew_W_Reg = Tnew;
			WD_W_Reg = WD;
			PC4_W_Reg = PC4_M;
		end
	end
		
endmodule
