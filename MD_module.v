`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:43:23 11/23/2019 
// Design Name: 
// Module Name:    MD_module 
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
module MD_module(
    input [31:0] MDsrc1,
    input [31:0] MDsrc2,
    input [2:0] MD_op,
	 input start,
	 input clk,
	 input reset,
	 input rupt,
    output reg Busy,
    output reg [31:0] HI,
    output reg [31:0] LO
    );
	
	reg [31:0] HI_reg,LO_reg;
	reg [4:0] counter;
	
	initial begin
		HI_reg = 0;
		LO_reg = 0;
		HI = 0;
		LO = 0;
		Busy = 0;
		counter = 0;
	end
	
	always @(posedge clk)begin
		if(reset == 1)begin
			HI_reg = 0;
			LO_reg = 0;
			HI = 0;
			LO = 0;
			Busy = 0;
			counter = 0;
		end
		else if(counter != 0)begin
			if(counter == 1)begin
				Busy = 0;
				LO = LO_reg;
				HI = HI_reg;
			end
			counter = counter - 5'b1;
		end
		else if(start == 1&&rupt!=1)begin
			case(MD_op)
			1:begin
				{HI_reg,LO_reg} = MDsrc1*MDsrc2;
				counter = 5;
				Busy = 1;
			end
			2:begin
				LO_reg = MDsrc1/MDsrc2;
				HI_reg = MDsrc1%MDsrc2;
				counter = 10;
				Busy = 1;
			end
			3:begin
				{HI_reg,LO_reg} = $signed(MDsrc1)*$signed(MDsrc2);
				counter = 5;
				Busy = 1;
			end
			4:begin
				LO_reg = $signed(MDsrc1)/$signed(MDsrc2);
				HI_reg = $signed(MDsrc1)%$signed(MDsrc2);
				counter = 10;
				Busy = 1;
			end
			endcase
		end
		else if(MD_op == 5&&rupt!=1)begin
			HI_reg = MDsrc1;
			HI = MDsrc1;
		end
		else if(MD_op == 6&&rupt!=1)begin
			LO_reg = MDsrc1;
			LO = MDsrc1;
		end
	end
endmodule
