module clock_generator 
  #(
    parameter COUNTER=2,
    parameter SIZE=2
   )(
     input wire clk,
     input wire reset,
     output reg done_tick,
     output reg clk_out);

reg [SIZE-1:0] r_reg;
wire [SIZE-1:0] r_nxt;

always @(posedge clk or posedge reset)
begin
  if (reset)
  begin
    r_reg <= 1'b0;
	  clk_out <= 1'b0;
    done_tick <= 1'b0;
  end

  else if (r_nxt == COUNTER)
 	begin
	  r_reg <= 1'b0;
	  clk_out <= ~clk_out;
    if (clk_out == 1'b1)
      done_tick <= 1'b1;
	end

  else 
  begin
    r_reg <= r_nxt;
    done_tick <= 1'b0;
  end
end

 assign r_nxt = r_reg+1;
endmodule
