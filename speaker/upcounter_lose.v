`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/08 00:19:16
// Design Name: 
// Module Name: upcounter_lose
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


module upcounter_lose(
    input increase,
    input clk,
    input rst_n,
    output reg [3:0] value
    );
    reg [3:0]value_tmp;  
    
    always @*
    if(value==4'd9 && increase)
    begin
    value_tmp = 4'd9;
    end
    
    else if(increase)
    begin 
    value_tmp = value+1'b1;
    end
    
    else
    begin
    value_tmp = value;
    end
    
    always@(posedge clk or negedge rst_n)
    if(~rst_n) value <= 4'b0;
    else value <= value_tmp;
    
    endmodule
