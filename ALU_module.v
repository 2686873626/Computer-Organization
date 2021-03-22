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
// Create Date:    00:15:47 11/17/2019 
// Design Name: 
// Module Name:    ALU_module 
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
module ALU_module(
    input [31:0] ALUsrc1,
    input [31:0] ALUsrc2,
    input [3:0] ALU_op,
    output reg [31:0] ALU_out
    );
	
	always @(*)begin
		case(ALU_op)
		0:begin
			ALU_out = ALUsrc1 + ALUsrc2;
		end
		1:begin
			ALU_out = ALUsrc1 - ALUsrc2;
		end
		2:begin
			ALU_out = ALUsrc1 | ALUsrc2;
		end
		3:begin
			ALU_out = ALUsrc1 & ALUsrc2;
		end
		4:begin
			ALU_out = ALUsrc1 ^ ALUsrc2;
		end
		5:begin
			ALU_out = ~(ALUsrc1 | ALUsrc2);
		end
		6:begin
			ALU_out = $signed(ALUsrc1)<$signed(ALUsrc2)?1:0;
		end
		7:begin
			ALU_out = ALUsrc1<ALUsrc2?1:0;
		end
		8:begin
			ALU_out = ALUsrc2 << ALUsrc1[4:0];
		end
		9:begin
			ALU_out = ALUsrc2 >> ALUsrc1[4:0];
		end
		10:begin
			ALU_out = $signed(ALUsrc2) >>> ALUsrc1[4:0];
		end
		endcase
	end
endmodule
