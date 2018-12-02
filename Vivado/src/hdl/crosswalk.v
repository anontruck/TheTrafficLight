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
    output wire walk_light,
    output wire stop_light,
    input wire red_trffc_light,
    input wire ylw_trffc_light,
    input wire grn_trffc_light,
    input wire cross_button,
    input wire clk
);

// ----- local registers -----
reg [7:0] timer     = 'b0;
reg [3:0] state     = 'b0;
reg [1:0] light     = 'b0;       // WR = 2'b000
reg       Q         = 'b0;
reg   green_edge    = 'b0;
reg   clear_edge    = 'b0;

// pedestrian light time parameters
localparam WALK_TIME = 10;

// pedestrian light state parameters
localparam STATE_RED        = 0;
localparam STATE_WHITE      = 1;
localparam STATE_BLINK_RED  = 2;

// ----- state machine -----
always @(posedge clk or posedge red_trffc_light) begin
    if(red_trffc_light) begin
        light <= 2'b01;
        clear_edge <= 'b1;
        state <= STATE_RED;
    end
    else begin
        case(state)
            STATE_RED: begin
                light <= 2'b01;
                clear_edge <= 'b0;
                if (cross_button) begin
                    Q <= 'b1;
                end
                if (green_edge && Q) begin
                    timer <= 'b0;
                    Q <= 'b0;
                    clear_edge <= 'b1;
                    state <= STATE_WHITE;
                end
                end
            STATE_WHITE: begin
                light <= 2'b10;
                clear_edge <= 'b0;
                timer <= timer + 1;
                if (timer > WALK_TIME) begin
                    light <= 2'b00;
                    clear_edge <= 'b1;
                    state <= STATE_BLINK_RED;
                end
                end
            STATE_BLINK_RED: begin
                light <= light ^ 2'b01;
                clear_edge <= 'b0;
                if(ylw_trffc_light) begin
                    clear_edge <= 'b1;
                    state <= STATE_RED;
                end
                end
            default: begin
                light <= 2'b01;
                state <= STATE_RED;
                Q <= 'b0;
                end
        endcase
    end
end

always @(posedge grn_trffc_light or posedge clear_edge) begin
    if (clear_edge) begin
        green_edge <= 'b0;
    end else begin
        green_edge <= 'b1;
    end
end

assign {walk_light, stop_light} = light;

endmodule