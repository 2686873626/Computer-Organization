`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:11:57 11/20/2019 
// Design Name: 
// Module Name:    GRF_module 
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
module GRF_module(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input clk,
    input reset,
    input [31:0] PC,
    output [31:0] RD1,
    output [31:0] RD2
    );

	reg [31:0] GRF_Reg [31:0];
	
	integer i;
	
	initial begin
		for(i = 0; i< 32; i = i + 1)begin
			GRF_Reg [i] = 0;
		end
	end
	
	assign RD1 = (A1==A3 && A1!=0)?WD:GRF_Reg [A1],
	       RD2 = (A2==A3 && A2!=0)?WD:GRF_Reg [A2];//内部转发
	
	always @(posedge clk)begin
		if(reset == 1)begin
			for(i = 0; i< 32; i = i + 1)begin
				GRF_Reg [i] = 0;
			end
		end
		else if(A3 != 0)begin
			GRF_Reg [A3] = WD;
			$display("%d@%h: $%d <= %h",$time, PC-32'd4, A3, WD);
		end
	end
			
	

endmodule
