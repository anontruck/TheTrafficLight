module two_way_intersection(
    output  wire red_0,             // output for red light on light0
    output  wire ylw_0,             // output for yle light on light0
    output  wire grn_0,             // output for grn light on light0
    output  wire red_1,             // output for red light on light1
    output  wire ylw_1,             // output for ylw light on light1
    output  wire grn_1,             // output for grn light on light1
    input   wire crosswalk_0,       // input request from north crosswalk
    input   wire crosswalk_1,       // input request from west crosswalk
    input   wire reset_n,           // input reset
    input   wire clk                // positive edge triggered
);

// ----- local constants -----
// traffic light state parameters
localparam STATE_GRN_RED    = 0;
localparam STATE_YLW_RED    = 1;
localparam STATE_RED_RED    = 2;
localparam STATE_RED_GRN    = 3;
localparam STATE_RED_YLW    = 4;
localparam STATE_RED_RED2   = 5;    // needed for transition
// traffic light on times (counts) parameters
localparam GRN_TON = 40;// 20;
localparam YLW_TON = 6;//3;
localparam RED_TON = 4;//2;
localparam T_CYCLE = GRN_TON + YLW_TON + RED_TON; // cycle time
localparam SLOWDOWN = 20;//10;
// light assignment masks
localparam RED_MSK = 'b100;
localparam YLW_MSK = 'b010;
localparam GRN_MSK = 'b001;

// ----- clock setup -----
parameter N = 22;                   // clock prescale
reg [N+1:0] clk_mod = 'b0;          // internal module clock

// ----- local registers -----
reg [3:0] state     = STATE_GRN_RED;
reg [7:0] timer     = 'b0;
reg [2:0] light0    = 'b0;          // GYR = 3'b000
reg [2:0] light1    = 'b0;          // GYR = 3'b000

// ----- state machine -----
always @(posedge clk_mod[N+1] or posedge reset_n) begin
    if (reset_n) begin         // reset
        light0      <= 3'b0;
        light1      <= 3'b0;
        timer       <= 7'b0;
        state       <= 4'b0;
    end else begin              // state machine
        timer <= timer + 1;
        case (state)
            STATE_GRN_RED : begin
                light0 <= GRN_MSK;
                light1 <= RED_MSK;
                if (crosswalk_0 && (timer <= SLOWDOWN)) begin
                    timer <= (timer + SLOWDOWN);
                end else if (timer >= GRN_TON) begin
                    state <= STATE_YLW_RED;
                end
            end
            STATE_YLW_RED : begin
                light0 <= YLW_MSK;
                light1 <= RED_MSK;
                if (timer >= (GRN_TON + YLW_TON)) begin
                    state <= STATE_RED_RED;
                end
            end
            STATE_RED_RED : begin
                light0 <= RED_MSK;
                light1 <= RED_MSK;
                if (timer >= T_CYCLE) begin
                    state <= STATE_RED_GRN;
                end
            end
            STATE_RED_GRN : begin
                light0 <= RED_MSK;
                light1 <= GRN_MSK;
                if (crosswalk_1 && (timer <= (T_CYCLE + SLOWDOWN))) begin
                    timer <= (timer + SLOWDOWN);
                end else if (timer >= (T_CYCLE + GRN_TON)) begin
                    state <= STATE_RED_YLW;
                end
            end
            STATE_RED_YLW : begin
                light0 <= RED_MSK;
                light1 <= YLW_MSK;
                if (timer >= (T_CYCLE + GRN_TON + YLW_TON)) begin
                    state <= STATE_RED_RED2;
                end
            end
            STATE_RED_RED2 : begin
                light0 <= RED_MSK;
                light1 <= RED_MSK;
                if (timer >= (T_CYCLE + T_CYCLE)) begin
                    state <= STATE_GRN_RED;
                    timer <= 'b0;
                end
            end
            default : begin             // should never happen...
                light0 <= RED_MSK;
                light1 <= RED_MSK;
                state  <= STATE_RED_RED;
                timer  <= 'b0;
            end
         endcase
         
    end
end

assign {red_0, ylw_0, grn_0} = light0;
assign {red_1, ylw_1, grn_1} = light1;

//always @(*) xwalk0_rqst = crosswalk_0;
//always @(*) xwalk1_rqst  = crosswalk_1;

// the clock block
always @ (posedge clk) clk_mod <= clk_mod + 1;

endmodule
