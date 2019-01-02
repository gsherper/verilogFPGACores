`timescale 1 ns/10 ps
`include "vunit_defines.svh"

module tb_eq2;

	reg [1:0] test_in0, test_in1;
	wire test_out;
	eq2 uut(.a(test_in0), .b(test_in1), .aeqb(test_out));

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
		`TEST_CASE("test2.1") begin
		         $display("test one");
		       
			test_in0 = 2'b00;
			test_in1 = 2'b00;
			#10; 
			assert(test_out == 1'b1) $display ("Test 2.1.1 pass");
				else $error ("Test 1 failed");
	
			#200; 
	
			test_in0 = 2'b01;
			test_in1 = 2'b00;
			#10;
			assert(test_out == 1'b0) $display ("Test 2.1.2 pass");
				else $error ("Test 2.1.2 failed");
		
			#200; 
	
			test_in0 = 2'b01;
			test_in1 = 2'b11;
			#10;
			assert(test_out == 1'b0) $display ("Test 2.1.3 pass");
				else $error ("Test 2.1.3 failed");
		
			#200; 
	
			test_in0 = 2'b10;	
			test_in1 = 2'b10;
			#10;
			assert(test_out == 1'b1) $display ("Test 2.1.4 pass");
				else $error("Test 2.1.4 failed");
		
			#200; 
			
		end
		`TEST_CASE("test2.2") begin
		         $display("test2.2");
		
			test_in0 = 2'b10;
			test_in1 = 2'b00;
			#10;
			assert(test_out == 1'b0) $display ("Test 2.2.1 pass");
				else $error ("Test 2.2.1 failed");
		
			#200; 
			
			test_in0 = 2'b11;
			test_in1 = 2'b11;
			#10;
			assert(test_out == 1'b1) $display ("Test 2.2.2 pass");
				else $error ("Test 2.2.2 failed");
		
			#200; 

			test_in0 = 2'b11;
			test_in1 = 2'b01;
			#10;
			assert(test_out == 1'b0) $display ("Test 2.2.3 pass");
				else $error ("Test 2.2.3 failed");
		
			#200; 
	
		end
	end
endmodule
