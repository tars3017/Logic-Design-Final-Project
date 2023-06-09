`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/07 21:38:57
// Design Name: 
// Module Name: freqdiv_2hz
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


module freqdiv_2hz(
    input clk,
    input rst_n,
    output reg clk_out
    );
    reg [26:0]q;
    reg [26:0]q_tmp;
    
    always@*
        if(q==27'd17500000)
            q_tmp=27'd0;
        else 
            q_tmp=q+1'b1;
            
    always@(posedge clk or negedge rst_n)
    if(~rst_n) q <= 27'd0;
    else 
    begin
        q <= q_tmp;
        if(q == 27'd17500000)
            clk_out = ~clk_out;
        else 
            clk_out = clk_out;
    end
    
    endmodule
