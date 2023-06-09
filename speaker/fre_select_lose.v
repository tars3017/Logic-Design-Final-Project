`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/08 00:25:51
// Design Name: 
// Module Name: fre_select_lose
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


module fre_select_lose(
    input [3:0]num,
    output reg [21:0]note_div_right,
    output reg [21:0]note_div_left
    );
    
    always@*
    case(num)
    4'd0: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
    4'd1: begin note_div_right = 22'd71633; note_div_left = 22'd71633; end
    4'd2: begin note_div_right = 22'd75758; note_div_left = 22'd75758; end
    4'd3: begin note_div_right = 22'd95420; note_div_left = 22'd95420; end
    4'd4: begin note_div_right = 22'd0; note_div_left = 22'd0; end
    4'd9: begin note_div_right = 22'd0; note_div_left = 22'd0; end
    4'd5: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
    4'd6: begin note_div_right = 22'd71633; note_div_left = 22'd71633; end
    4'd7: begin note_div_right = 22'd75758; note_div_left = 22'd75758; end
    4'd8: begin note_div_right = 22'd95420; note_div_left = 22'd95420; end
    default : begin note_div_right = 22'd0; note_div_left = 22'd0; end
    endcase
    
endmodule
