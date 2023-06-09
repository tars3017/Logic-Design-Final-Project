`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/07 18:43:19
// Design Name: 
// Module Name: top_sound
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


module top_sound(
    input [1:0]state,
    input clk,
    input rst_n, 
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
    );
    wire increase_game;
    wire increase_win;
    wire increase_lose;
    wire clk_2hz;
    wire clk_5hz;
    wire [3:0]game_value1;
    wire [3:0]game_value2;
    wire [21:0]game_note_div_right;
    wire [21:0]game_note_div_left;
    wire [21:0]win_note_div_right;
    wire [21:0]win_note_div_left;
    wire [21:0]lose_note_div_right;
    wire [21:0]lose_note_div_left;
    wire [21:0]note_div_right;
    wire [21:0]note_div_left;
    wire [15:0] audio_left;
    wire [15:0] audio_right;  
    wire [3:0] win_value1;  
    wire [3:0] win_value2;  
    wire [3:0] lose_value;
    
        
    increase_ctl U0(.state(state),.increase_game(increase_game),.increase_win(increase_win),.increase_lose(increase_lose));
    freqdiv_2hz U1(.clk(clk),.rst_n(1'b1),.clk_out(clk_2hz));
    upcounter_game U2(.increase(increase_game),.clk(clk_2hz),.rst_n(1'b1),.start_value1(4'd0),.start_value2(4'd0),.value1(game_value1),.value2(game_value2));
    fre_select_game U3(.num0(game_value1),.num1(game_value2),.note_div_right(game_note_div_right),.note_div_left(game_note_div_left));
    buzzer_select U4(.state(state),.game_note_div_right(game_note_div_right),.game_note_div_left(game_note_div_left),.win_note_div_right(win_note_div_right),.win_note_div_left(win_note_div_left),.lose_note_div_right(lose_note_div_right),.lose_note_div_left(lose_note_div_left),.note_div_right(note_div_right),.note_div_left(note_div_left));
    buzzer_ctl_one U5(.clk(clk),.rst_n(1'b1),.note_div(note_div_right),.audio_out(audio_right));
    buzzer_ctl_one U6(.clk(clk),.rst_n(1'b1),.note_div(note_div_left),.audio_out(audio_left));
    speaker_control U7(.audio_mclk(audio_mclk),.audio_lrck(audio_lrck),.audio_sck(audio_sck),.audio_sdin(audio_sdin),.clk(clk),.rst_n(rst_n),.audio_in_left(audio_left),.audio_in_right(audio_right));
    upcounter_win U8(.increase(increase_win),.clk(clk_5hz),.rst_n(rst_n),.start_value1(4'd0),.start_value2(4'd0),.value1(win_value1),.value2(win_value2));
    fre_select_win U9(.num0(win_value1),.num1(win_value2),.note_div_right(win_note_div_right),.note_div_left(win_note_div_left));
    freqdiv_5hz U10(.clk(clk),.rst_n(1'b1),.clk_out(clk_5hz));
    upcounter_lose U11(.increase(increase_lose),.clk(clk_2hz),.rst_n(rst_n),.value(lose_value));
    fre_select_lose U12(.num(lose_value),.note_div_right(lose_note_div_right),.note_div_left(lose_note_div_left));    
endmodule
