`timescale 1ns / 1ns

module traffic_light_tb();

// ouputs
wire debug,
    red_0,
    ylw_0,
    grn_0,
    red_1,
    ylw_1,
    grn_1;
// inputs
reg north_crosswalk;
reg  west_crosswalk;
reg reset;
reg clk;

traffic_light_top DUT(
    .debug(debug),
    .red_0(red_0),
    .ylw_0(ylw_0),
    .grn_0(grn_0),
    .red_1(red_1),
    .ylw_1(ylw_1),
    .grn_1(grn_1),
    .north_ped_sig(north_crosswalk),
    .west_ped_sig(west_crosswalk),
    .reset_n(reset),
    .clk(clk)
);

initial begin
    clk = 'b0;
    $monitor("%3d\tN: RYG=%b%b%b W: RYG=%b%b%b",$time,red_0,ylw_0,grn_0,red_1,ylw_1,grn_1);
    #100 $finish;
end

always #1 clk = ~clk;

endmodule
