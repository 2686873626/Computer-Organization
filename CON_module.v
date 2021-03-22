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
// Create Date:    13:49:17 11/17/2019 
// Design Name: 
// Module Name:    CON_D_module 
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
module CON_D_module(
    input [31:0] instr,
    output reg [2:0] PC_sel,
    output reg [1:0] Ext_op,
	 output reg [1:0] Tuse_rs,
	 output reg [1:0] Tuse_rt,
	 output reg [1:0] Tnew,
	 output reg [4:0] A3,
	 output reg isMD,
	 output isj
    );

	parameter r_op   = 6'b000000,
				 add    = 6'b100000,
				 addu   = 6'b100001,
				 sub    = 6'b100010,
				 subu   = 6'b100011,
				 And    = 6'b100100,
				 Or     = 6'b100101,
				 Xor    = 6'b100110,
				 Nor    = 6'b100111,
				 slt    = 6'b101010,
				 sltu   = 6'b101011,
				 sll    = 6'b000000,
				 srl    = 6'b000010,
				 sra    = 6'b000011,
				 sllv   = 6'b000100,
				 srlv   = 6'b000110,
				 srav   = 6'b000111,
				 jr     = 6'b001000,
				 jalr   = 6'b001001,
				 mult   = 6'b011000,
				 multu  = 6'b011001,
				 div    = 6'b011010,
				 divu   = 6'b011011,
				 mfhi   = 6'b010000,
				 mflo   = 6'b010010,
				 mthi   = 6'b010001,
				 mtlo   = 6'b010011,
				 
				 addi   = 6'b001000,
				 addiu  = 6'b001001,
				 andi   = 6'b001100,
				 ori    = 6'b001101,
				 xori   = 6'b001110,
				 lui    = 6'b001111,
				 slti   = 6'b001010,
				 sltiu  = 6'b001011,
				 lb     = 6'b100000,
				 lbu	  = 6'b100100,
				 lh     = 6'b100001,
				 lhu    = 6'b100101,
				 lw     = 6'b100011,
				 sb	  = 6'b101000,
				 sh     = 6'b101001,
				 sw     = 6'b101011,
				 beq    = 6'b000100,
				 bne    = 6'b000101,
				 blez   = 6'b000110,
				 bgtz   = 6'b000111,
				 bltz_bgez = 6'b000001,
				 bltz = 5'b00000,
				 bgez = 5'b00001,
				 jal    = 6'b000011,
				 COP0   = 6'b010000,
				 eret   = 6'b011000,
				 mtc0   = 5'b00100,
				 mfc0   = 5'b00000,
				 j      = 6'b000010;
	
	assign isj = (instr[`op]==j || instr[`op]==jal || instr[`op]==bne || instr[`op]==beq || instr[`op]==blez || 
	              instr[`op]==bgtz|| (instr[`op]==bltz_bgez&&(instr[`rt]==bltz||instr[`rt]==bgez)) || (instr[`op]==r_op &&(instr[`func]==jr||instr[`func]==jalr)));
					  
	always @(*)begin
		case(instr[`op])
		COP0:begin
			if(instr[`func] == eret)begin
				PC_sel    = 4;
				Ext_op    = 0;
				Tuse_rs   = 3;
				Tuse_rt   = 3;
				Tnew      = 0;
				A3        = 0;
				isMD      = 0;
			end
			else if(instr[`rs] == mtc0)begin
				PC_sel    = 0;
				Ext_op    = 0;
				Tuse_rs   = 3;
				Tuse_rt   = 1;
				Tnew      = 2;
				A3        = 0;
				isMD      = 0;
			end
			else if(instr[`rs] == mfc0)begin
				PC_sel    = 0;
				Ext_op    = 0;
				Tuse_rs   = 3;
				Tuse_rt   = 3;
				Tnew      = 2;
				A3        = instr[`rt];
				isMD      = 0;
			end
			else begin
				PC_sel    = 0;
				Ext_op    = 0;
				Tuse_rs   = 3;
				Tuse_rt   = 3;
				Tnew      = 0;
				A3        = 0;
				isMD      = 0;
			end
		end
		r_op:begin
			case(instr[`func])
				add:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				addu:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				sub:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				subu:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				And:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				Or:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				Xor:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				Nor:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				slt:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				sltu:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				sll:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 3;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				srl:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 3;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				sra:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 3;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				sllv:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				srlv:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				srav:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 0;
				end
				jr:begin
					PC_sel    = 3;
					Ext_op    = 0;
					Tuse_rs   = 0;
					Tuse_rt   = 3;
					Tnew      = 0;
					A3        = 0;
					isMD      = 0;
				end
				jalr:begin
					PC_sel    = 3;
					Ext_op    = 0;
					Tuse_rs   = 0;
					Tuse_rt   = 3;
					Tnew      = 1;
					A3        = instr[`rd];
					isMD      = 0;
				end
				mult:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = 0;
					isMD      = 1;
				end
				multu:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = 0;
					isMD      = 1;
				end
				div:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = 0;
					isMD      = 1;
				end
				divu:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 1;
					Tnew      = 2;
					A3        = 0;
					isMD      = 1;
				end
				mfhi:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 3;
					Tuse_rt   = 3;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 1;
				end
				mflo:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 3;
					Tuse_rt   = 3;
					Tnew      = 2;
					A3        = instr[`rd];
					isMD      = 1;
				end
				mthi:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 3;
					Tnew      = 0;
					A3        = 0;
					isMD      = 1;
				end
				mtlo:begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 1;
					Tuse_rt   = 3;
					Tnew      = 0;
					A3        = 0;
					isMD      = 1;
				end
				default begin
					PC_sel    = 0;
					Ext_op    = 0;
					Tuse_rs   = 3;
					Tuse_rt   = 3;
					Tnew      = 0;
					A3        = 0;
					isMD      = 0;
				end
			endcase
		end
		addi:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 2;
			A3        = instr[`rt];
			isMD      = 0;
		end
		addiu:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 2;
			A3        = instr[`rt];
			isMD      = 0;
		end
		andi:begin
			PC_sel    = 0;
			Ext_op    = 0;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 2;
			A3        = instr[`rt];
			isMD      = 0;
		end
		xori:begin
			PC_sel    = 0;
			Ext_op    = 0;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 2;
			A3        = instr[`rt];
			isMD      = 0;
		end
		ori:begin
			PC_sel    = 0;
			Ext_op    = 0;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 2;
			A3        = instr[`rt];
			isMD      = 0;
		end
		lui:begin
			PC_sel    = 0;
			Ext_op    = 2;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 2;
			A3        = instr[`rt];
			isMD      = 0;
		end
		slti:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 2;
			A3        = instr[`rt];
			isMD      = 0;
		end
		sltiu:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 2;
			A3        = instr[`rt];
			isMD      = 0;
		end
		lb:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 3;
			A3        = instr[`rt];
			isMD      = 0;
		end
		lbu:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 3;
			A3        = instr[`rt];
			isMD      = 0;
		end
		lh:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 3;
			A3        = instr[`rt];
			isMD      = 0;
		end
		lhu:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 3;
			A3        = instr[`rt];
			isMD      = 0;
		end
		lw:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 3;
			Tnew      = 3;
			A3        = instr[`rt];
			isMD      = 0;
		end
		sb:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 2;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		sh:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 2;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		sw:begin
			PC_sel    = 0;
			Ext_op    = 1;
			Tuse_rs   = 1;
			Tuse_rt   = 2;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		beq:begin
			PC_sel    = 1;
			Ext_op    = 0;
			Tuse_rs   = 0;
			Tuse_rt   = 0;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		bne:begin
			PC_sel    = 1;
			Ext_op    = 0;
			Tuse_rs   = 0;
			Tuse_rt   = 0;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		blez:begin
			PC_sel    = 1;
			Ext_op    = 0;
			Tuse_rs   = 0;
			Tuse_rt   = 3;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		bgtz:begin
			PC_sel    = 1;
			Ext_op    = 0;
			Tuse_rs   = 0;
			Tuse_rt   = 3;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		bltz_bgez:begin
			if(instr[`rt]==bltz||instr[`rt]==bgez)begin
				PC_sel    = 1;
				Ext_op    = 0;
				Tuse_rs   = 0;
				Tuse_rt   = 3;
				Tnew      = 0;
				A3        = 0;
				isMD      = 0;
			end
			else begin
				PC_sel    = 0;
				Ext_op    = 0;
				Tuse_rs   = 3;
				Tuse_rt   = 3;
				Tnew      = 0;
				A3        = 0;
				isMD      = 0;
			end
		end
		jal:begin
			PC_sel    = 2;
			Ext_op    = 0;
			Tuse_rs   = 3;
			Tuse_rt   = 3;
			Tnew      = 1;
			A3        = 31;
			isMD      = 0;
		end
		j:begin
			PC_sel    = 2;
			Ext_op    = 0;
			Tuse_rs   = 3;
			Tuse_rt   = 3;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		default begin
			PC_sel    = 0;
			Ext_op    = 0;
			Tuse_rs   = 3;
			Tuse_rt   = 3;
			Tnew      = 0;
			A3        = 0;
			isMD      = 0;
		end
		endcase
	end
endmodule
