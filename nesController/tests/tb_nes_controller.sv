`timescale 1 ns/10 ps
`include "vunit_defines.svh"

module tb_nes_controller;

  reg clk = 0;
  reg reset = 0;
  reg sdata;

  reg sclk;
  reg [7:0] LED;
  reg [7:0] TEST[6:0];
  reg [6:0] test_pointer = 0;
  parameter CLK_FREQ = 12000000;

  always
    #42  clk <=  !clk;

 
  reg [7:0] controller;
  reg [1:0] state;
  wire latch;
  reg signal = 0;
  

  always@(posedge reset)
    controller <= 8'b11111111;

  localparam IDLE = 2'b00, LATCH = 2'b01, CAPTURE = 2'b11;

  integer position = 0;
  always@(negedge sclk)
  begin
    if (state == IDLE)
    begin
      position = 0;
      controller <= 8'b11111111;
    end
    else if (state == CAPTURE)
    begin
      if (position < 7)
      begin
        sdata <= controller[position];
        position = position + 1;
      end
      else
      begin
        TEST[test_pointer] <= LED;
        test_pointer <= test_pointer + 1;
      end
    end
  end

 always@(posedge latch)
 begin
   if (state == LATCH)
   begin
   sdata <= controller[position];
   position = position + 1;
   end
 end


 always @*
 begin
   if(state == IDLE)
   begin
     sdata <= 1'b1;
     position = 0;
   end
 end

  task CONTROLLER_EVENT;
    input string button;
    $display("->>>>>%b",button);
    begin
      case (button)
        "A": begin
          controller[0] <= 1'b0;
          #(12000*7);
        end
        "B": begin
          controller[1] <= 1'b0;
          #(12000*6);
        end
        "SELECT": begin
          controller[2] <= 1'b0;
          #(12000*5);
        end
        "START": begin
          controller[3] <= 1'b0;
          #(12000*4);
        end
        "UP": begin
          controller[4] <= 1'b0;          
          #(12000*3);
        end
        "DOWN": begin
          controller[5] <= 1'b0;          
          #(12000*2);
        end
        "LEFT": begin
          controller[6] <= 1'b0;                  
          #(12000*1);
        end
        "RIGHT": begin
          controller[7] <= 1'b0;          
         end
      endcase
    end
  endtask

	toplevel top_level_unit
	(
	//inputs
	.clk(clk),
	.reset(reset),
	.sdata(sdata),

	//ouputs
	.latch(latch),
	.sclk(sclk),
  .state(state),
	.LED(LED)
	);


  `TEST_SUITE begin
    `TEST_SUITE_SETUP begin
              // Here you will typically place things that are common to
            // all tests, such as asserting the reset signal and starting
            // the clock(s).
            $display("Running test suite setup code");
            reset <= 0;
            #100;
            reset <= 1;
            #100;
        
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
    `TEST_CASE("Button Tests") begin
        $display("Button Tests");
      
        CONTROLLER_EVENT("A");
        signal <= 1;
        assert(LED == 8'b1000_0000) $display ("Test A pass");
          else $error ("Test A failed");
        controller <= 8'b1111_1111;
        
        #50000
        signal <= 0;
        CONTROLLER_EVENT("B");
        signal <= 1;
        assert(LED == 8'b0100_0000) $display ("Test B pass");
          else $error ("Test B failed");
        controller <= 8'b1111_1111;
        #50000

        signal <= 0;
        CONTROLLER_EVENT("START");
        signal <= 1;
        assert(LED == 8'b0001_0000) $display ("Test START pass");
          else $error ("Test START failed");
        controller <= 8'b1111_1111;
        #50000
        signal <= 0;
        
    end
	end

endmodule
