`timescale 1ns / 1ps

module toplevel
  (
    input wire clk, reset,
    input wire sdata,
    output wire latch,
    output wire sclk,
    output wire [1:0] state,
    output wire [7:0] LED
  );

    wire [7:0] rec_data;
	 

    nes_controller nes_controller_unit(
       .clk(clk),
       .reset(~reset),
       .data(sdata),

       .sclk(sclk),
       .latch(latch),
       .state_reg(state),
       .rec_data(rec_data));

    assign LED[0] = ~rec_data[7];
    assign LED[1] = ~rec_data[6];
    assign LED[2] = ~rec_data[5];
    assign LED[3] = ~rec_data[4];
    assign LED[4] = ~rec_data[3];
    assign LED[5] = ~rec_data[2];
    assign LED[6] = ~rec_data[1];
    assign LED[7] = ~rec_data[0];

endmodule
