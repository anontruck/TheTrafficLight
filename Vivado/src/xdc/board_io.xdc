//////////////////////////////////////////////////////////////////////////////////
// Group: 6 
// Engineer: Zach, Tristan, Chris, Yazid, & Anthony
// 
// Two intersection traffic light controller, Top module
// 
//////////////////////////////////////////////////////////////////////////////////

set_property PACKAGE_PIN W5 [get_ports clk_50_mhz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_50_mhz]
create_clock -name external_clock -period 20.00 [get_ports clk_50_mhz]

set_property PACKAGE_PIN H2 [get_ports red_light_nrth_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports red_light_nrth_s10th_st]

set_property PACKAGE_PIN K2 [get_ports ylw_light_nrth_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports ylw_light_nrth_s10th_st]

set_property PACKAGE_PIN H1 [get_ports grn_light_nrth_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports grn_light_nrth_s10th_st]

set_property PACKAGE_PIN J2 [get_ports red_light_west_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports red_light_west_s10th_st]

set_property PACKAGE_PIN L2 [get_ports ylw_light_west_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports ylw_light_west_s10th_st]

set_property PACKAGE_PIN J1 [get_ports grn_light_west_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports grn_light_west_s10th_st]

set_property PACKAGE_PIN M2 [get_ports red_light_nrth_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports red_light_nrth_s11th_st]

set_property PACKAGE_PIN L3 [get_ports ylw_light_nrth_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports ylw_light_nrth_s11th_st]

set_property PACKAGE_PIN J3 [get_ports grn_light_nrth_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports grn_light_nrth_s11th_st]

set_property PACKAGE_PIN M1 [get_ports red_light_west_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports red_light_west_s11th_st]

set_property PACKAGE_PIN M3 [get_ports ylw_light_west_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports ylw_light_west_s11th_st]

set_property PACKAGE_PIN K3 [get_ports grn_light_west_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports grn_light_west_s11th_st]

set_property PACKAGE_PIN P17 [get_ports walk_light_west_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports walk_light_west_s10th_st]

set_property PACKAGE_PIN N17 [get_ports stop_light_west_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports stop_light_west_s10th_st]

set_property PACKAGE_PIN R18 [get_ports walk_light_nrth_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports walk_light_nrth_s10th_st]

set_property PACKAGE_PIN P18 [get_ports stop_light_nrth_s10th_st]
set_property IOSTANDARD LVCMOS33 [get_ports stop_light_nrth_s10th_st]

set_property PACKAGE_PIN M19 [get_ports walk_light_west_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports walk_light_west_s11th_st]

set_property PACKAGE_PIN M18 [get_ports stop_light_west_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports stop_light_west_s11th_st]

set_property PACKAGE_PIN L17 [get_ports walk_light_nrth_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports walk_light_nrth_s11th_st]

set_property PACKAGE_PIN K17 [get_ports stop_light_nrth_s11th_st]
set_property IOSTANDARD LVCMOS33 [get_ports stop_light_nrth_s11th_st]

set_property PACKAGE_PIN U16 [get_ports debug_out]
set_property IOSTANDARD LVCMOS33 [get_ports debug_out]

set_property PACKAGE_PIN G3 [get_ports nrth_ped_button]
set_property IOSTANDARD LVCMOS33 [get_ports nrth_ped_button]

set_property PACKAGE_PIN G2 [get_ports west_ped_button]
set_property IOSTANDARD LVCMOS33 [get_ports west_ped_button]

set_property PACKAGE_PIN U18 [get_ports reset_n]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

set_property PACKAGE_PIN U3 [get_ports debug_10n_q]
set_property IOSTANDARD LVCMOS33 [get_ports debug_10n_q]

set_property PACKAGE_PIN V3 [get_ports debug_10w_q]
set_property IOSTANDARD LVCMOS33 [get_ports debug_10w_q]