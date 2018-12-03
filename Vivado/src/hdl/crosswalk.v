//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 07:47:04 PM
// Design Name: 
// Module Name: crosswalk
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


module crosswalk(
<<<<<<< HEAD
    output wire walk_light,
    output wire stop_light,
    output wire cross_rqst,
    output wire debug_q,
    input red_trffc_light,
    input ylw_trffc_light,
    input grn_trffc_light,
    input cross_button,
    input reset,
    input clk
);

// ----- local registers -----
reg [7:0] timer     = 'b0;
reg [2:0] state     = 'b0;
reg [1:0] light     = 'b0;       // WR = 2'b000
reg       Q         = 'b0;
reg blink_red       = 'b0;
reg blink_flag      = 'b0;
reg white_flag      = 'b0;
reg useless1        = 'b0;
reg useless2        = 'b0;

// pedestrian light time parameters
localparam WALK_TIME = 10;

// pedestrian light state parameters
localparam STATE_RED        = 0;
localparam STATE_WHITE      = 1;
localparam STATE_BLINK_RED  = 2;
localparam STATE_ERROR      = 3;

assign debug_q = Q;

// ----- state machine -----
always @(posedge blink_flag or posedge red_trffc_light or posedge ylw_trffc_light or posedge grn_trffc_light or posedge reset) begin
    if (reset) begin // always go directly to red on red lights
        state <= STATE_RED;
        white_flag <= 1;
    end else if (red_trffc_light) begin
        state <= STATE_RED;
    end else begin
        if (blink_flag) begin           // check if time to start blinking stop
            if (state == STATE_WHITE) begin
                white_flag <= 0;
                state <= STATE_BLINK_RED;
            end else begin
                state <= (state == STATE_RED) ? STATE_RED : STATE_BLINK_RED;
            end
        end else if (grn_trffc_light) begin
            if (state == STATE_RED) begin
                state <= (Q) ? STATE_WHITE : STATE_RED;
            end else begin
                state <= (state == STATE_WHITE) ? STATE_WHITE : STATE_BLINK_RED;
            end
        end else if (ylw_trffc_light) begin
            white_flag <= 1;
            if (state == STATE_BLINK_RED) begin
                state <= STATE_RED;
            end else begin
                state <= (state == STATE_RED) ? STATE_RED : STATE_ERROR;
            end
        end else begin
            state <= STATE_ERROR;
        end
    end
end

always @(negedge cross_button or negedge white_flag) begin
    if (!white_flag) begin
        Q <= 0;
    end else if (!cross_button) begin
        Q <= ((state == STATE_RED) || (state == STATE_BLINK_RED)) ? 1 : 0;
    end else begin
        Q <= Q ? 1 : 0;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        light           <= 2'b00;
        timer           <= 0;
        blink_red       <= 0;
    end else begin
        case(state)
            STATE_RED       :   begin
                timer       <= 0;
                blink_red   <= 1;
                light       <= 2'b10;
            end
            STATE_WHITE     :   begin
                timer       <= timer + 1;
                blink_red   <= 1;
                light       <= 2'b01;
                if (timer >= WALK_TIME) begin
                    blink_flag <= 1;
                end else begin
                    blink_flag <= 0;
                end
            end
            STATE_BLINK_RED :   begin
                timer       <= 0;
                blink_red   <= ~blink_red;
                blink_flag  <= 0;
                light       <= 2'b10;
            end
            default         :   begin
                timer       <= 0;
                blink_red   <= 1;
                light       <= 2'b11;
            end
        endcase
    end
end

//assign {walk_light, stop_light} = light;
assign walk_light = light[0];
assign stop_light = light[1] & blink_red;
assign cross_rqst = white_flag;

endmodule
=======
    output reg walk_light,
    output reg stop_light,
    input red_trffc_light,
    input ylw_trffc_light,
    input clk    
);
endmodule
>>>>>>> parent of 0647494... Crosswalk in progress
