// binary to bcd converter


module bin2bcd(
    input [6:0] bin_in,
    output [3:0] bcd_high_out,
    output [3:0] bcd_low_out
 );

 assign bcd_high_out = bin_in /10;
 assign bcd_low_out = bin_in % 10;

endmodule
