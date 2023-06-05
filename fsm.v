`define INIT 3'b0
`define GAME 3'd1
`define WIN 3'd2
`define LOSE 3'd3

module fsm(
    input clk,
    input rst,
    output reg[2:0] game_state,
    input [8:0] last_change,
    output reg cnt_enable,
    input [2:0] trophy_cnt,
    input [3:0] time_remain,
    output reg [2:0] show_control,
    output reg game_start
    // {gaming scene, win scene, lose scene}  ex: 100 -> show gameing scene
);
reg [2:0] game_next_state;

always@(posedge clk or posedge rst) begin
    if (rst) begin
        game_state <= 3'b0;
    end
    else begin
        game_state <= game_next_state;
    end
end

always@* begin
    case(game_state)
        `INIT: begin
            if ( (last_change == 9'h1D)||(last_change == 9'h1C)||(last_change == 9'h1B)||(last_change == 9'h23) ) begin
                game_next_state = `GAME;
                cnt_enable = 1'b1;
                show_control = 3'b100;
                game_start = 1'b1;
            end
            else begin
                game_next_state = game_state;
                cnt_enable = 1'b0;
                show_control = 3'b100;
                game_start = 1'b0;
            end
        end
        `GAME: begin
            if (trophy_cnt == 3'b0 && time_remain > 4'b0) begin
                game_next_state = `WIN;
                cnt_enable = 1'b0;
                show_control = 3'b010;
                game_start = 1'b0;
            end
            else if (trophy_cnt > 3'b0 && time_remain == 4'b0) begin
                game_next_state = `LOSE;
                cnt_enable = 1'b0;
                show_control = 3'b001;
                game_start = 1'b0;
            end
            else begin
                game_next_state = game_state;
                cnt_enable = 1'b1;
                show_control = 3'b100;
                game_start = 1'b0;
            end
        end
        `WIN: begin
           game_next_state = game_state;
           cnt_enable = 1'b0;
           show_control = 3'b010;
           game_start = 1'b0;
        end
        `LOSE: begin
            game_next_state = game_state;
            cnt_enable = 1'b0;
            show_control = 3'b001;
            game_start = 1'b0;
        end
        default: begin
            game_next_state = 3'b0;
            cnt_enable = 1'b0;
            show_control = 3'b100;
            game_start = 1'b0;
        end
    endcase
end
endmodule