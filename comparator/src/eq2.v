`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:15:15 01/01/2019 
// Design Name: 
// Module Name:    eq2 
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
module eq2(
    input [1:0] a,
    input [1:0] b,
    output aeqb
    );
	 
	wire e0, e1;
	 
	eq1 eq_bit0_unit (.i0(a[0]), .i1(b[0]), .eq(e0));
	eq1 eq_bit1_unit (.i0(a[1]), .i1(b[1]), .eq(e1));

	assign aeqb = e0 & e1;
		
endmodule
