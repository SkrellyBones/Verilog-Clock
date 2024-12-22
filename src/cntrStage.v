//ENGR 190 Lab 2 part 2 modified counterstage with active low sync load
//Caleb Triplett 03/15/23

module cntrStage
  #(parameter cntr_tc_p = 9) (  // counter terminal count
  input  clk_i,        // positive edge triggered clock
  input  [cntr_bits_p-1:0]nLoaded_i,    // synchronous active low load
  input  loadOrNah,
  input  enable_i,     // synchronous active high enable
  output term_cnt_o,   // set when at terminal count
  output [cntr_bits_p-1:0] count_o );  // count value

  // System task clog2 returns the ceiling of the log base 2 of the
  // argument.  Parameter cntr_bits_p is the minimum number of bits
  // needed to count 0 to cntr_tc_p.  It is not intended to be
  // overridden by higher level code, so is a localparam instead of
  // a parameter.
  localparam cntr_bits_p = $clog2(cntr_tc_p + 1);

  reg [cntr_bits_p-1:0] count_r = 0;    // count register

  always @(posedge clk_i) begin
    if (~loadOrNah) 
      count_r <= nLoaded_i;              //start loading if the active low load is 0 
    else if (enable_i) begin
      if (count_r == cntr_tc_p[cntr_bits_p-1:0])
        count_r <= 1'b0;            // enabled & at tc, wrap to 0
      else
        count_r <= count_r + 1'b1;  // enabled & not TC, so increment
    end
  end

  // set outputs from registers used in the always block
  assign count_o = count_r;
  assign term_cnt_o = (count_r == cntr_tc_p[cntr_bits_p-1:0]);

endmodule
