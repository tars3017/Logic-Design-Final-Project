module top(
    input clk,
    input rst,
    output reg[3:0] vgaRed,
    output reg[3:0] vgaGreen,
    output reg[3:0] vgaBlue,
    output hsync,
    output vsync,
    input btn_mid,
    input btn_up,
    output [3:0] ssd_ctl,
    output [7:0] segs,
    
    // for Keyboard Decoder
    inout  PS2_DATA,
    inout  PS2_CLK,
    
    // for maps
    output [4:0]row,    //up and down
    output [4:0]column,  //left and right
    output [3:0]locate,
    
    input sel_seven_display,
    input sel_random_display
);

wire clk_25MHz, clk_10Hz, clk_1Hz, clk_22, clk_2k, clk_100; // clock_divisor
wire [26:0] count_5M; // for random seed
wire [9:0] v_cnt, h_cnt; // mem_addr_gen
//wire [16:0] pixel_addr; // mem_addr_gen
wire valid; // vga_controller
wire [11:0] pixel_maze, pixel_guy, pixel_trophy0, pixel_trophy1, pixel_trophy2; // blk_mem_gen_maze
wire [11:0] pixel_win, pixel_lose;
// maze: 320*240 (maze cell 32*24)
// guy: 26*26
// one cell in maze 20*20
wire [4:0] row_pos, col_pos; // for the character's position
wire in_range;
wire trophy0_in_range, trophy1_in_range, trophy2_in_range;
wire lose_in_range, win_in_range;

// for stopwatch
wire [3:0] small_sec0, small_sec1, sec0, sec1, min0, min1;

// for seven segment display
wire [3:0] ssd_in;
reg [3:0] in0, in1, in2, in3;

// for btn to switch seven segment display
reg display_state;
reg display_next_state;
reg btn_up_delay;
wire btn_up_fnl;

// fsm (for game flow control)
wire cnt_enable;
wire [2:0] game_state;
wire game_start;
wire [2:0] show_control; // {gaming scene, win scene, lose scene}  ex: 100 -> show gameing scene

// trophy control
wire [2:0] trophy_cnt;
wire [4:0] trophy0_r, trophy0_c, trophy1_r, trophy1_c, trophy2_r, trophy2_c;

//assign trophy0_r = 5'd3;
//assign trophy0_c = 5'd3;

//assign trophy1_r = 5'd10;
//assign trophy1_c = 5'd10;

//assign trophy2_r = 5'd20;
//assign trophy2_c = 5'd22;
// for Keyboard Decoder
wire key_valid;
wire [8:0] last_change;
wire [511:0] key_down;

// maps
wire move;


wire [3:0]row1;
wire [3:0]row2;
wire [3:0]col1;
wire [3:0]col2;

assign row_pos = row;
assign col_pos = column;
assign in_range =(h_cnt >= (col_pos * 20) + 2 && h_cnt < (col_pos + 1) * 20  - 1 && v_cnt >= (row_pos * 20) + 1 && v_cnt < (row_pos + 1)* 20 - 1); 
assign trophy0_in_range = (h_cnt >= (trophy0_c * 20) + 2 && h_cnt < (trophy0_c + 1) * 20  - 1 && v_cnt >= (trophy0_r * 20) + 1 && v_cnt < (trophy0_r + 1)* 20 - 1);
assign trophy1_in_range = (h_cnt >= (trophy1_c * 20) + 2 && h_cnt < (trophy1_c + 1) * 20  - 1 && v_cnt >= (trophy1_r * 20) + 1 && v_cnt < (trophy1_r + 1)* 20 - 1);
assign trophy2_in_range = (h_cnt >= (trophy2_c * 20) + 2 && h_cnt < (trophy2_c + 1) * 20  - 1 && v_cnt >= (trophy2_r * 20) + 1 && v_cnt < (trophy2_r + 1)* 20 - 1);
assign win_in_range = (h_cnt >= 73 && h_cnt <= 568) && (v_cnt >= 89 && v_cnt <= 389);
assign lose_in_range = (h_cnt >= 43 && h_cnt <= 598) && (v_cnt >= 133 && v_cnt <= 345);

always@* begin
    case(show_control) 
        3'b100: begin
            // output game scene here
            if (!valid)  {vgaRed, vgaGreen, vgaBlue} = 12'h0;
            else if (in_range && pixel_guy != 12'hfff) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
            else if (game_state == 3'd1 && trophy_cnt[0] && trophy0_in_range && (column != trophy0_c || row != trophy0_r) && pixel_trophy0 != 12'hfff) {vgaRed, vgaGreen, vgaBlue} = 12'h771;
            else if (game_state == 3'd1 && trophy_cnt[1] && trophy1_in_range && (column != trophy1_c || row != trophy1_r) && pixel_trophy1 != 12'hfff) {vgaRed, vgaGreen, vgaBlue} = 12'hf0a;
            else if (game_state == 3'd1 && trophy_cnt[2] && trophy2_in_range && (column != trophy2_c || row != trophy2_r) && pixel_trophy2 != 12'hfff) {vgaRed, vgaGreen, vgaBlue} = 12'h50d;
            else if (pixel_maze == 1'b1) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
            else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
        end
        3'b010: begin
            // ouput win scene here
            if (!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h0;
            else if (win_in_range && pixel_win != 12'h000) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
            else if (win_in_range && pixel_win == 12'h000) {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
        end
        3'b001: begin
            // output lose scene here
            if (!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h0;
            else if (lose_in_range && pixel_lose != 12'h000) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
            else if (lose_in_range && pixel_lose == 12'h000) {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
        end
        default: begin      
            if (!valid)  {vgaRed, vgaGreen, vgaBlue} = 12'h0;
            else if (in_range && pixel_guy != 12'hfff) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
            else if (trophy_cnt[0] && trophy0_in_range && (column != trophy0_c || row != trophy0_r) && pixel_trophy0 != 12'hfff) {vgaRed, vgaGreen, vgaBlue} = 12'h771;
            else if (trophy_cnt[1] && trophy1_in_range && (column != trophy1_c || row != trophy1_r) && pixel_trophy1 != 12'hfff) {vgaRed, vgaGreen, vgaBlue} = 12'hf0a;
            else if (trophy_cnt[2] && trophy2_in_range && (column != trophy2_c || row != trophy2_r) && pixel_trophy2 != 12'hfff) {vgaRed, vgaGreen, vgaBlue} = 12'h50d;
            else if (pixel_maze == 1'b1) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
            else {vgaRed, vgaGreen, vgaBlue} = 12'h000;  
        end
    endcase
end
clock_divisor clk_wiz_0_inst(
    .clk(clk),
    .clk1(clk_25MHz),
    .clk22(clk_22),
    .clk_10Hz(clk_10Hz),
    .clk_1Hz(clk_1Hz),
    .clk_2k(clk_2k),
    .clk_100(clk_100),
    .count_5M(count_5M)
);

//mem_addr_gen mem_addr_gen_inst(
//    .clk(clk),
//    .rst(rst),
//    .h_cnt(h_cnt),
//    .v_cnt(v_cnt),
//    .pixel_addr(pixel_addr),
//    .row_pos(row_pos),
//    .col_pos(col_pos)
//);

vga_controller vga_inst(
    .pclk(clk_25MHz),
    .reset(rst),
    .hsync(hsync),
    .vsync(vsync),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .valid(valid)
);

blk_mem_gen_maze blk_mem_gen_maze(
    .clka(clk_25MHz),
    .wea(0),
    .addra( (h_cnt) + 640 * (v_cnt) ),
    .dina(),
    .douta(pixel_maze)
);

blk_mem_gen_guy blk_mem_gen_guy(
    .clka(clk_25MHz),
    .wea(0),
    .addra( (h_cnt - col_pos * 20 + 1) + (v_cnt - row_pos * 20 - 1) * 18),
    .dina(),
    .douta(pixel_guy)
);

blk_mem_gen_trophy blk_mem_gen_trophy0(
    .clka(clk_25MHz),
    .wea(0),
    .addra( (h_cnt - trophy0_c * 20 + 1) + (v_cnt - trophy0_r * 20 - 1) * 18),
    .dina(),
    .douta(pixel_trophy0)
);

blk_mem_gen_trophy blk_mem_gen_trophy1(
    .clka(clk_25MHz),
    .wea(0),
    .addra( (h_cnt - trophy1_c * 20 + 1) + (v_cnt - trophy1_r * 20 - 1) * 18),
    .dina(),
    .douta(pixel_trophy1)
);

blk_mem_gen_trophy blk_mem_gen_trophy2(
    .clka(clk_25MHz),
    .wea(0),
    .addra( (h_cnt - trophy2_c * 20 + 1) + (v_cnt - trophy2_r * 20 - 1) * 18),
    .dina(),
    .douta(pixel_trophy2)
);

blk_mem_gen_win blk_mem_gen_win(
    .clka(clk_25MHz),
    .wea(0),
    .addra( (h_cnt - 73) + (v_cnt - 89) * 495),
    .dina(),
    .douta(pixel_win)
);

blk_mem_gen_lose blk_mem_gen_lose(
    .clka(clk_25MHz),
    .wea(0),
    .addra( (h_cnt - 43) + (v_cnt - 133) * 555),
    .dina(),
    .douta(pixel_lose)
);

// stopwatch to calculate time
stopwatch(
    .small_sec0(small_sec0),
    .small_sec1(small_sec1),
    .sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .clk(clk_100),
    .rst(rst),
    .btn_origin(btn_mid),
    .clk_10Hz(clk_10Hz),
    .cnt_enable(cnt_enable)
);

// seven segment display
scan_ctl(
    .ssd_ctl(ssd_ctl),
    .ssd_in(ssd_in),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .ssd_ctl_en(clk_2k),
    .rst(rst)
);


display(
    .bin(ssd_in),
    .segs(segs)
);

always @* begin
    if (sel_seven_display) begin
        in0 = row1;
        in1 = row2;
        in2 = col1;
        in3 = col2;
    end
    else if (display_next_state) begin
        in0 = small_sec0;
        in1 = small_sec1;
        in2 = 4'd10;
        in3 = 4'd10;
    end
    else if (sel_random_display) begin
        in0 = trophy0_r%10;
        in1 = trophy0_r/10;
        in2 = trophy0_c%10;
        in3 = trophy0_c/10;
    end
    else begin
        in0 = sec0;
        in1 = sec1;
        in2 = min0;
        in3 = min1;
    end
end

// btn to switch seven segment display
always@(posedge clk_10Hz) btn_up_delay <= btn_up;
assign btn_up_fnl = (~btn_up_delay) & btn_up;

always@(posedge clk_10Hz or posedge rst) begin
    if (rst) begin
        display_state <= 1'b0;
    end
    else begin
        display_state <= display_next_state;
    end
end

always@* begin
    if (btn_up_fnl) begin
        display_next_state = ~display_state;
    end
    else begin
        display_next_state = display_state;
    end
end

KeyboardDecoder U0(.key_down(key_down),.last_change(last_change),.key_valid(key_valid),.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),.rst(rst),.clk(clk));
maps U1(.locate(locate),.clk(clk),.rst(rst),.key_down(key_down),.last_change(last_change),.key_valid(key_valid),.row(row),.column(column), .move(move));

assign col2 = column/10;
assign col1 = column%10;
assign row2 = row/10;
assign row1 = row%10;

fsm(
    .clk(clk),
    .rst(rst),
    .game_state(game_state),
    .last_change(last_change),
    .cnt_enable(cnt_enable),
    .trophy_cnt(trophy_cnt),
    .time_remain(small_sec0 | small_sec1 | sec0 | sec1 | min0 | min1),
    .show_control(show_control),
    .game_start(game_start)
);

trophy_control (
    .clk(clk),
    .rst(rst),
    .row(row),
    .column(column),
    .trophy_cnt(trophy_cnt),
    .trophy0_r(trophy0_r),
    .trophy0_c(trophy0_c),
    .trophy1_r(trophy1_r),
    .trophy1_c(trophy1_c),
    .trophy2_r(trophy2_r),
    .trophy2_c(trophy2_c),
    .count_5M(count_5M),
    .game_start(game_start)
);
endmodule