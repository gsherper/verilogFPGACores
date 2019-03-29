`timescale 1ns / 1ps

module top_level
   (
    input wire clk, reset,
    input wire rx,
    input wire btn,
    output wire tx,
    output wire [2:0] Enable,
    output wire [7:0] SevenSegment, LED
   );

   // signal declaration
   wire tx_full, rx_empty, btn_tick;
   wire [7:0] rec_data; reg [7:0] data_in;
   // Counter to set the time delay
   reg [26:0] timer_cnt      = 1'b0;
   reg        timer_timeout  = 1'b0;
   reg        rd_uart   = 1'b0;
   reg        wr_uart   = 1'b0;

   reg echo_flag = 1'b0;

  // writing data to uart and incrementing address for memory
  always@(posedge clk)
  begin
      if(reset)
      begin
          wr_uart     <=  1'b0;
          data_in     <=  0;
      end
      else if(~tx_full & ~rx_empty & ~echo_flag)
      begin
          wr_uart     <=  1'b1;
          rd_uart     <= 1'b1;
          data_in     <=  rec_data;
          echo_flag <= 1'b1;
      end
      else if(rx_empty)
      begin
            echo_flag <= 1'b0;
            rd_uart   <= 1'b0;
      end
      else
          wr_uart     <=  1'b0;
  end


   // body
   // instantiate uart
    uart #(     .DVSR		(7'd79),
                 .DVSR_BIT		(4'd7) ,
                 .DBIT		(4'd8) ,
                 .FIFO_W	(3'd4)
     ) uart_unit
      (.clk(clk), .reset(reset), .rd_uart(rd_uart),
       .wr_uart(wr_uart), .rx(rx), .w_data(data_in),
       .tx_full(tx_full), .rx_empty(rx_empty),
       .r_data(rec_data), .tx(tx));
   // instantiate debounce circuit
   // debounce btn_db_unit
   //    (.clk(clk), .reset(), .sw(btn),
   //     .db_level(), .db_tick(btn_tick));
   // incremented data loops back
   // assign rec_data1 = rec_data + 1;
   // LED display
   assign LED[0] = rec_data[7];
   assign LED[1] = rec_data[6];
   assign LED[2] = rec_data[5];
   assign LED[3] = rec_data[4];
   assign LED[4] = rec_data[3];
   assign LED[5] = rec_data[2];
   assign LED[6] = rec_data[1];
   assign LED[7] = rec_data[0];

   assign Enable = 3'b111;
   assign SevenSegment = {1'b1, ~tx_full, 2'b11, ~rx_empty, 3'b111};

endmodule
