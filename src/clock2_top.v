
module clock2_top(
input          CLOCK_50,
input          KEY0,      
input  [17:2]  SW,
output [ 6:0]  HEX2,
output [ 6:0]  HEX3,
output [ 6:0]  HEX4,
output [ 6:0]  HEX5,
output [ 6:0]  HEX6,
output [ 6:0]  HEX7);
clock2 #(.zeroz  (1))
  cl2(
  .clk_i            (CLOCK_50),
  .Lhourhigh    (SW[17:14]),       
  .Lhourlow     (SW[13:10]),      //switches
  .Lminhigh     (SW[ 9: 6]),       
  .Lminlow      (SW[ 5: 2]),
  .loadOrNah    (KEY0),
  .hrhighbcd (HEX7),       
  .hrlowbcd (HEX6),
  .minhighbcd(HEX5),       
  .minlowbcd (HEX4),
  .sechighbcd (HEX3),       
  .seclowbcd (HEX2));


endmodule
