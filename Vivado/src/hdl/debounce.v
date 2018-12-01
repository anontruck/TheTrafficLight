module debounce(
  output  sig_out,    //
  input   button_n,   //
  input   reset_n,    //:
  input   clk         //
);

parameter SETTLE_TIME = 100000;  // adjust as needed (10ms should be good)

reg sig_out;          // set output to be a reg to drive more outputs
reg debounced;
reg [23:0] counter;   // also adjust as needed...

initial begin
  counter <= 0;
  sig_out <= button_n;
  debounced <= button_n;
end

always @(posedge clk) begin
  if (~reset_n) begin
    counter <= 0;
    sig_out <= 0;
    debounced <= 0;
  end else if (button_n != debounced) begin   // if our state has changed
    debounced <= button_n;                    // capture the current input
    counter <= 0;                             // and (re)start the timer
  end else if (counter >= SETTLE_TIME) begin  // times up
    sig_out <= debounced;
    counter <= 0;
  end else begin                              // increment blank time counter
    counter <= counter + 1;
  end
end

endmodule