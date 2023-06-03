module clock_divisor(clk1, clk, clk22, clk_10Hz, clk_1Hz, clk_2k, clk_100);
input clk;
output clk1;
output clk22;
output reg clk_1Hz;
output reg clk_10Hz;
output reg clk_2k;
output reg clk_100;
reg [21:0] num;
wire [21:0] next_num;

reg clk_10Hz_next;
reg [26:0] count_5M, count_5M_next;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1'b1;
assign clk1 = num[1];
assign clk22 = num[21];

always@* begin
    if (count_5M == 27'd5000000 - 1'd1) begin
        count_5M_next = 27'd0;
        clk_10Hz_next = ~clk_10Hz;
    end
    else begin
        count_5M_next = count_5M + 1'b1;
        clk_10Hz_next = clk_10Hz;
    end
end
always @(posedge clk) begin
    count_5M <= count_5M_next;
    clk_10Hz <= clk_10Hz_next;
end

reg [26:0] cnt_50M_next, cnt_50M;
reg clk_1Hz_next;
always@* begin
    if (cnt_50M == 27'd50000000 - 1'd1) begin
        cnt_50M_next = 27'd0;
        clk_1Hz_next = ~clk_1Hz;
    end
    else begin
        cnt_50M_next = cnt_50M + 1'd1;
        clk_1Hz_next = clk_1Hz;
    end
end

always@(posedge clk) begin
    clk_1Hz = clk_1Hz_next;
    cnt_50M = cnt_50M_next;
end

// *********************
// Clock divider for 100 Hz
// *********************
// Clock Divider: Counter operation 

reg [26:0] count_500K, count_500K_next;
reg clk_100_next;
always @*
  if (count_500K == 27'd500000)
  begin
    count_500K_next = 27'd0;
    clk_100_next = ~clk_100;
  end
  else
  begin
    count_500K_next = count_500K + 1'b1;
    clk_100_next = clk_100;
  end


// Counter flip-flops
always @(posedge clk) begin
    count_500K <= count_500K_next;
    clk_100 <= clk_100_next;
end

// *********************
// Clock divider for 2k Hz
// *********************
// Clock Divider: Counter operation 

reg [14:0] count_25K, count_25K_next;
reg clk_2k_next;
always @*
  if (count_25K == 15'd25000)
  begin
    count_25K_next = 15'd0;
    clk_2k_next = ~clk_2k;
  end
  else
  begin
    count_25K_next = count_25K + 1'b1;
    clk_2k_next = clk_2k;
  end


// Counter flip-flops
always @(posedge clk) begin
    count_25K <= count_25K_next;
    clk_2k <= clk_2k_next;
end
  
endmodule
