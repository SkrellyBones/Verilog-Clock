//ENGR 190 Lab 09 part 2 bcd to binary converter
//Caleb Triplett 03/15/23
module bcd2bin(
input  [3:0] bcd_low,    
input  [3:0] bcd_high,    
output [6:0] bin_out);  
wire   [4:0] bcd0;  //most signifigant bcd
wire   [4:0] bcd1;  //least signifigant bcd
assign bcd0 = (bcd_high[3:0] > 4'b1001)? 4'b0000: bcd_high;  //if ms bit is > 9, be 0
assign bcd1 = (bcd_low[3:0] > 4'b1001)? 4'b0000: bcd_low;    //if ls bit is > 9, be 0
assign bin_out [6:0] = (bcd0 * 4'b1010  + bcd1);             //multiply the ms bit by 10 and add the ls bit

endmodule 