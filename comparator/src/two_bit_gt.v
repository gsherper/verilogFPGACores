`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:18:06 01/02/2019 
// Design Name: 
// Module Name:    two_bit_gt 
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
module two_bit_gt(
    input [1:0] a,
    input [1:0] b,
    output agtb
    );
	 
	 wire p0, p1, p2;
	 
	 assign agtb = p0 | p1 | p2;
	 assign p0 = a[0] & ~b[0] & ~b[1];
	 assign p1 = a[1] & ~b[1];
	 assign p2 = a[1] & b[1] & a[0] & ~b[0];
	 
endmodule
