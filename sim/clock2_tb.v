//Testbench for clock2 module for use with GTKWAVE

`timescale 1s/10ms 

module clock2_tb;
reg            clk_r = 1;
reg     [15:0] loading_r = 16'h1259; 
reg            loadOrNah_r = 1;
wire [6:0]hourhigh;
wire [6:0]hourlow;
wire [6:0]minhigh;
wire [6:0]minlow;
wire [6:0]sechigh;
wire [6:0]seclow;
always
    #0.250 clk_r = ~clk_r;    //2 cycles will happen per second
initial begin
$dumpfile("a.vcd");
$dumpvars;
$display("Time Clock hrhigh   hrLow   minhigh  minlow  sechigh   seclow");
$monitor("%4d  %1b     %3h    %3h    %3h     %3h    %3h     %3h", 
$time, clk_r, hourhigh, hourlow, minhigh, minlow, sechigh, seclow);
#0.25 loadOrNah_r = 0;   //@t=.25  
#1    loadOrNah_r = 1;   //@t=1.25 
#4.25 $finish;             //@t=5.50
end 
 clock2 #(.timey0 (1'b1),
         .timey1   (1'b1)
        
        ) 
  DUT(  
  .Lhourhigh  (loading_r [15:12]),
  .Lhourlow  (loading_r [11:8 ]),
  .Lminhigh  (loading_r [ 7:4 ]),
  .Lminlow (loading_r [ 3:0 ]),
  .clk_i            (clk_r),
  .loadOrNah     (loadOrNah_r),  
  .hrhighbcd (hourhigh),
  .hrlowbcd  (hourlow),
  .minhighbcd(minhigh),
  .minlowbcd (minlow),
  .sechighbcd(sechigh),
  .seclowbcd (seclow));
endmodule
