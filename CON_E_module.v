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
// Create Date:    16:14:30 11/20/2019 
// Design Name: 
// Module Name:    CON_E_module 
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
module CON_E_module(
	 input [31:0] instr,
	 input [32:0] tmp,
	 input [32:0] tmp2,
	 output reg [4:0] ExcCode,
    output ALUsrc_rs,
	 output reg ALUsrc_rt,
	 output start,
	 output [2:0] MD_op,
    output reg [3:0] ALU_op,
	 output [2:0] WD_E_sel,
	 output CP0_w,
	 output Eret
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
	
	assign ALUsrc_rs = (instr[`op]==r_op&&(instr[`func]==sll||instr[`func]==srl||instr[`func]==sra));
	assign WD_E_sel  = ((instr[`op]==r_op&&instr[`func]==jalr)||instr[`op]==jal)?1:
							 (instr[`op]==r_op&&instr[`func]==mfhi)?2:
							 (instr[`op]==r_op&&instr[`func]==mflo)?3:
							 (instr[`op]==COP0&&instr[`rs]==mfc0)?4:0;
	assign MD_op     = (instr[`op]==r_op&&instr[`func]==multu)?1:
							 (instr[`op]==r_op&&instr[`func]==divu)?2:
							 (instr[`op]==r_op&&instr[`func]==mult)?3:
							 (instr[`op]==r_op&&instr[`func]==div)?4:
							 (instr[`op]==r_op&&instr[`func]==mthi)?5:
							 (instr[`op]==r_op&&instr[`func]==mtlo)?6:0;
	assign start     = (MD_op==1||MD_op==2||MD_op==3||MD_op==4)?1:0;
	assign CP0_w     = (instr[`op]==COP0&&instr[`rs]==mtc0);
	assign Eret      = (instr[`op]==COP0&&instr[`func]==eret);
	
	always @(*)begin
		case(instr[`op])
		COP0:begin
			if(instr[`func] == eret)begin
				ALUsrc_rt = 0;
				ALU_op    = 0;
				ExcCode   = 0;
			end
			else if(instr[`rs] == mtc0)begin
				ALUsrc_rt = 0;
				ALU_op    = 0;
				ExcCode   = 0;
			end
			else if(instr[`rs] == mfc0)begin
				ALUsrc_rt = 0;
				ALU_op    = 0;
				ExcCode   = 0;
			end
			else begin
				ALUsrc_rt = 0;
				ALU_op    = 0;
				ExcCode   = 10;
			end
		end
		r_op:begin
			case(instr[`func])
				add:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					if(tmp[32]!=tmp[31])begin
						ExcCode = 12;
					end
					else begin
						ExcCode = 0;
					end
				end
				addu:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				sub:begin
					ALUsrc_rt = 0;
					ALU_op    = 1;
					if(tmp2[32]!=tmp2[31])begin
						ExcCode = 12;
					end
					else begin
						ExcCode = 0;
					end
				end
				subu:begin
					ALUsrc_rt = 0;
					ALU_op    = 1;
					ExcCode   = 0;
				end
				And:begin
					ALUsrc_rt = 0;
					ALU_op    = 3;
					ExcCode   = 0;
				end
				Or:begin
					ALUsrc_rt = 0;
					ALU_op    = 2;
					ExcCode   = 0;
				end
				Xor:begin
					ALUsrc_rt = 0;
					ALU_op    = 4;
					ExcCode   = 0;
				end
				Nor:begin
					ALUsrc_rt = 0;
					ALU_op    = 5;
					ExcCode   = 0;
				end
				slt:begin
					ALUsrc_rt = 0;
					ALU_op    = 6;
					ExcCode   = 0;
				end
				sltu:begin
					ALUsrc_rt = 0;
					ALU_op    = 7;
					ExcCode   = 0;
				end
				sll:begin
					ALUsrc_rt = 0;
					ALU_op    = 8;
					ExcCode   = 0;
				end
				srl:begin
					ALUsrc_rt = 0;
					ALU_op    = 9;
					ExcCode   = 0;
				end
				sra:begin
					ALUsrc_rt = 0;
					ALU_op    = 10;
					ExcCode   = 0;
				end
				sllv:begin
					ALUsrc_rt = 0;
					ALU_op    = 8;
					ExcCode   = 0;
				end
				srlv:begin
					ALUsrc_rt = 0;
					ALU_op    = 9;
					ExcCode   = 0;
				end
				srav:begin
					ALUsrc_rt = 0;
					ALU_op    = 10;
					ExcCode   = 0;
				end
				jr:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				jalr:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				mult:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				multu:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				div:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				divu:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				mfhi:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				mflo:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				mthi:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				mtlo:begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 0;
				end
				default begin
					ALUsrc_rt = 0;
					ALU_op    = 0;
					ExcCode   = 10;
				end
			endcase
		end
		addi:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[32]!=tmp[31])begin
				ExcCode = 12;
			end
			else begin
				ExcCode = 0;
			end
		end
		addiu:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			ExcCode   = 0;
		end
		andi:begin
			ALUsrc_rt = 1;
			ALU_op    = 3;
			ExcCode   = 0;
		end
		xori:begin
			ALUsrc_rt = 1;
			ALU_op    = 4;
			ExcCode   = 0;
		end
		ori:begin
			ALUsrc_rt = 1;
			ALU_op    = 2;
			ExcCode   = 0;
		end
		lui:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			ExcCode   = 0;
		end
		slti:begin
			ALUsrc_rt = 1;
			ALU_op    = 6;
			ExcCode   = 0;
		end
		sltiu:begin
			ALUsrc_rt = 1;
			ALU_op    = 7;
			ExcCode   = 0;
		end
		lb:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[31]!=tmp[32])begin
				ExcCode = 4;
			end
			else if(!(tmp[31:0]>=32'h0000_0000&&tmp[31:0]<=32'h0000_2fff))begin
				ExcCode = 4;
			end
			else begin
				ExcCode = 0;
			end
		end
		lbu:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[31]!=tmp[32])begin
				ExcCode = 4;
			end
			else if(!(tmp[31:0]>=32'h0000_0000&&tmp[31:0]<=32'h0000_2fff))begin
				ExcCode = 4;
			end
			else begin
				ExcCode = 0;
			end
		end
		lh:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[31]!=tmp[32])begin
				ExcCode = 4;
			end
			else if(tmp[0]!=1'b0)begin
				ExcCode = 4;
			end
			else if(!(tmp[31:0]>=32'h0000_0000&&tmp[31:0]<=32'h0000_2fff))begin
				ExcCode = 4;
			end
			else begin
				ExcCode = 0;
			end
		end
		lhu:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[31]!=tmp[32])begin
				ExcCode = 4;
			end
			else if(tmp[0]!=1'b0)begin
				ExcCode = 4;
			end
			else if(!(tmp[31:0]>=32'h0000_0000&&tmp[31:0]<=32'h0000_2fff))begin
				ExcCode = 4;
			end
			else begin
				ExcCode = 0;
			end
		end
		lw:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[31]!=tmp[32])begin
				ExcCode = 4;
			end
			else if(tmp[1:0]!=2'b00)begin
				ExcCode = 4;
			end
			else if(!((tmp[31:0]>=32'h0000_0000&&tmp[31:0]<=32'h0000_2fff)||(tmp[31:0]>=32'h0000_7f00&&tmp[31:0]<=32'h0000_7f0b)||(tmp[31:0]>=32'h0000_7f10&&tmp[31:0]<=32'h0000_7f1b)))begin
				ExcCode = 4;
			end
			else begin
				ExcCode = 0;
			end
		end
		sb:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[31]!=tmp[32])begin
				ExcCode = 5;
			end
			else if(!(tmp[31:0]>=32'h0000_0000&&tmp[31:0]<=32'h0000_2fff))begin
				ExcCode = 5;
			end
			else begin
				ExcCode = 0;
			end
		end
		sh:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[31]!=tmp[32])begin
				ExcCode = 5;
			end
			else if(tmp[0]!=1'b0)begin
				ExcCode = 5;
			end
			else if(!(tmp[31:0]>=32'h0000_0000&&tmp[31:0]<=32'h0000_2fff))begin
				ExcCode = 5;
			end
			else begin
				ExcCode = 0;
			end
		end
		sw:begin
			ALUsrc_rt = 1;
			ALU_op    = 0;
			if(tmp[31]!=tmp[32])begin
				ExcCode = 5;
			end
			else if(tmp[1:0]!=2'b00)begin
				ExcCode = 5;
			end
			else if(!((tmp[31:0]>=32'h0000_0000&&tmp[31:0]<=32'h0000_2fff)||(tmp[31:0]>=32'h0000_7f00&&tmp[31:0]<=32'h0000_7f07)||(tmp[31:0]>=32'h0000_7f10&&tmp[31:0]<=32'h0000_7f17)))begin
				ExcCode = 5;
			end
			else begin
				ExcCode = 0;
			end
		end
		beq:begin
			ALUsrc_rt = 0;
			ALU_op    = 0;
			ExcCode   = 0;
		end
		bne:begin
			ALUsrc_rt = 0;
			ALU_op    = 0;
			ExcCode   = 0;
		end
		blez:begin
			ALUsrc_rt = 0;
			ALU_op    = 0;
			ExcCode   = 0;
		end
		bgtz:begin
			ALUsrc_rt = 0;
			ALU_op    = 0;
			ExcCode   = 0;
		end
		bltz_bgez:begin
			if(instr[`rt]==bltz||instr[`rt]==bgez)begin
				ALUsrc_rt = 0;
				ALU_op    = 0;
				ExcCode   = 0;
			end
			else begin
				ALUsrc_rt = 0;
				ALU_op    = 0;
				ExcCode   = 10;
			end
		end
		jal:begin
			ALUsrc_rt = 0;
			ALU_op    = 0;
			ExcCode   = 0;
		end
		j:begin
			ALUsrc_rt = 0;
			ALU_op    = 0;
			ExcCode   = 0;
		end
		default begin
			ALUsrc_rt = 0;
			ALU_op    = 0;
			ExcCode   = 10;
		end
		endcase
	end
endmodule
