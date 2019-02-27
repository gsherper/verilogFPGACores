`timescale 1 ns/10 ps

module tb_two_bit_gt;

	reg [1:0] test_in0, test_in1;
	wire test_out;
	two_bit_gt uut(.a(test_in0), .b(test_in1), .agtb(test_out));

	initial
	begin
	      
		test_in0 = 2'b00;
		test_in1 = 2'b00;
		#10; 
		assert(test_out == 1'b0) $display ("Test 1.1.1 pass");
			else $error ("Test 1.1.1 failed");

		#200; 

		test_in0 = 2'b00;
		test_in1 = 2'b01;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.2 pass");
			else $error ("Test 1.1.2 failed");
		
		#200; 

		test_in0 = 2'b00;
		test_in1 = 2'b10;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.3 pass");
			else $error ("Test 1.1.3 failed");
		
		#200; 
	
		test_in0 = 2'b00;
		test_in1 = 2'b11;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.4 pass");
			else $error("Test 1.1.4 failed");

		#200; 
		
		test_in0 = 2'b01;
		test_in1 = 2'b00;
		#10; 
		assert(test_out == 1'b1) $display ("Test 1.1.5 pass");
			else $error ("Test 1.1.5 failed");

		#200; 

		test_in0 = 2'b01;
		test_in1 = 2'b01;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.6 pass");
			else $error ("Test 1.1.6 failed");
		
		#200; 

		test_in0 = 2'b01;
		test_in1 = 2'b10;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.7 pass");
			else $error ("Test 1.1.7 failed");
		
		#200; 
	
		test_in0 = 2'b01;
		test_in1 = 2'b11;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.8 pass");
			else $error("Test 1.1.8 failed");

		#200; 
		test_in0 = 2'b10;
		test_in1 = 2'b00;
		#10; 
		assert(test_out == 1'b1) $display ("Test 1.1.1 pass");
			else $error ("Test 1.1.9 failed");

		#200; 

		test_in0 = 2'b10;
		test_in1 = 2'b01;
		#10;
		assert(test_out == 1'b1) $display ("Test 1.1.10 pass");
			else $error ("Test 1.1.10 failed");
		
		#200; 

		test_in0 = 2'b10;
		test_in1 = 2'b10;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.11 pass");
			else $error ("Test 1.1.11 failed");
		
		#200; 
	
		test_in0 = 2'b10;
		test_in1 = 2'b11;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.12 pass");
			else $error("Test 1.1.12 failed");

		#200; 
		
		test_in0 = 2'b11;
		test_in1 = 2'b00;
		#10; 
		assert(test_out == 1'b1) $display ("Test 1.1.13 pass");
			else $error ("Test 1.1.13 failed");

		#200; 

		test_in0 = 2'b11;
		test_in1 = 2'b01;
		#10;
		assert(test_out == 1'b1) $display ("Test 1.1.14 pass");
			else $error ("Test 1.1.14 failed");
		
		#200; 

		test_in0 = 2'b11;
		test_in1 = 2'b10;
		#10;
		assert(test_out == 1'b1) $display ("Test 1.1.15 pass");
			else $error ("Test 1.1.15 failed");
		
		#200; 
	
		test_in0 = 2'b11;
		test_in1 = 2'b11;
		#10;
		assert(test_out == 1'b0) $display ("Test 1.1.16 pass");
			else $error("Test 1.1.16 failed");

		#200; 
		$stop;
			
	end

endmodule