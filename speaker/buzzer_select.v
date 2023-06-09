`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/07 22:14:10
// Design Name: 
// Module Name: buzzer_select
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


module buzzer_select(
    input [1:0]state,
    input [21:0]game_note_div_right,
    input [21:0]game_note_div_left,
    input [21:0]win_note_div_right,
    input [21:0]win_note_div_left,
    input [21:0]lose_note_div_right,
    input [21:0]lose_note_div_left,
    output reg [21:0]note_div_right,
    output reg [21:0]note_div_left
    );
    
    always@*
    case(state)
    4'b01:
    begin
        note_div_right = game_note_div_right;
        note_div_left = game_note_div_left;
    end
    4'b10:
    begin
        note_div_right = win_note_div_right;
        note_div_left = win_note_div_left;
    end
    4'b11:
    begin
        note_div_right = lose_note_div_right;
        note_div_left = lose_note_div_left;
    end
    default 
    begin
        note_div_right = 22'd0;
        note_div_left = 22'd0;
    end
    endcase
    
    
    
endmodule
