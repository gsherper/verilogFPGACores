`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:52:23 01/03/2019 
// Design Name: 
// Module Name:    four_bit_gt 
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
module four_bit_gt(
    input [3:0] a,
    input [3:0] b,
    output agtb
    );
	 
	wire e_upper, e_lower, gt_upper, gt_lower;
	 
	eq2 eq_lower_unit (.a(a[1:0]), .b(b[1:0]), .aeqb(e_lower));
	eq2 eq_upper_unit (.a(a[3:2]), .b(b[3:2]), .aeqb(e_upper));
	
	two_bit_gt gt_lower_unit (.a(a[1:0]), .b(b[1:0]), .agtb(gt_lower));
	two_bit_gt gt_upper_unit (.a(a[3:2]), .b(b[3:2]), .agtb(gt_upper));
	
	assign lower_value = e_lower | gt_lower;
	assign upper_value = e_upper | gt_upper;
	
	assign gt_result_combine = lower_value & upper_value;
	assign gt_result_upper = ~lower_value & upper_value & ~e_upper;
	
	assign gt_result = gt_result_combine | gt_result_upper;

	assign eq = e_lower & e_upper;
	
	assign agtb = gt_result & ~eq;

endmodule
