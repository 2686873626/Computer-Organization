`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:10 12/07/2019 
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
module mips(
    input clk,
    input reset,
    input interrupt,
    output [31:0] addr
    );
	
	wire IRQ1,IRQ0,WE1,WE0,PrWE;
	wire [31:0] Timer_out0,Timer_out1,Timer_in,Timer_A,CPU_in,CPU_A,CPU_out;
	wire [5:0] HWInt;
	
	assign HWInt = {3'b0,interrupt,IRQ1,IRQ0};
	
	TC Timer0 (
    .clk(clk), 
    .reset(reset), 
    .Addr(Timer_A[31:2]), 
    .WE(WE0), 
    .Din(Timer_in), 
    .Dout(Timer_out0), 
    .IRQ(IRQ0)
    );

	TC Timer1 (
    .clk(clk), 
    .reset(reset), 
    .Addr(Timer_A[31:2]), 
    .WE(WE1), 
    .Din(Timer_in), 
    .Dout(Timer_out1), 
    .IRQ(IRQ1)
    );
	 
	 bridge_module bridge (
    .CPU_A(CPU_A), 
    .CPU_out(CPU_out), 
    .PrWE(PrWE), 
	 .Timer_A(Timer_A),
    .CPU_in(CPU_in), 
    .WE0(WE0), 
    .WE1(WE1), 
    .Timer_in(Timer_in), 
    .Timer_out1(Timer_out0), 
    .Timer_out2(Timer_out1)
    );
	 
	 mips_in mips_in (
    .reset(reset), 
    .clk(clk), 
	 .PC_CPU(addr),
    .PrAddr(CPU_A), 
    .PrRD(CPU_in), 
    .PrWD(CPU_out), 
    .PrWE(PrWE), 
    .HWInt(HWInt)
    );

endmodule
