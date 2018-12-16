//`timescale 10 ns / 1 ns

module traffic_light_tb();

// inputs
reg clk_50_mhz;
reg nrtht_nrth_s10th_st(red_nrth_s10th),
.ylw_light_nrth_s10th_st(ylw_nrth_s10th),
.grn_light_nrth_s10th_st(grn_nrth_s10th),
.red_light_west_s10th_st(red_west_s10th),
.ylw_light_west_s10th_st(ylw_west_s10th),
.grn_light_west_s10th_st(grn_west_s10th),
.red_light_nrth_s11th_st(red_nrth_s11th),
.ylw_light_nrth_s11th_st(ylw_nrth_s11th),
.grn_light_nrth_s11th_st(grn_nrth_s11th),
.red_light_west_s11th_st(red_west_s11th),
.ylw_light_west_s11th_st(ylw_west_s11th),
.grn_light_west_s11th_st(grn_west_s_ped_button;
reg west_ped_button;
reg reset;

// outputs
wire red_nrth_s10th;    // traffic lights
wire ylw_nrth_s10th;
wire grn_nrth_s10th;
wire red_west_s10th;
wire ylw_west_s10th;
wire grn_west_s10th;
wire red_nrth_s11th;
wire ylw_nrth_s11th;
wire grn_nrth_s11th;
wire red_west_s11th;
wire ylw_west_s11th;
wire grn_west_s11th;
wire walk_nrth_s10th;   // crossing lights
wire stop_nrth_s10th;
wire walk_west_s10th;
wire stop_west_s10th;
wire walk_nrth_s11th;
wire stop_nrth_s11th;
wire walk_west_s11th;
wire stop_west_s11th;
wire debug_10n_q;       // debugging
wire debug_10w_q;
wire debug_out;

traffic_light_top DUT(
.red_ligh11th),
.walk_light_nrth_s10th_st(walk_nrth_s10th),
.stop_light_nrth_s10th_st(stop_nrth_s10th),
.walk_light_west_s10th_st(walk_west_s10th),
.stop_light_west_s10th_st(stop_west_s10th),
.walk_light_nrth_s11th_st(walk_nrth_s11th),
.stop_light_nrth_s11th_st(stop_nrth_s11th),
.walk_light_west_s11th_st(walk_west_s11th),
.stop_light_west_s11th_st(stop_west_s11th),
.debug_out(debug_out),
.debug_10n_q(debug_10n_q),
.debug_10w_q(debug_10w_q),
.nrth_ped_button(nrth_pedbutton),
.west_ped_button(west_pedbutton),
.reset_n(reset),
.clk_50_mhz(clk_50_mhz)
);

initial begin
    clk_50_mhz <= 0;
    nrth_ped_button <= 1;
    west_ped_button <= 1;
    
    reset <= 0;
    reset <= 1;
    #10 reset <= 0;
    
         $display("Start");
    #51  nrth_ped_button <= 0;
    #1   nrth_ped_button <= 1;
    #389 $display("Finish");
    #1   $finish;
end

always #1 clk_50_mhz = ~clk_50_mhz;

endmodule
