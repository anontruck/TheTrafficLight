set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name external_clock -period 100.00 [get_ports clk]

set_property PACKAGE_PIN P18 [get_ports grn_0]
set_property IOSTANDARD LVCMOS33 [get_ports grn_0]

set_property PACKAGE_PIN R18 [get_ports grn_1]
set_property IOSTANDARD LVCMOS33 [get_ports grn_1]

set_property PACKAGE_PIN M18 [get_ports red_0]
set_property IOSTANDARD LVCMOS33 [get_ports red_0]

set_property PACKAGE_PIN M19 [get_ports red_1]
set_property IOSTANDARD LVCMOS33 [get_ports red_1]

set_property PACKAGE_PIN N17 [get_ports ylw_0]
set_property IOSTANDARD LVCMOS33 [get_ports ylw_0]

set_property PACKAGE_PIN P17 [get_ports ylw_1]
set_property IOSTANDARD LVCMOS33 [get_ports ylw_1]

set_property PACKAGE_PIN T18 [get_ports north_ped_sig]
set_property IOSTANDARD LVCMOS33 [get_ports north_ped_sig]

set_property PACKAGE_PIN T17 [get_ports west_ped_sig]
set_property IOSTANDARD LVCMOS33 [get_ports west_ped_sig]

set_property PACKAGE_PIN U18 [get_ports reset_n]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]