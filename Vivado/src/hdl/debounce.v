//////////////////////////////////////////////////////////////////////////////////
// Group: 6 
// Engineer: Zach, Tristan, Chris, Yazid, & Anthony
// 
// Two intersection traffic light controller, Debounce module
// 
//////////////////////////////////////////////////////////////////////////////////

module debounce(
  output reg sig_out,   // set output to be a reg to drive more outputs
  input button_n,     //
  input clk_50_mhz    //
);

parameter SETTLE_TIME = 500000;  // adjust as needed (10ms should be good)

reg debounced;
reg [23:0] counter;   // also adjust as needed...

always @(posedge clk_50_mhz) begin
    sig_out <= (sig_out) ? 1 : 0;
    if (button_n != debounced) begin            // if our state has changed
        debounced <= button_n;                  // capture the current input
        counter <= 0;                           // and (re)start the timer
  end else if (counter >= SETTLE_TIME) begin    // times up
        sig_out <= debounced;
        counter <= 0;
  end else begin                                // increment blank time counter
    counter <= counter + 1;
  end
end
endmodule