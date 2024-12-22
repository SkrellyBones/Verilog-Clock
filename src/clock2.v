// 4 bit counter with active low load, toggleable zero blanker,
//toggleable hour manager, and a toggleable load from switch inputs

module clock2 #(parameter timey0 = 49999999, timey1 = 59, timey2 = 59, timey3 = 11, zeroz = 1) (
  input        clk_i,      
  input        nLoaded_i,   // active low synchronous load
  input        loadOrNah,   // load toggle
  input  [3:0] Lhourhigh,
  input  [3:0] Lhourlow,    // inputs with L in front of them are 
  input  [3:0] Lminhigh,    // loaded variables from switches
  input  [3:0] Lminlow,
  output  [6:0] Lhour,
  output  [6:0] Lmin,
  output [6:0] hrhighbcd,  // the outputs from the hex7seg
  output [6:0] hrlowbcd,
  output [6:0] minhighbcd,
  output [6:0] minlowbcd,
  output [6:0] sechighbcd,
  output [6:0] seclowbcd,
  output [6:0] seconds_o,  //outputs of each counter
  output [6:0] minutes_o,
  output [6:0] hours_o  
 );

 wire [6:0]  hex7needblank;//self explains
 wire [6:0] managedhour;  //the fixed hour to 12 when hours is displaying 0
 wire [3:0] sechigh;
 wire [3:0] seclow;
 wire [3:0] minlow;
 wire [3:0] minhigh;
 wire [3:0] hrlow;
 wire [3:0] hrhigh;
 wire stage3_en_w;
 and(tc0a1, stage1_en_w, stage2_en_w); //ands the second update counter 
                                       //and second terminal counts
 and(tc2a2, tc0a1, stage3_en_w);       //ands tc0a1 with the 
                                       //minutes terminal count
 wire tc2a2;
 wire tc0a1;

 wire stage1_en_w;
 wire stage2_en_w;
 assign Lmanagedhour = ((Lhour == timey3[6:0]+1) && zeroz) ? 7'd0 : Lhour; 
 /*
 you have to load the managed hour if the zeroed condition of 
 hourmanager is true and if the hours + 1 is equal to the loaded hour
 from the switches

 */

  cntrStage#(.cntr_tc_p (timey0))           
    stage0 (                    //how many times the seconds update counter
      .clk_i      (clk_i),
      .nLoaded_i  (4'b0000),
      .loadOrNah  (loadOrNah),
      .enable_i   (1'b1),       // always enabled
      .term_cnt_o (stage1_en_w),// stage stage 0 at TC (1-cycle pulse)
      .count_o    () );         // unused

  cntrStage#(.cntr_tc_p (timey1))           
    stage1 (                    //seconds counter
      .clk_i      (clk_i),      // same clock as stage 0
      .nLoaded_i  (4'b0000), 
      .loadOrNah  (loadOrNah),    
      .enable_i   (stage1_en_w),// only enabled when stage 0 is at TC
      .term_cnt_o (stage2_en_w),// stage stage 1 at TC (1-cycle pulse)         
      .count_o    (seconds_o) );

 cntrStage#(.cntr_tc_p (timey2))            
    stage2 (                    // minutes counter
      .clk_i      (clk_i),      // same clock as stage 0   
      .nLoaded_i  (Lmin),
      .loadOrNah  (loadOrNah),
      .enable_i   (tc0a1),      // only enabled when stage 1 is at TC 
                                // AND stage 0 is at TC
      .term_cnt_o (stage3_en_w),// stage stage 2 at TC (1-cycle pulse)
      .count_o    (minutes_o) );

 cntrStage#(.cntr_tc_p (timey3))      
    stage3 (                      // hours counter
      .clk_i      (clk_i),        // same clock as stage 0
      .nLoaded_i  (Lmanagedhour),
      .loadOrNah  (loadOrNah),      
      .enable_i   (tc2a2),        // only enabled when stage 2 is at TC AND
                                  // stage 1 is at TC AND stage 0 is at TC
      .term_cnt_o (),             // unused
      .count_o    (hours_o) );
 hoursmanaged#(
  .zeroed  (zeroz),               //zeroed is toggleable
  .hrmax   (timey3))              
  mangerH (
  .binb4  (hours_o),
  .bin_fresh (managedhour) );    //when time 0, be 12
 

 bin2bcd sec(
  .bin_in(seconds_o),
  .bcd_high_out(sechigh),
  .bcd_low_out(seclow));
  
 bin2bcd mins(
  .bin_in(minutes_o),
  .bcd_high_out(minhigh),
  .bcd_low_out(minlow) );
 
 bin2bcd hr(
  .bin_in(managedhour),          //translates info from managedhour to 
                                 //the hex7seg
  .bcd_high_out(hrhigh),
  .bcd_low_out(hrlow));
 
 bcd2bin Hbcd(                       
  .bcd_high         (Lhourhigh),  //leftmost 4 switches
  .bcd_low          (Lhourlow),   //next 4 switches
  .bin_out          (Lhour));
 bcd2bin Mbcd(
  .bcd_high         (Lminhigh),   //next 4 switches
  .bcd_low          (Lminlow),    // next 4 switches
  .bin_out          (Lmin));

hex7seg segs1 (
 .disp_o(hex7needblank),         //sends output of ms hours output to 
                                 //zeroblanker
 .c_i(hrhigh)
 );
hex7seg segs2 (
 .disp_o(hrlowbcd),
 .c_i(hrlow)
 );
 hex7seg segs3 (
 .disp_o(minhighbcd),
 .c_i(minhigh)
 );
 hex7seg segs4 (
 .disp_o(minlowbcd),
 .c_i(minlow)
 );
 hex7seg seg5 (
 .disp_o(sechighbcd),
 .c_i(sechigh)
 );
 hex7seg segs6 (
 .disp_o(seclowbcd),
 .c_i(seclow)
 );
 
 zeroblanker#(.blanktoggle  (1'b1)) zerah(
  .needblank  (hex7needblank),
  .blanked    (hrhighbcd)    //makes the display blanked instead of 
                             //express 0 on the hours 
 );
    



endmodule
