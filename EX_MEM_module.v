`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:07 11/17/2019 
// Design Name: 
// Module Name:    EX_MEM_module 
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
module EX_MEM_module(
    input [31:0] Instr,
    input [31:0] PC4,
    input [31:0] RT,
    input [31:0] ALUout,
	 input [4:0] A3,
	 input [1:0] Tnew,
	 input [31:0] WD,
	 input clk,
	 input reset,
	 input clr,
    output [31:0] Instr_M,
    output [31:0] PC4_M,
    output [31:0] RT_M,
    output [31:0] ALUout_M,
	 output [4:0] A3_FWD_M,
	 output [1:0] Tnew_FWD_M,
	 output [31:0] WD_FWD_M
    );
	
	reg [31:0] Instr_M_Reg,PC4_M_Reg,RT_M_Reg,ALUout_M_Reg,WD_M_Reg;
	reg [4:0] A3_M_Reg;
	reg [1:0] Tnew_M_Reg;
	
	initial begin
		Instr_M_Reg = 0;
		PC4_M_Reg = 0;
		RT_M_Reg = 0;
		ALUout_M_Reg = 0;
		A3_M_Reg = 0;
		Tnew_M_Reg = 0;
		WD_M_Reg = 0;
	end
	
	assign Instr_M = Instr_M_Reg,
			 PC4_M = PC4_M_Reg,
			 RT_M = RT_M_Reg,
			 ALUout_M = ALUout_M_Reg,
			 A3_FWD_M = A3_M_Reg,
			 Tnew_FWD_M = (Tnew_M_Reg==0)?2'b0:(Tnew_M_Reg-2'b1),
			 WD_FWD_M = WD_M_Reg;
			 
	always @(posedge clk)begin
		if(reset == 1 || clr == 1)begin
			Instr_M_Reg = 0;
			PC4_M_Reg = 0;
			RT_M_Reg = 0;
			ALUout_M_Reg = 0;
			A3_M_Reg = 0;
			Tnew_M_Reg = 0;
			WD_M_Reg = 0;
		end
		else begin
			Instr_M_Reg = Instr;
			PC4_M_Reg = PC4;
			RT_M_Reg = RT;
			ALUout_M_Reg = ALUout;
			A3_M_Reg = A3;
			Tnew_M_Reg = Tnew;
			WD_M_Reg = WD;
		end
	end
		
endmodule
