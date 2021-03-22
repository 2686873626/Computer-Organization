`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:51 11/17/2019 
// Design Name: 
// Module Name:    ID_EX_module 
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
module ID_EX_module(
    input [31:0] Instr,
    input [31:0] PC4,
    input [31:0] RS,
    input [31:0] RT,
    input [31:0] EXT,
	 input [4:0] A3,
	 input [1:0] Tnew,
	 input [4:0] ExcCode,
	 input isj,
	 input clk,
	 input reset,
	 input clr,
    output [31:0] Instr_E,
    output [31:0] PC4_E,
    output [31:0] RS_E,
    output [31:0] RT_E,
    output [31:0] EXT_E,
	 output [4:0] A3_FWD_E,
	 output [1:0] Tnew_FWD_E,
	 output reg [4:0] ExcCode_E,
	 output reg isj_E
    );
	
	reg [31:0] Instr_E_Reg, PC4_E_Reg, RS_E_Reg, RT_E_Reg, EXT_E_Reg;
	reg [4:0] A3_E_Reg;
	reg [1:0] Tnew_E_Reg;
	
	initial begin
		Instr_E_Reg = 0;
		PC4_E_Reg = 0;
		RS_E_Reg = 0;
		RT_E_Reg = 0;
		EXT_E_Reg = 0;
		Tnew_E_Reg = 0;
		A3_E_Reg = 0;
		isj_E = 0;
		ExcCode_E = 0;
	end
	
	assign Instr_E = Instr_E_Reg,
			 PC4_E = PC4_E_Reg,
			 RS_E = RS_E_Reg,
			 RT_E = RT_E_Reg,
			 EXT_E = EXT_E_Reg,
			 Tnew_FWD_E = (Tnew_E_Reg==0)?2'b0:(Tnew_E_Reg-2'b1),
			 A3_FWD_E = A3_E_Reg;
			 
	always @(posedge clk)begin
		if(reset == 1||clr == 1)begin
			Instr_E_Reg = 0;
			PC4_E_Reg = 0;
			RS_E_Reg = 0;
			RT_E_Reg = 0;
			EXT_E_Reg = 0;
			Tnew_E_Reg = 0;
			A3_E_Reg = 0;
		   ExcCode_E = 0;
			isj_E = 0;
		end
		else begin
			Instr_E_Reg = Instr;
			PC4_E_Reg = PC4;
			RS_E_Reg = RS;
			RT_E_Reg = RT;
			EXT_E_Reg = EXT;
			Tnew_E_Reg = Tnew;
			A3_E_Reg = A3;
		   ExcCode_E = ExcCode;
			isj_E = isj;
		end
	end
		
endmodule
