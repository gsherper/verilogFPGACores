module nes_controller (
       input clk,
       input reset,
       input data,

       output sclk,
       output reg latch,
       output reg [1:0] state_reg, 
       output reg[7:0] rec_data);
       
// always @(negedge clk)
//   rec_data <= 8'b10101010;

localparam IDLE = 2'b00, LATCH = 2'b01, CAPTURE = 2'b11;

reg [1:0] state_next;

wire nes_controller_clk;
integer count;
reg sclk_active;

clock_generator #(
  .COUNTER(72),
  .SIZE(8)
) sclk_generator(
       .clk(clk),
       .reset(reset),
       .done_tick(nes_controller_done_tick),
       .clk_out(nes_controller_clk));

always@(negedge clk or posedge reset)
begin
  if (reset == 1'b1) begin
    state_reg <= IDLE;
  end
  else begin            
    state_reg <= state_next;
  end
end

// FSMD next-state logic
always @(negedge clk)
begin
  case (state_reg)
      IDLE:
        begin
          state_next <= LATCH;
          latch <= 0;
          sclk_active <= 0;
          count = 0;
          rec_data <= 8'b1111_1111;
        end
      LATCH:
        if (nes_controller_done_tick)
        begin
          state_next <= CAPTURE;
          latch <= 1;
          // sclk_active <= 1;
        end
      CAPTURE:
        begin
          if (nes_controller_done_tick)
          begin
            latch <= 0;
            // if (count > 0)
            // begin
              sclk_active <= 1;
              // rec_data <= {rec_data[6:0], data};
              rec_data[count] <= data;
            // end
            count = count + 1;
            if (count > 8) 
            begin
              state_next <= IDLE;
            end

          end  
        end
        

  endcase
end

assign sclk = sclk_active & nes_controller_clk;
endmodule
