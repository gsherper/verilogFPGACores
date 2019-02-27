`timescale 1 ns/10 ps

module fb_tbgt;

	reg [3:0] test_in0, test_in1;
	wire test_out;
	four_bit_gt uut(.a(test_in0), .b(test_in1), .agtb(test_out));
	
	initial
	begin
	      
		for (int a = 0; a < 16; a++) begin
			if (a == 0) begin
				test_in0 = 4'b0000;
			end 
			else
			begin
				test_in0 <= test_in0 + 1;
			end
			for (int b = 0; b < 16; b++) begin
				

				if (b == 0) begin
					test_in1 = 4'b0000;
				end 
				else
				begin
					test_in1 <= test_in1 + 1;
				end
				
				#10;
				if (test_in0 > test_in1) begin
					assert(test_out == 1'b1) //$display ("Test %d > %d pass", a, b);
						else $error ("Test %d > %d failed", a, b);
				end 
				else
				begin
					assert(test_out == 1'b0) //$display ("Test %d < %d pass", a, b);
						else $error ("Test %d < %d failed", a, b);
				end

				#200;
			end
		end
		$stop;
	end
endmodule