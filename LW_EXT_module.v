`timescale 1ns / 1ps
`define op 31:26
`define func 5:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:05 11/23/2019 
// Design Name: 
// Module Name:    LW_EXT_module 
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
module LW_EXT_module(
    input [31:0] DMout1,
    input [31:0] Instr_M,
	 input [31:0] ALUout,
    output reg [31:0] DMout2
    );
	 
	parameter lb     = 6'b100000,
				 lbu	  = 6'b100100,
				 lh     = 6'b100001,
				 lhu    = 6'b100101,
				 lw     = 6'b100011;
	
	always @(*)begin
		case(Instr_M[`op])
		lb:begin
			if(ALUout[1:0] == 2'b00)begin
				DMout2 = {{24{DMout1[7]}},DMout1[7:0]};
			end
			else if(ALUout[1:0] == 2'b01)begin
				DMout2 = {{24{DMout1[15]}},DMout1[15:8]};
			end
			else if(ALUout[1:0] == 2'b10)begin
				DMout2 = {{24{DMout1[23]}},DMout1[23:16]};
			end
			else if(ALUout[1:0] == 2'b11)begin
				DMout2 = {{24{DMout1[31]}},DMout1[31:24]};
			end
		end
		lbu:begin
			if(ALUout[1:0] == 2'b00)begin
				DMout2 = {24'b0,DMout1[7:0]};
			end
			else if(ALUout[1:0] == 2'b01)begin
				DMout2 = {24'b0,DMout1[15:8]};
			end
			else if(ALUout[1:0] == 2'b10)begin
				DMout2 = {24'b0,DMout1[23:16]};
			end
			else if(ALUout[1:0] == 2'b11)begin
				DMout2 = {24'b0,DMout1[31:24]};
			end
		end
		lh:begin
			if(ALUout[1] == 0)begin
				DMout2 = {{16{DMout1[15]}},DMout1[15:0]};
			end
			else if(ALUout[1] == 1)begin
				DMout2 = {{16{DMout1[31]}},DMout1[31:16]};
			end
		end
		lhu:begin
			if(ALUout[1] == 0)begin
				DMout2 = {16'b0,DMout1[15:0]};
			end
			else if(ALUout[1] == 1)begin
				DMout2 = {16'b0,DMout1[31:16]};
			end
		end
		lw:begin
			DMout2 = DMout1;
		end
		endcase
	end

endmodule
