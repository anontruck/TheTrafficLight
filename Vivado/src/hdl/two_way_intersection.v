//////////////////////////////////////////////////////////////////////////////////
// Group: 6 
// Engineer: Zach, Tristan, Chris, Yazid, & Anthony
// 
// Two intersection traffic light controller, intersection controller module
// 
//////////////////////////////////////////////////////////////////////////////////

module two_way_intersection(
    output  wire reda_0,             // output for red light on light0
    output  wire ylwa_0,             // output for yle light on light0
    output  wire grna_0,             // output for grn light on light0
    output  wire reda_1,             // output for red light on light1
    output  wire ylwa_1,             // output for ylw light on light1
    output  wire grna_1,             // output for grn light on light1
    output  wire redb_0,             // output for red light on light0
    output  wire ylwb_0,             // output for yle light on light0
    output  wire grnb_0,             // output for grn light on light0
    output  wire redb_1,             // output for red light on light1
    output  wire ylwb_1,             // output for ylw light on light1
    output  wire grnb_1,             // output for grn light on light1
    output  wire debug_10n_q,// DEBUG
    output  wire debug_10w_q,// DEBUG
    output  wire walka_0,
    output  wire stopa_0,
    output  wire walka_1,
    output  wire stopa_1,
    output  wire walkb_0,
    output  wire stopb_0,
    output  wire walkb_1,
    output  wire stopb_1,
    input crosswalk_0,              // request from north crosswalk
    input crosswalk_1,              // request from west crosswalk
    input reset_n,                  // active low reset
    input clk                       // posedge trigger
);

parameter SHIFT = 4;


// ----- local constants -----

// traffic light state parameters
localparam STATE_GRN_RED  = 0;
localparam STATE_YLW_RED  = 1;
localparam STATE_RED_RED  = 2;
localparam STATE_RED_GRN  = 3;
localparam STATE_RED_YLW  = 4;
localparam STATE_RED_RED2 = 5;    // for transition between lights
// traffic light on times (counts) parameters
localparam GRN_TON = 20;
localparam YLW_TON = 3;
localparam RED_TON = 2;
localparam T_CYCLE = GRN_TON + YLW_TON + RED_TON; // cycle time
localparam SLOWDOWN = 10;
// light assignment masks
localparam OFF_MSK = 'b000;
localparam RED_MSK = 'b100;
localparam YLW_MSK = 'b010;
localparam GRN_MSK = 'b001;
localparam ERR_MSK = 'b111;


// ----- local registers -----
reg [7:0] timer     = 'b0;
reg [3:0] state_a   = 'b0;
reg [3:0] state_b   = 'b0;
reg [2:0] lighta_0  = 'b0;       // GYR = 3'b000
reg [2:0] lighta_1  = 'b0;       // GYR = 3'b000
reg [2:0] lightb_0  = 'b0;
reg [2:0] lightb_1  = 'b0;

reg crossing_0_flag;
reg crossing_1_flag;

wire cross_rqst_a_0;
wire cross_rqst_a_1;
wire cross_rqst_b_0;
wire cross_rqst_b_1;
wire not_cross_0;
wire not_cross_1;
wire cross_0_rqst;
wire cross_1_rqst;

reg [7:0] cross_timera_0  = 'b0;
reg [7:0] cross_timera_1  = 'b0;
reg [7:0] cross_timerb_0  = 'b0;
reg [7:0] cross_timerb_1  = 'b0;
reg walka_0_simp  = 'b0;
reg stopa_0_simp  = 'b1;
reg walka_1_simp  = 'b0;
reg stopa_1_simp  = 'b1;
reg walkb_0_simp  = 'b0;
reg stopb_0_simp  = 'b1;
reg walkb_1_simp  = 'b0;
reg stopb_1_simp  = 'b1;

//simple ped lights (on when green, off when red or yellow)
assign walka_0 = walka_0_simp;
assign stopa_0 = stopa_0_simp;

assign walka_1 = walka_1_simp;
assign stopa_1 = stopa_1_simp;

assign walkb_0 = walkb_0_simp;
assign stopb_0 = stopb_0_simp;

assign walkb_1 = walkb_1_simp;
assign stopb_1 = stopb_1_simp;

always @(posedge clk) begin
    // 10th street
    if (state_a == STATE_GRN_RED) begin
        if (cross_timera_0 <=7) begin
            walka_0_simp <= 'b1;
            stopa_0_simp <= 'b0;
            cross_timera_0 = cross_timera_0 + 1;
        end else begin
            walka_0_simp <= 'b0;
            stopa_0_simp <= ~stopa_0_simp;
        end
    end
    else begin
        walka_0_simp <= 'b0;
        stopa_0_simp <= 'b1;
        cross_timera_0 <= 'b0;
    end
    
    if (state_a == STATE_RED_GRN) begin
        if (cross_timera_1 <=7) begin
            walka_1_simp <= 'b1;
            stopa_1_simp <= 'b0;
            cross_timera_1 = cross_timera_1 + 1;
        end else begin
            walka_1_simp <= 'b0;
            stopa_1_simp <= ~stopa_1_simp;
        end
    end
    else begin
        walka_1_simp <= 'b0;
        stopa_1_simp <= 'b1;
        cross_timera_1 <= 'b0;
    end
    
    // 11th street
    if (state_b == STATE_GRN_RED) begin
        if (cross_timerb_0 <=7) begin
            walkb_0_simp <= 'b1;
            stopb_0_simp <= 'b0;
            cross_timerb_0 = cross_timerb_0 + 1;
        end else begin
            walkb_0_simp <= 'b0;
            stopb_0_simp <= ~stopb_0_simp;
        end
    end
    else begin
        walkb_0_simp <= 'b0;
        stopb_0_simp <= 'b1;
        cross_timerb_0 <= 'b0;
    end
    
    if (state_b == STATE_RED_GRN) begin
        if (cross_timerb_1 <=7) begin
            walkb_1_simp <= 'b1;
            stopb_1_simp <= 'b0;
            cross_timerb_1 = cross_timerb_1 + 1;
        end else begin
            walkb_1_simp <= 'b0;
            stopb_1_simp <= ~stopb_1_simp;
        end
    end
    else begin
        walkb_1_simp <= 'b0;
        stopb_1_simp <= 'b1;
        cross_timerb_1 <= 'b0;
    end
end


assign debug_10w_q = crosswalk_0;

//assign not_cross_0 = ~crosswalk_0;
//assign not_cross_1 = ~crosswalk_1;
assign cross_0_rqst = ~cross_rqst_a_0;
assign cross_1_rqst = cross_rqst_a_1 || cross_rqst_b_1;

// ----- state machine -----
always @(posedge clk or posedge reset_n) begin
    if (reset_n) begin         // reset
        lighta_0    <= OFF_MSK;
        lighta_1    <= OFF_MSK;
        state_a     <= STATE_GRN_RED;
        timer       <= 7'b0;
    end else begin              // state machine
        timer <= timer + 1;
        case (state_a)
            STATE_GRN_RED : begin
                lighta_0 <= GRN_MSK;
                lighta_1 <= RED_MSK;
                if (!crosswalk_1 && (timer <= SLOWDOWN) && (timer >= SHIFT)) begin
//                if (cross_0_rqst && (timer <= SLOWDOWN) && (timer >= SHIFT)) begin
                    timer <= (timer + SLOWDOWN);
                end else if (timer >= GRN_TON) begin
                    state_a <= STATE_YLW_RED;
                end
            end
            STATE_YLW_RED : begin
                lighta_0 <= YLW_MSK;
                lighta_1 <= RED_MSK;
                if (timer >= (GRN_TON + YLW_TON)) begin
                    state_a <= STATE_RED_RED;
                end
            end
            STATE_RED_RED : begin
                lighta_0 <= RED_MSK;
                lighta_1 <= RED_MSK;
                if (timer >= T_CYCLE) begin
                    state_a <= STATE_RED_GRN;
                end
            end
            STATE_RED_GRN : begin
                lighta_0 <= RED_MSK;
                lighta_1 <= GRN_MSK;
                if (!crosswalk_0 && (timer <= (T_CYCLE + SLOWDOWN)) && (timer >= T_CYCLE)) begin
//                if (cross_1_rqst && (timer <= (T_CYCLE + SLOWDOWN)) && (timer >= T_CYCLE)) begin
                    timer <= (timer + SLOWDOWN);
                end else if (timer >= (T_CYCLE + GRN_TON)) begin
                    state_a <= STATE_RED_YLW;
                end
            end
            STATE_RED_YLW : begin 
                lighta_0 <= RED_MSK;
                lighta_1 <= YLW_MSK;
                if (timer >= (T_CYCLE + GRN_TON + YLW_TON)) begin
                    state_a <= STATE_RED_RED2;
                end
            end
            STATE_RED_RED2 : begin
                lighta_0 <= RED_MSK;
                lighta_1 <= RED_MSK;
                if (timer >= (T_CYCLE + T_CYCLE)) begin
                    state_a <= STATE_GRN_RED;
                    timer <= 'b0;
                end
            end
            default : begin             // should never happen...
                lighta_0 <= ERR_MSK;
                lighta_1 <= ERR_MSK;
//                state  <= STATE_GRN_RED;
            end
         endcase
         
    end
end

always @ (posedge clk or posedge reset_n) begin
    if (reset_n) begin
        lightb_0    <= OFF_MSK;
        lightb_1    <= OFF_MSK;
        state_b     <= STATE_GRN_RED;
    end else begin
        case (state_b)
            STATE_GRN_RED : begin
                lightb_0 <= GRN_MSK;
                lightb_1 <= RED_MSK;
                if (timer >= GRN_TON + SHIFT) begin
                    state_b <= STATE_YLW_RED;
                end
            end
            STATE_YLW_RED : begin
                lightb_0 <= YLW_MSK;
                lightb_1 <= RED_MSK; 
                if (timer >= GRN_TON + YLW_TON + SHIFT) begin
                    state_b <= STATE_RED_RED;
                end
            end
            STATE_RED_RED : begin
                lightb_0 <= RED_MSK;
                lightb_1 <= RED_MSK;
                if (timer >= T_CYCLE + SHIFT) begin
                    state_b <= STATE_RED_GRN;
                end
            end
            STATE_RED_GRN : begin
                lightb_0 <= RED_MSK;
                lightb_1 <= GRN_MSK;
                if (timer >= T_CYCLE + GRN_TON + SHIFT) begin
                    state_b <= STATE_RED_YLW;
                end
            end
            STATE_RED_YLW : begin
                lightb_0 <= RED_MSK;
                lightb_1 <= YLW_MSK;
                if (timer >= 2 && timer < (T_CYCLE + T_CYCLE - 2)) begin
                    state_b <= STATE_RED_RED2;
                end
            end
            STATE_RED_RED2 : begin
                lightb_0 <= RED_MSK;
                lightb_1 <= RED_MSK;
                if (timer >= SHIFT) begin
                    state_b <= STATE_GRN_RED;
                end
            end
            default : begin
                lightb_0 <= ERR_MSK;
                lightb_1 <= ERR_MSK;
            end
        endcase
    end
end 

assign {reda_0, ylwa_0, grna_0} = lighta_0;
assign {reda_1, ylwa_1, grna_1} = lighta_1;
assign {redb_0, ylwb_0, grnb_0} = lightb_0;
assign {redb_1, ylwb_1, grnb_1} = lightb_1;

endmodule