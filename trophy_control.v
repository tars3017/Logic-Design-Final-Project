module trophy_control (
    input clk,
    input rst,
    input [4:0] row,
    input [4:0] column,
    output reg [2:0] trophy_cnt,
    output reg [4:0] trophy0_r, trophy0_c, trophy1_r, trophy1_c, trophy2_r, trophy2_c,
    input [26:0] count_5M,
    input game_start
);

reg [2:0] trophy_cnt_next;
//reg [4:0] trophy0_r, trophy0_c, trophy1_r, trophy1_c, trophy2_r, trophy2_c;
reg [4:0] trophy0_r_next, trophy0_c_next, trophy1_r_next, trophy1_c_next, trophy2_r_next, trophy2_c_next;
wire [4:0] rand0_r, rand0_c, rand1_r, rand1_c, rand2_r, rand2_c;

lfsr random0_r(.clk(clk), .rst(rst), .random_out(rand0_r), .range(5'd18), .gen(1'b1), .seed(count_5M[4:0] | 5'b10001));
lfsr random0_c(.clk(clk), .rst(rst), .random_out(rand0_c), .range(5'd26), .gen(1'b1), .seed(count_5M[7:3] | 5'b00010));

lfsr random1_r(.clk(clk), .rst(rst), .random_out(rand1_r), .range(5'd18), .gen(1'b1), .seed(count_5M[16:12] | 5'b01100));
lfsr random1_c(.clk(clk), .rst(rst), .random_out(rand1_c), .range(5'd26), .gen(1'b1), .seed(count_5M[10:6] | 5'b01100));

lfsr random2_r(.clk(clk), .rst(rst), .random_out(rand2_r), .range(5'd18), .gen(1'b1), .seed(count_5M[12:8] | 5'b01000));
lfsr random2_c(.clk(clk), .rst(rst), .random_out(rand2_c), .range(5'd26), .gen(1'b1), .seed(count_5M[25:21] | 5'b10010));




always@ (posedge clk or posedge rst) begin
    if (rst) begin
        trophy_cnt <= 3'b111;
        trophy0_r <= 5'd23;
        trophy0_c <= 5'd31;
        trophy1_r <= 5'd23;
        trophy1_c <= 5'd31;
        trophy2_r <= 5'd23;
        trophy2_c <= 5'd31;    
    end
    else begin
        trophy_cnt <= trophy_cnt_next;
        trophy0_r <= trophy0_r_next;
        trophy0_c <= trophy0_c_next;
        trophy1_r <= trophy1_r_next;
        trophy1_c <= trophy1_c_next;
        trophy2_r <= trophy2_r_next;
        trophy2_c <= trophy2_c_next;        
    end
end

always@* begin
    if (game_start) begin
        trophy0_r_next = rand0_r;
        trophy0_c_next = rand0_c;
        trophy1_r_next = rand1_r;
        trophy1_c_next = rand1_c;
        trophy2_r_next = rand2_r;
        trophy2_c_next = rand2_c;
    end
    else begin
        trophy0_r_next = trophy0_r;
        trophy0_c_next = trophy0_c;
        trophy1_r_next = trophy1_r;
        trophy1_c_next = trophy1_c;
        trophy2_r_next = trophy2_r;
        trophy2_c_next = trophy2_c;        
    end
end
always@* begin
    if (trophy_cnt[0] == 1'b1 && row == trophy0_r && column == trophy0_c) begin
        trophy_cnt_next[0] = 1'b0;
    end
    else begin
        trophy_cnt_next[0] = trophy_cnt[0];
    end
    
    if (trophy_cnt[1] == 1'b1 && row == trophy1_r && column == trophy1_c) begin
        trophy_cnt_next[1] = 1'b0;
    end
    else begin
        trophy_cnt_next[1] = trophy_cnt[1];
    end    
    
    if (trophy_cnt[2] == 1'b1 && row == trophy2_r && column == trophy2_c) begin
        trophy_cnt_next[2] = 1'b0;
    end
    else begin
        trophy_cnt_next[2] = trophy_cnt[2];
    end
end
endmodule