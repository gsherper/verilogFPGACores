
//Listing 8.5
`timescale 1 ns/10 ps

module tb_uart_toplevel;

  reg clk = 0;

	reg reset;
	wire test_out;

	parameter CLK_FREQ = 12000000;

	always
		#42  clk <=  !clk;

	reg r_Rx_Serial = 1'b1;
  reg flag = 0;
	parameter c_BIT_PERIOD = 103648;
  //parameter c_BIT_PERIOD = 124008;

   task UART_WRITE_BYTE;
     input [7:0] i_Data;
     integer     ii;
     begin

       // Send Start Bit
       r_Rx_Serial <= 1'b0;
       flag <= ~flag;
       #(c_BIT_PERIOD);


       // Send Data Byte
       for (ii=0; ii<8; ii=ii+1)
         begin
           r_Rx_Serial <= i_Data[ii];
           flag <= ~flag;
           #(c_BIT_PERIOD);
         end

       // Send Stop Bit
       r_Rx_Serial <= 1'b1;
       flag <= ~flag;
       #(c_BIT_PERIOD);

      end
   endtask // UART_WRITE_BYTE
	//
	top_level top_level_unit
	(
	//inputs
	.clk(clk),
	.reset(reset),
	.rx(r_Rx_Serial),
	.btn(btn),
	//ouputs
	.tx(tx),
	.Enable(Enable),
	.SevenSegment(SevenSegment),
	.LED(LED)
	);

	initial begin
		reset <= 1;
		#100;
		reset <= 2;
    @(posedge clk);
		UART_WRITE_BYTE(8'h64);
    @(posedge clk);
    #10000
    UART_WRITE_BYTE(8'h66);

		 	$stop;

	end

endmodule
