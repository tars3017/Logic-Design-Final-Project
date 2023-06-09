`define TAPS 5'b11111

module lfsr (
    input clk,
    input rst,
    output [4:0] random_out,
    input [4:0] range,
    input gen,
    input [4:0] seed
);
reg [4:0] lfsr;

always@(posedge clk or posedge rst) begin
    if (rst) begin
        lfsr <= seed;
    end
    else begin
        lfsr[0] <= lfsr[4] ^ (lfsr & `TAPS);
        lfsr <= {lfsr[3:1], lfsr[0]};
    end
end

assign random_out = (lfsr % (range)) + 9; 
endmodule