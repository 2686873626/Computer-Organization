`timescale 1ns / 1ps
`define Exccode Cause[6:2]
`define EXL SR[1]
`define IE SR[0]
`define BD Cause[31]
`define IP Cause[15:10]
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:23:27 12/07/2019 
// Design Name: 
// Module Name:    CP0_module 
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
module CP0_module(
	 input [4:0] ExcCode,
	 input [31:0] PC,
	 input clk,
	 input reset,
	 input inBD,
	 input [31:0] WD,
	 input [4:0] A,
	 input CP0_w,
	 input [5:0] HWInt,
	 input EXLClr,
	 output [31:0] c0,
	 output rupt,
	 output [31:0] Epc
    );

	reg [31:0] SR, Cause, EPC, PRId;
	
	assign rupt = (!`EXL & `IE &((HWInt[0]&SR[10])|(HWInt[1]&SR[11])|(HWInt[2]&SR[12]))) | (ExcCode != 0 & !`EXL);
	assign c0 = (A == 12)?{16'b0,SR[15:10],8'b0,`EXL,`IE}:
					(A == 13)?{`BD,15'b0,`IP,3'b0,`Exccode,2'b0}:
					(A == 14)?EPC:
					(A == 15)?PRId:32'b0;
	assign Epc = EPC;
	
	initial begin
		PRId <= 32'h25000000;
		Cause <= 0;
		EPC <= 0;
		SR <= 0;
	end
	
	always @(posedge clk)begin
		if(reset == 1)begin
			PRId <= 32'h25000000;
			Cause <= 0;
			EPC <= 0;
			SR <= 0;
		end
		else begin
			`IP <= HWInt;
			if(EXLClr == 1)begin
				`EXL <= 0;
			end
			if(!`EXL & `IE &((HWInt[0]&SR[10])|(HWInt[1]&SR[11])|(HWInt[2]&SR[12])))begin
				`Exccode <= 5'b0;
				`BD <= inBD;
				`EXL <= 1;
				if(inBD == 0)begin
						EPC <= {PC[31:2],2'b00} - 4;
				end
				else begin
						EPC <= {PC[31:2],2'b00} - 8;
				end
			end
			else if(ExcCode != 0 && !`EXL)begin
				`Exccode <= ExcCode;
				`BD <= inBD;
				`EXL <= 1;
				if(inBD == 0)begin
						EPC <= {PC[31:2],2'b00} - 4;
				end
				else begin
						EPC <= {PC[31:2],2'b00} - 8;
				end
			end
			else if(CP0_w == 1)begin
				if(A == 12)begin
					SR <= WD;
				end
				else if(A == 13)begin
					Cause <= WD;
				end
				else if(A == 14)begin
					EPC <= WD;
				end
			end
		end
	end
			
endmodule
