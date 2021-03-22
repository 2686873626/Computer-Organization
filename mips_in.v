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
// Create Date:    18:53:31 11/20/2019 
// Design Name: 
// Module Name:    mips 
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
module mips_in(
    input reset,
    input clk,
	 output [31:0] PrAddr,
	 input [31:0] PrRD,
	 output [31:0] PrWD,
	 output PrWE,
	 output [31:0] PC_CPU,
	 input [5:0] HWInt
    );
	 
	wire [31:0] nextPC, PC, ADD4, NPC_out, Instr, GRF_RD1, GRF_RD2, MUX_PC_out, Epc;
	wire [2:0] PC_sel;
	wire PC_WE,IF_ID_WE,ID_EX_clr,CMP_out,Eret,rupt;
	assign PC_CPU = PC_CP0 - 4;
	
	PC_module PC_Reg (
    .nextPC(nextPC), 
    .clk(clk), 
    .reset(reset), 
	 .rupt(rupt),
    .WE(PC_WE|Eret), 
    .PC(PC)
    );
	 
	ADD4_module ADD4_reg (
    .PC(PC), 
    .ADD4_out(ADD4)
    );
	
	assign nextPC = (Eret==1)?Epc:MUX_PC_out;
	
	MUX_PC_module MUX_PC (
    .ADD4(ADD4), 
    .NPC(NPC_out), 
    .jrPC(GRF_RD1),
    .PC_sel(PC_sel), 
    .CMP_out(CMP_out), 
    .nextPC(MUX_PC_out)
    );
	 
	IM_module IM (
    .PC(PC), 
    .Instr(Instr)
    );

	//IF/ID
	wire [31:0] Instr_D,PC4_D;
	wire [4:0] ExcCode_D;
	wire clr_D;
	assign clr_D = Eret | rupt;
	
	IF_ID_module IF_ID (
	 .isj(ISJ),
    .Instr(Instr), 
    .PC4(ADD4), 
    .clk(clk), 
    .reset(reset), 
	 .clr(clr_D),
    .WE(IF_ID_WE), 
    .Instr_D(Instr_D), 
    .PC4_D(PC4_D),
	 .ExcCode(ExcCode_D),
	 .isj_D(isj_D)
    );
	 
	//STALL
	wire [31:0] Instr_E,Instr_M;
	wire [1:0] Tuse_rs,Tuse_rt,Tnew_FWD_E,Tnew_FWD_M,Tnew_FWD_W;
	wire [4:0] A3_FWD_E,A3_FWD_M;
	wire isMD_D,Busy,start,busy_ST;
	
	assign busy_ST = start | Busy;
	
	STALL_module STALL (
    .IR_D(Instr_D), 
    .IR_E(Instr_E), 
    .IR_M(Instr_M), 
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt), 
    .Tnew_E(Tnew_FWD_E), 
    .A3_E(A3_FWD_E), 
    .Tnew_M(Tnew_FWD_M), 
    .A3_M(A3_FWD_M),
	 .isMD(isMD_D),
	 .Busy(busy_ST),
    .PC_WE(PC_WE), 
    .IF_ID_WE(IF_ID_WE), 
    .ID_EX_clr(ID_EX_clr)
    );
	 
	//FWD
	wire [31:0] RD1, RD2, RS_E,RT_E, RT_M, ALU_rs, ALU_rt, DM_rt, WD_FWD_E, WD_FWD_W, WD_FWD_M;
	wire [4:0] A3_FWD_W;//!!!!!!!!!!!!!!!!!!!
	assign WD_FWD_E = PC4_E + 4;
	FWD_module FWD (
    .IR_D(Instr_D), 
    .IR_E(Instr_E), 
    .IR_M(Instr_M), 
    .RD1(RD1), 
    .RD2(RD2), 
    .E_rs(RS_E), 
    .E_rt(RT_E), 
    .M_rt(RT_M), 
    .WD_W(WD_FWD_W), 
    .WD_M(WD_FWD_M), 
    .WD_E(WD_FWD_E), 
    .Tnew_E(Tnew_FWD_E), 
    .Tnew_M(Tnew_FWD_M), 
    .Tnew_W(Tnew_FWD_W), 
    .A3_E(A3_FWD_E), 
    .A3_M(A3_FWD_M), 
    .A3_W(A3_FWD_W), 
    .GRF_RD1(GRF_RD1), 
    .GRF_RD2(GRF_RD2), 
    .ALU_rs(ALU_rs), 
    .ALU_rt(ALU_rt), 
    .DM_rt(DM_rt)
    );
	
	//D
	wire [4:0] A3_D,A3_W;
	wire [1:0] Ext_op;
	wire [1:0] Tnew_D;
	wire [31:0] PC4_W,PC4_E;
	
	CON_D_module CON_D (
    .instr(Instr_D), 
    .PC_sel(PC_sel), 
    .Ext_op(Ext_op), 
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt), 
    .Tnew(Tnew_D), 
    .A3(A3_D),
	 .isMD(isMD_D),
	 .isj(ISJ)
    );
	
	GRF_module GRF(
    .A1(Instr_D[`rs]), 
    .A2(Instr_D[`rt]), 
    .A3(A3_FWD_W), 
    .WD(WD_FWD_W), 
    .clk(clk), 
    .reset(reset), 
    .PC(PC4_W), 
    .RD1(RD1), 
    .RD2(RD2)
    );
	
	wire [31:0] signimm;
	
	EXT_module EXT (
    .imm(Instr_D[15:0]), 
    .Ext_op(Ext_op), 
    .signimm(signimm)
    );
	
	NPC_module NPC(
    .PC(PC4_D), 
    .imm26(Instr_D[25:0]), 
    .PC_sel(PC_sel), 
    .NPC_out(NPC_out)
    );

	CMP_module CMP (
	 .Instr_D(Instr_D),
    .RD1(GRF_RD1), 
    .RD2(GRF_RD2), 
    .CMP_out(CMP_out)
    );
	 
	//ID/EX
	wire [31:0] EXT_E;
	wire clr_E;
	assign clr_E = ID_EX_clr | rupt | Eret;
	wire [4:0] ExcCode_E;
	
	ID_EX_module ID_EX (
    .Instr(Instr_D), 
    .PC4(PC4_D), 
    .RS(GRF_RD1), 
    .RT(GRF_RD2), 
    .EXT(signimm), 
    .A3(A3_D), 
    .Tnew(Tnew_D),
	 .isj(isj_D),
	 .ExcCode(ExcCode_D),	 
    .clk(clk), 
    .reset(reset), 
    .clr(clr_E), 
    .Instr_E(Instr_E), 
    .PC4_E(PC4_E), 
    .RS_E(RS_E), 
    .RT_E(RT_E), 
    .EXT_E(EXT_E), 
	 .isj_E(isj_E),
    .A3_FWD_E(A3_FWD_E), 
    .Tnew_FWD_E(Tnew_FWD_E),
	 .ExcCode_E(ExcCode_E)
    );
	 
	//E
	wire ALUsrc_rs,ALUsrc_rt;
	wire [3:0] ALU_op;
	wire [2:0] WD_E_sel;
	wire [2:0] MD_op;
	wire [31:0] ALU_out,ALUsrc1,ALUsrc2;
	wire [4:0] ExcCode;
	wire [32:0] tmp, tmp2;
	assign tmp = {ALUsrc1[31],ALUsrc1}+{ALUsrc2[31],ALUsrc2};
	assign tmp2 = {ALUsrc1[31],ALUsrc1}-{ALUsrc2[31],ALUsrc2};
	
	CON_E_module CON_E (
    .instr(Instr_E), 
	 .tmp(tmp),
	 .tmp2(tmp2),
    .ALUsrc_rs(ALUsrc_rs), 
	 .ALUsrc_rt(ALUsrc_rt),
	 .start(start),
	 .MD_op(MD_op),
	 .ExcCode(ExcCode),
    .ALU_op(ALU_op), 
    .WD_E_sel(WD_E_sel),
	 .CP0_w(CP0_w),
	 .Eret(Eret)
    );
	
	MUX_ALU1_module MUX_ALU1 (
    .RS(ALU_rs), 
    .Instr(Instr_E),
    .ALUsrc_rs(ALUsrc_rs), 
    .ALUsrc1(ALUsrc1)
    );
	 
	MUX_ALU2_module MUX_ALU2 (
    .RT(ALU_rt), 
    .EXT_E(EXT_E),
    .ALUsrc_rt(ALUsrc_rt), 
    .ALUsrc2(ALUsrc2)
    );
	
	ALU_module ALU (
    .ALUsrc1(ALUsrc1), 
    .ALUsrc2(ALUsrc2), 
    .ALU_op(ALU_op), 
    .ALU_out(ALU_out)
    );
	
	wire [31:0] HI,LO;
	
	MD_module MD (
    .MDsrc1(ALU_rs), 
    .MDsrc2(ALU_rt), 
    .MD_op(MD_op), 
    .start(start), 
    .clk(clk), 
    .reset(reset), 
	 .rupt(rupt),
    .Busy(Busy), 
    .HI(HI), 
    .LO(LO)
    );
	 
	wire [31:0] WD_M,c0;
	wire [4:0] ExcCode_CP0;
	wire inBD;
	assign inBD = (PC4_E!=0||ExcCode_E==4)?isj_E:
					  (PC4_D!=0||ExcCode_D==4)?isj_D:ISJ;
	assign ExcCode_CP0 = (ExcCode_E==0)?ExcCode:ExcCode_E;
	wire [31:0] PC_CP0;
	assign PC_CP0 = (PC4_E!=0||ExcCode_E==4)?PC4_E:
						 (PC4_D!=0||ExcCode_D==4)?PC4_D:(PC+4);
	
	CP0_module CP0 (
    .ExcCode(ExcCode_CP0), 
    .PC(PC_CP0), 
    .clk(clk), 
    .reset(reset), 
	 .EXLClr(Eret),
    .inBD(inBD), 
    .WD(ALUsrc2), 
    .A(Instr_E[`rd]), 
    .CP0_w(CP0_w), 
    .HWInt(HWInt), 
    .c0(c0), 
    .rupt(rupt), 
    .Epc(Epc)
    );
	
	MUX_WD_M_module MUX_WD_M (
    .PC4_E(PC4_E), 
    .ALUout(ALU_out),   
	 .HI(HI),
	 .LO(LO),
	 .c0(c0),
    .WD_E_sel(WD_E_sel), 
    .WD_M(WD_M)
    );
	 
	 //EX/MEM
	wire [31:0] ALUout_M,PC4_M;
	
	EX_MEM_module EX_MEM (
    .Instr(Instr_E), 
    .PC4(PC4_E), 
    .RT(ALU_rt), 
    .ALUout(ALU_out), 
    .A3(A3_FWD_E), 
    .Tnew(Tnew_FWD_E), 
    .WD(WD_M), 
    .clk(clk),
    .reset(reset), 
	 .clr(rupt),
    .Instr_M(Instr_M), 
    .PC4_M(PC4_M), 
    .RT_M(RT_M), 
    .ALUout_M(ALUout_M), 
    .A3_FWD_M(A3_FWD_M), 
    .Tnew_FWD_M(Tnew_FWD_M), 
    .WD_FWD_M(WD_FWD_M)
    );
	
	//M
	wire [1:0] WD_M_sel;
	
	CON_M_module CON_M (
    .instr(Instr_M),  
    .WD_M_sel(WD_M_sel)
    );
	   
	wire [3:0] BE;
	
	 BE_EXT BE_EXT (
    .instr_M(Instr_M), 
	 .ALU_out(ALUout_M),
    .BE(BE)
    );
	
	wire [31:0] DM_out1,DM_out2;
	
	DM_module DM (
    .A(ALUout_M), 
    .WD(DM_rt), 
    .reset(reset), 
    .clk(clk), 
    .PC(PC4_M), 
    .BE(BE), 
    .DM_out(DM_out1)
    );
	
	LW_EXT_module  LW_EXT(
	 .ALUout(ALUout_M),
    .DMout1(DM_out1), 
    .Instr_M(Instr_M), 
    .DMout2(DM_out2)
    );
	 
	wire [31:0] WD_W,DM_out3;
	
	MUX_WD_W_module MUX_WD_W (
	 .WD_M(WD_FWD_M),
    .DMout(DM_out3), 
    .WD_M_sel(WD_M_sel), 
    .WD_W(WD_W)
    );
	 
	 //WB
	MEM_WB_module MEM_WB (
    .Instr(Instr_M), 
    .A3(A3_FWD_M), 
    .Tnew(Tnew_FWD_M), 
	 .PC4_M(PC4_M),
    .WD(WD_W), 
    .clk(clk), 
    .reset(reset), 
    .A3_FWD_W(A3_FWD_W), 
    .Tnew_FWD_W(Tnew_FWD_W), 
    .WD_FWD_W(WD_FWD_W),
	 .PC4_W(PC4_W)
    );
	
	assign PrAddr = ALUout_M;
	assign PrWD = DM_rt;
	assign PrWE = (BE == 4'b1111);
	assign DM_out3 = (((ALUout_M>=32'h0000_7F00&&ALUout_M<=32'h0000_7F0B)||(ALUout_M>=32'h0000_7F10&&ALUout_M<=32'h0000_7F1B))&&(Instr_M[`op]==6'b100011))?PrRD:DM_out2;

endmodule
