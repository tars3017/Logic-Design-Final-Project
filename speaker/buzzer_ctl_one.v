`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 22:45:42
// Design Name: 
// Module Name: buzzer_ctl_one
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


module buzzer_ctl_one(
    output [15:0] audio_out,
    input [21:0] note_div,
    input clk,
    input rst_n
    );
    reg [21:0] clk_cnt, clk_cnt_next;
    reg b_clk, b_clk_next;
    
    assign audio_out = (b_clk == 1'b0) ? 16'hB000:16'h5FFF;
    
    always@*    
    begin
    if(clk_cnt == note_div)
        begin   
        clk_cnt_next = 22'd0;
        b_clk_next = ~b_clk;
        end
    else
        begin
        clk_cnt_next = clk_cnt + 1'b1;
        b_clk_next = b_clk;
        end
    end
    
    always@(posedge clk or negedge rst_n)
    if(~rst_n)
        begin
        clk_cnt <= 22'd0;
        b_clk <= 1'b0;
        end
    else
        begin
        clk_cnt <= clk_cnt_next;
        b_clk <= b_clk_next;
        end

endmodule
