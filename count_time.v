`define BCD_BIT_WIDTH 4

module count_time(
  output reg [`BCD_BIT_WIDTH-1:0] q, // counter value
  output reg time_carry, // counter carry
  input count_enable, // counting enabled control signal
  input load_value_enable, // load setting value control
  input [`BCD_BIT_WIDTH-1:0] load_value, // value to be loaded
  input to_limit, // limit of the up counter
  input [`BCD_BIT_WIDTH-1:0] start_value,
  input clk, // clock
  input rst, // high active reset
  input[3:0] count_limit
);

reg [`BCD_BIT_WIDTH-1:0] q_next;

always @(posedge clk or posedge rst or posedge load_value_enable)
  if (load_value_enable)
    q <= load_value;
  else if (rst)
    q <= start_value;
  else
    q <= q_next;

always @*
begin
  q_next = q;
  time_carry = 1'b0;
//  if (load_value_enable)
//    q_next = load_value;
  if (to_limit && count_enable)
    begin
      q_next =start_value;
    end
   else if (q == count_limit && count_enable) begin
    q_next = 4'd0;
    time_carry = 1'b1;
   end
  else if (count_enable)
    q_next = q + 1'b1;
end
endmodule
