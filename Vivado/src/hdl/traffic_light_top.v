//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
    output  wire debug,
    output  wire red_0,             // output for red light on light0
    output  wire ylw_0,             // output for yle light on light0
    output  wire grn_0,             // output for grn light on light0
    output  wire red_1,             // output for red light on light1
    output  wire ylw_1,             // output for ylw light on light1
    output  wire grn_1,             // output for grn light on light1
    input   wire north_ped_sig,     // request from north crosswalk
    input   wire west_ped_sig,      // request from west crosswalk
    input   wire reset_n,           // active low reset
    input   wire clk                // posedge trigger
);

two_way_intersection two_way(
    .debug(debug),
    .red_0(red_0),
    .ylw_0(ylw_0),
    .grn_0(grn_0),
    .red_1(red_1),
    .ylw_1(ylw_1),
    .grn_1(grn_1),
    .crosswalk_0(north_ped_sig),
    .crosswalk_1(west_ped_sig),
    .reset_n(reset_n),
    .clk(clk)
);
    
endmodule
