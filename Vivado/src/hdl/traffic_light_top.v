//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jack and friends :)
// 
// Create Date: 11/24/2018 05:18:17 PM
// Design Name: 
// Module Name: traffic_light_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_light_top(
output wire red_light_nrth_s10th_st,
output wire ylw_light_nrth_s10th_st,
output wire grn_light_nrth_s10th_st,
output wire red_light_west_s10th_st,
output wire ylw_light_west_s10th_st,
output wire grn_light_west_s10th_st,
output wire red_light_nrth_s11th_st,
output wire ylw_light_nrth_s11th_st,
output wire grn_light_nrth_s11th_st,
output wire red_light_west_s11th_st,
output wire ylw_light_west_s11th_st,
output wire grn_light_west_s11th_st,
output wire walk_light_west_s10th_st,
output wire stop_light_west_s10th_st,
output wire walk_light_nrth_s10th_st,
output wire stop_light_nrth_s10th_st,
output wire walk_light_west_s11th_st,
output wire stop_light_west_s11th_st,
output wire walk_light_nrth_s11th_st,
output wire stop_light_nrth_s11th_st,
output wire debug_out,
input wire nrth_pedo_button,
input wire west_pedo_button,
input wire reset_n,
input wire clk_50_mhz
);

wire clk_1_hz;
wire enable_n;
wire reset;
wire nrth_xwalk_sig;
wire west_xwalk_sig;

debounce rst(
    .sig_out(reset),
    .button_n(reset_n),
    .clk_50_mhz(clk_50_mhz)
);

debounce north_button(
    .sig_out(nrth_xwalk_sig),
    .button_n(nrth_pedo_button),
    .clk_50_mhz(clk_50_mhz)
);

debounce west_button(
    .sig_out(west_xwalk_sig),
    .button_n(west_pedo_button),
    .clk_50_mhz(clk_50_mhz)
);

master_timer timer(
    .clk_mstr(clk_1_hz),
    .enable_n(enable_n),
    .clk_50_mhz(clk_50_mhz)
);

two_way_intersection two_way(
    .reda_0(red_light_nrth_s10th_st),
    .ylwa_0(ylw_light_nrth_s10th_st),
    .grna_0(grn_light_nrth_s10th_st),
    .reda_1(red_light_west_s10th_st),
    .ylwa_1(ylw_light_west_s10th_st),
    .grna_1(grn_light_west_s10th_st),
    .redb_0(red_light_nrth_s11th_st),
    .ylwb_0(ylw_light_nrth_s11th_st),
    .grnb_0(grn_light_nrth_s11th_st),
    .redb_1(red_light_west_s11th_st),
    .ylwb_1(ylw_light_west_s11th_st),
    .grnb_1(grn_light_west_s11th_st),
    .crosswalk_0(nrth_pedo_button),
    .crosswalk_1(west_pedo_button),
    .reset_n(reset_n),
    .clk(clk_1_hz)
);

assign enable_n = reset_n;
assign debug_out = clk_1_hz;
    
endmodule