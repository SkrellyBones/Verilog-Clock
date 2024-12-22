//ENGR 190 Lab 09 part 2, Blanker for hours if it displays 0
//Caleb Triplett 03/15/23
module zeroblanker #(parameter blanktoggle = 1)(
  input   [6:0] needblank, // unblanked value
  output  [6:0] blanked);  //blanked value
 assign blanked = (blanktoggle && (needblank[6:0] == 7'b1000000))
 ? 7'b1111111 : needblank;    
 //if the display is expressing 0, the display is blanked.
endmodule