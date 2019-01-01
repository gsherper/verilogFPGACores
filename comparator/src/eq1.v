`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:16 12/29/2018 
// Design Name: 
// Module Name:    eq1 
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
module eq1(
    input i0,
    input i1,
    output eq
    );
	 
	 wire p0, p1;
	 
	 assign eq = p0 | p1;
	 assign p0 = ~i0 & ~i1;
	 assign p1 = i0 & i1;

endmodule
