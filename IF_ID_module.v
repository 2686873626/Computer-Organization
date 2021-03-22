`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:11 11/17/2019 
// Design Name: 
// Module Name:    IF_ID_module 
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
module IF_ID_module(
    input [31:0] Instr,
    input [31:0] PC4,
	 input isj,
	 input clk,
	 input reset,
	 input WE,
	 input clr,
    output [31:0] Instr_D,
    output [31:0] PC4_D,
	 output reg [4:0] ExcCode,
	 output reg isj_D
    );
	
	reg [31:0] Instr_D_Reg,PC4_D_Reg;
	
	initial begin
		Instr_D_Reg = 0;
		PC4_D_Reg = 0;
		ExcCode   = 0;
		isj_D = 0;
	end
	
	assign PC4_D = PC4_D_Reg,
			 Instr_D = Instr_D_Reg;
			 
	always @(posedge clk)begin
		if(reset == 1 || clr == 1)begin
			Instr_D_Reg = 0;
			PC4_D_Reg = 0;
			ExcCode   = 0;
			isj_D = 0;
		end
		else if(WE == 1)begin
			PC4_D_Reg = PC4;
			isj_D = isj;
			if(PC4[1:0] != 2'b00)begin
				ExcCode   = 4;
				Instr_D_Reg = 0;
			end
			else if(!(PC4>=32'h0000_3004&&PC4<=32'h0000_5000))begin
				ExcCode   = 4;
				Instr_D_Reg = 0;
			end
			else begin
				ExcCode   = 0;
				Instr_D_Reg = Instr;
			end
		end
	end
		
endmodule

