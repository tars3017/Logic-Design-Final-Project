`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/07 18:46:23
// Design Name: 
// Module Name: increase_ctl
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


module increase_ctl(
    input [1:0]state,
    output reg increase_game,
    output reg increase_win,
    output reg increase_lose
    );
    
    always@*
    if(state == 2'b00)
    begin 
        increase_game = 1'b0;
        increase_win = 1'b0;
        increase_lose = 1'b0;
    end 
      
    else if(state == 2'b01)
    begin 
        increase_game = 1'b1;
        increase_win = 1'b0;
        increase_lose = 1'b0;
    end   
    
    else if(state == 2'b10)
    begin 
        increase_game = 1'b0;
        increase_win = 1'b1;
        increase_lose = 1'b0;
    end   
    
    else 
    begin 
        increase_game = 1'b0;
        increase_win = 1'b0;
        increase_lose = 1'b1;
    end   
    
endmodule
