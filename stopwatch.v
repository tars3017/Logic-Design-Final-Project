`define BCD_BIT_WIDTH 4
module stopwatch(
  output [`BCD_BIT_WIDTH-1:0] small_sec0,
  output [`BCD_BIT_WIDTH-1:0] small_sec1,
  output [`BCD_BIT_WIDTH-1:0] sec0,
  output [`BCD_BIT_WIDTH-1:0] sec1,
  output [`BCD_BIT_WIDTH-1:0] min0,
  output [`BCD_BIT_WIDTH-1:0] min1,
  input clk,
  input rst,
  input btn_origin,
  input clk_10Hz,
  input [4:0] row,
  input [4:0] column,
  input key_valid,
  input [8:0] last_change
);

wire carry_small_sec0, carry_small_sec1, carry_sec0, carry_sec1, carry_min0;
wire btn;
reg btn_delay, start_state, next_state;
reg  game_state, game_next_state;


// FSM
always@(posedge clk_10Hz) begin
    btn_delay <= btn_origin;
end
assign btn = (~btn_delay) & btn_origin;

always@(posedge clk_10Hz or posedge rst) begin
    if (rst) begin
        start_state <= 1'b0; // use btn_mid to control
        game_state <= 1'b0; // when user start to move will trigger it
    end
    else begin
        start_state <= next_state;
        game_state <= game_next_state;
    end
end

always @* begin
    if (btn) begin
        next_state = ~start_state;
    end
    else begin
        next_state = start_state;
    end
end

always @* begin
    if (((last_change == 9'h1D)||(last_change == 9'h1C)||(last_change == 9'h1B)||(last_change == 9'h23)) && game_state == 1'b0) begin
        game_next_state = 1'b1;
    end
    else if ( ((last_change == 9'h1D)||(last_change == 9'h1C)||(last_change == 9'h1B)||(last_change == 9'h23)) && row == 5'd31 && column == 5'd23) begin
        game_next_state = 1'b0;
    end
    else begin
        game_next_state = game_state;
    end
end
//small second0 counter
count_time Usec0(
  .q(small_sec0), // counter value
  .time_carry(carry_small_sec0), // counter carry
  .count_enable(game_state), // counting enabled control signal
  .load_value_enable(1'b0), // load setting value control
  .load_value(4'd0), // value to be loaded
  .count_limit(4'd9), // limit of the up counter
  .clk(clk), // clock
  .rst(rst), // high active reset,
  .to_limit(1'b0),
  .start_value(4'd0)
);

//small second1 counter
count_time Usec1(
  .q(small_sec1), // counter value
  .time_carry(carry_small_sec1), // counter carry
  .count_enable(carry_small_sec0), // counting enabled control signal
  .load_value_enable(1'b0), // load setting value control
  .load_value(4'd0), // value to be loaded
  .count_limit(4'd9), // limit of the up counter
  .clk(clk), // clock
  .rst(rst), // high active reset
  .to_limit(1'b0 ),
  .start_value(4'd0)
);

//sec0 counter
count_time Umin0(
  .q(sec0), // counter value
  .time_carry(carry_sec0), // counter carry
  .count_enable(carry_small_sec1), // counting enabled control signal
  .load_value_enable(1'b0), // load setting value control
  .load_value(4'd0), // value to be loaded
  .count_limit(4'd9), // limit of the up counter
  .clk(clk), // clock
  .rst(rst), // high active reset
  .to_limit(1'b0),
  .start_value(4'd0)
);

//sec1 counter
count_time Umin1(
  .q(sec1), // counter value
  .time_carry(carry_sec1), // counter carry
  .count_enable(carry_sec0), // counting enabled control signal
  .load_value_enable(1'b0), // load setting value control
  .load_value(4'd0), // value to be loaded
  .count_limit(4'd5), // limit of the up counter
  .clk(clk), // clock
  .rst(rst), // high active reset
  .to_limit(1'b0),
  .start_value(4'd0)
);

//min0 counter
count_time Uhr0(
  .q(min0), // counter value
  .time_carry(carry_min0), // counter carry
  .count_enable(carry_sec1), // counting enabled control signal
  .load_value_enable(1'b0), // load setting value control
  .load_value(4'd0), // value to be loaded
  .count_limit(4'd9), // limit of the up counter
  .clk(clk), // clock
  .rst(rst), // high active reset
  .to_limit(1'b0),
  .start_value(4'd0)
);

//hour1 counter
count_time Uhr1(
  .q(min1), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_min0), // counting enabled control signal
  .load_value_enable(1'b0), // load setting value control
  .load_value(4'd0), // value to be loaded
  .count_limit(4'd5), // limit of the up counter
  .clk(clk), // clock
  .rst(rst), // high active reset
  .to_limit(1'b0),
  .start_value(4'd0)
);

endmodule
