`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/06 21:32:44
// Design Name: 
// Module Name: fre_select
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


module fre_select_game(
    input [3:0]num0,
    input [3:0]num1,
    output reg [21:0]note_div_right,
    output reg [21:0]note_div_left
    );
    
    
    always@*
    if(num1 == 0)
    begin
        case(num0)
        4'd0: begin note_div_right = 22'd63775; note_div_left = 22'd143266; end
        4'd1: begin note_div_right = 22'd42553; note_div_left = 22'd42553; end
        4'd2: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
        4'd3: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        4'd4: begin note_div_right = 22'd50607; note_div_left = 22'd50607; end
        4'd5: begin note_div_right = 22'd0;     note_div_left = 22'd0; end
        4'd6: begin note_div_right = 22'd50607; note_div_left = 22'd50607; end
        4'd7: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
        4'd8: begin note_div_right = 22'd127551; note_div_left = 22'd127551; end
        4'd9: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        default: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        endcase
    end  
    else if(num1 == 1)
    begin
        case(num0)
        4'd0: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
        4'd1: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        4'd2: begin note_div_right = 22'd50607; note_div_left = 22'd50607; end
        4'd3: begin note_div_right = 22'd0;     note_div_left = 22'd0;     end
        4'd4: begin note_div_right = 22'd50607; note_div_left = 22'd50607; end
        4'd5: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
        4'd6: begin note_div_right = 22'd63775; note_div_left = 22'd113636; end
        4'd7: begin note_div_right = 22'd42553; note_div_left = 22'd42553; end
        4'd8: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
        4'd9: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        default: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        endcase
    end  
    else if(num1 == 2)
    begin
        case(num0)
        4'd0: begin note_div_right = 22'd50607; note_div_left = 22'd50607; end
        4'd1: begin note_div_right = 22'd0;     note_div_left = 22'd0;     end
        4'd2: begin note_div_right = 22'd50607; note_div_left = 22'd50607; end
        4'd3: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
        4'd4: begin note_div_right = 22'd95420; note_div_left = 22'd95420; end
        4'd5: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        4'd6: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
        4'd7: begin note_div_right = 22'd37936; note_div_left = 22'd37936; end
        4'd8: begin note_div_right = 22'd42553; note_div_left = 22'd42553; end
        4'd9: begin note_div_right = 22'd0;     note_div_left = 22'd0; end
        default: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        endcase
    end  
    else if(num1 == 3)
    begin
        case(num0)
        4'd0: begin note_div_right = 22'd47801; note_div_left = 22'd47801; end
        4'd1: begin note_div_right = 22'd42553; note_div_left = 22'd42553; end
        default: begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
        endcase
    end  
    
    else
        begin note_div_right = 22'd63775; note_div_left = 22'd63775; end
    
    
    
endmodule

