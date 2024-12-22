//manager to set hours to 12 when they reach 0


module hoursmanaged
#(parameter zeroed = 1, parameter hrmax= 11)(         
  input [6:0] binb4,
  output[6:0] bin_fresh);
  /*
 if zeroed is true and hrmax is set to 11, then when binb4 is equal 
 to 4 zeros (0000), bin_fresh will be set to 12 (11 + 1). 
 If binb4 is any other value, bin_fresh will be set to binb4.
 */ 
 assign bin_fresh = (zeroed && (binb4 == 4'b0000))? hrmax[6:0]+ 1: binb4;
endmodule
