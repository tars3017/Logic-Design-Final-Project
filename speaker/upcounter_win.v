`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/07 23:24:13
// Design Name: 
// Module Name: upcounter_win
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


module upcounter_win(
    input increase,
    input clk,
    input rst_n,
    input [3:0]start_value1,
    input [3:0]start_value2,
    output reg [3:0] value1,
    output reg [3:0] value2
    );
    reg [3:0]value1_tmp;  
    reg [3:0]value2_tmp;
    
    always @*
    begin
    if(value1==4'd2 && increase && (value2 == 4'd1))
    begin
    value1_tmp = 4'd2;
    value2_tmp = 4'd1;
    end
    
    else if(value1 == 4'd9 && increase)
    begin
    value1_tmp = 0;
    value2_tmp = value2+1'b1;
    end
    
    else if(increase)
    begin 
    value1_tmp = value1+1'b1;
    value2_tmp = value2;
    end
    
    else
    begin
    value1_tmp = value1;
    value2_tmp = value2;
    end
    end
    
    always@(posedge clk or negedge rst_n)
    begin
    if(~rst_n) 
        begin
        value1 <= start_value1;
        value2 <= start_value2;
        end
    else 
        begin
        value1 <= value1_tmp;
        value2 <= value2_tmp;
        end
    end
    endmodule

