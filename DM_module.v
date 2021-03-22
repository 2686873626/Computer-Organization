`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:35:07 11/17/2019 
// Design Name: 
// Module Name:    DM_module 
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
module DM_module(
    input [31:0] A,
    input [31:0] WD,
    input reset,
    input clk,
	 input [3:0] BE,
    input [31:0] PC,
    output [31:0] DM_out
    );

	reg [31:0] RAM [4095:0];
	integer i;
	
	initial begin
		for(i = 0; i < 4096; i = i + 1)begin
			RAM [i] = 0;
		end
	end
	
	always @(posedge clk)begin
		if(reset == 1)begin
			for(i = 0; i < 4096; i = i + 1)begin
				RAM [i] = 0;
			end
		end
		else if(BE != 4'b0000 && A>=0 && A<=32'h0000_2fff)begin
			if(BE == 4'b1111)begin
				RAM [A[13:2]] = WD;
			end
			else if(BE == 4'b0011)begin
				RAM [A[13:2]][15:0] = WD[15:0];
			end
			else if(BE == 4'b1100)begin
				RAM [A[13:2]][31:16] = WD[15:0];
			end
			else if(BE == 4'b0001)begin
				RAM [A[13:2]][7:0] = WD[7:0];
			end
			else if(BE == 4'b0010)begin
				RAM [A[13:2]][15:8] = WD[7:0];
			end
			else if(BE == 4'b0100)begin
				RAM [A[13:2]][23:16] = WD[7:0];
			end
			else if(BE == 4'b1000)begin
				RAM [A[13:2]][31:24] = WD[7:0];
			end
			$display("%d@%h: *%h <= %h",$time,PC-32'd4, {A[31:2],2'b00}, RAM[A[13:2]]);
		end
	end
	
	assign DM_out = RAM [A[13:2]];

endmodule
