`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/07 23:30:16
// Design Name: 
// Module Name: fre_select_win
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


module fre_select_win(
    input [3:0]num0,
    input [3:0]num1,
    output reg [21:0]note_div_right,
    output reg [21:0]note_div_left
);

    always@*
    if(num1 == 0)
    begin
    case(num0)
    4'd0: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
    4'd1: begin note_div_right = 22'd37936; note_div_left = 22'd37936; end
    4'd2: begin note_div_right = 22'd31887; note_div_left = 22'd31887; end
    4'd3: begin note_div_right = 22'd37936; note_div_left = 22'd37936; end
    4'd4: begin note_div_right = 22'd31887; note_div_left = 22'd31887; end
    4'd5: begin note_div_right = 22'd0; note_div_left = 22'd0; end
    4'd6: begin note_div_right = 22'd0; note_div_left = 22'd0; end
    4'd7: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
    4'd8: begin note_div_right = 22'd37936; note_div_left = 22'd37936; end
    4'd9: begin note_div_right = 22'd31887; note_div_left = 22'd31887; end
    default : begin note_div_right = 22'd127551; note_div_left = 22'd127551; end
    endcase
    end
    
    else
    begin 
        case(num0)
        4'd0: begin note_div_right = 22'd37936; note_div_left = 22'd37936; end
        4'd1: begin note_div_right = 22'd31887; note_div_left = 22'd31887; end
        4'd2: begin note_div_right = 22'd0;     note_div_left = 22'd0;     end
        default : begin note_div_right = 22'd0; note_div_left = 22'd0; end
        endcase
    end
endmodule
