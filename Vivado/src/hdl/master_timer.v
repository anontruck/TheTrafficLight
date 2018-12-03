module master_timer(
   output reg clk_mstr,     //
   input enable_n,          //
   input clk_50_mhz         // 50MHz 
);

parameter COUNT = 25000000-1;
parameter BITS = 25;
reg [BITS-1:0] counter;
reg clk_out;

initial begin
    clk_mstr <= 0;
    counter <= 0;
    clk_out <= 0;
end

always @(posedge clk_50_mhz) begin
   if(enable_n) begin
      if(counter >= COUNT) begin
         counter <= 0;
         clk_out <= ~clk_out;
      end else begin
         counter <= counter + 1;
      end
   end else begin
      counter <= 0;
      clk_out <= 0;
   end
end

//assign clk_mstr = clk_out;
always @(*) clk_mstr <= clk_out;

endmodule