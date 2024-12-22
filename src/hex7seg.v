//7 segment display from 4 bit hex

module hex7seg (
  input  [3:0] c_i,      // 4-bit hexidecimal digit input
  output [6:0] disp_o);  // 7-bit output to a 7-segment display

  //     7-segment display segment # 6543210
  assign disp_o = (c_i == 4'h0) ? 7'b1000000 :
                  (c_i == 4'h1) ? 7'b1111001 :
                  (c_i == 4'h2) ? 7'b0100100 :
                  (c_i == 4'h3) ? 7'b0110000 :
                  (c_i == 4'h4) ? 7'b0011001 :
                  (c_i == 4'h5) ? 7'b0010010 :
                  (c_i == 4'h6) ? 7'b0000010 :
                  (c_i == 4'h7) ? 7'b1111000 :
                  (c_i == 4'h8) ? 7'b0000000 :
                  (c_i == 4'h9) ? 7'b0011000 :
                  (c_i == 4'hA) ? 7'b0001000 :
                  (c_i == 4'hb) ? 7'b0000011 :
                  (c_i == 4'hC) ? 7'b1000110 :
                  (c_i == 4'hd) ? 7'b0100001 :
                  (c_i == 4'hE) ? 7'b0000110 :
                                  7'b0001110;  //F
                  
endmodule
