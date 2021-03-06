`timescale 1 ns/10 ps
`include "vunit_defines.svh"

module tb_eq;
	reg test_in0, test_in1;
	wire test_out;
	eq1 uut(.i0(test_in0), .i1(test_in1), .eq(test_out));

	`TEST_SUITE begin
 		`TEST_SUITE_SETUP begin
           		// Here you will typically place things that are common to
	        	// all tests, such as asserting the reset signal and starting
	        	// the clock(s).
	        	$display("Running test suite setup code");
				
	      	end
		`TEST_CASE_SETUP begin
		         // By default VUnit will run each test separately. However,
		         // advanced users may want to run tests consecutively rather
		         // than in separate instances of the HDL-simulator. In that
		         // case the code placed in a TEST_CASE_SETUP block should
		         // restore the unit under test to the state expected by the
		         // test cases below. In many cases this block would only
		         // assert/deassert the reset signal for a couple of
		         // clock-cycles.
		         //
		         // When trying out VUnit for the first time this section
		         // should probably be left empty.
		         $display("Running test case setup code");
		end
		`TEST_CASE("test1.1") begin
		         $display("test1.1");
		       
			test_in0 = 1'b0;
			test_in1 = 1'b0;
			#10; 
			assert(test_out == 1'b1) $display ("Test 1.1.1 pass");
				else $error ("Test 1.1.1 failed");
	
			#200; 
	
			test_in0 = 1'b1;
			test_in1 = 1'b0;
			#10;
			assert(test_out == 1'b0) $display ("Test 1.1.2 pass");
				else $error ("Test 1.1.2 failed");
		
			#200; 
	
			test_in0 = 1'b1;
			test_in1 = 1'b1;
			#10;
			assert(test_out == 1'b1) $display ("Test 1.1.3 pass");
				else $error ("Test 1.1.3 failed");
		
			#200; 
	
			test_in0 = 1'b0;	
			test_in1 = 1'b1;
			#10;
			assert(test_out == 1'b0) $display ("Test 1.1.4 pass");
				else $error("Test 1.1.4 failed");
		
			#200; 
			
		end
		`TEST_CASE("test1.2") begin
		         $display("test1.2");
		
			test_in0 = 1'b1;
			test_in1 = 1'b1;
			#10;
			assert(test_out == 1'b1) $display ("Test 1.2.1 pass");
				else $error ("Test 1.2.1 failed");
		
			#200; 
	
		end
	end
endmodule
