`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 09:20:14
// Design Name: 
// Module Name: maps
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


module maps(
    input rst, //posedge rst
    input clk,
    input key_valid,
    input [8:0] last_change,
    input [511:0] key_down,
    output [3:0]locate,
    output reg [4:0]row,        //up and down
    output reg [4:0]column,     //right and left
    output move
    );
    
    wire [3:0]location[31:0][23:0];
    // wire move;
    reg [1:0]dire;
    reg [4:0]next_row;
    reg [4:0]next_column;
    reg move_enable;
    
    assign location[0][0] = 4'b1001;   //up right down left
    assign location[1][0] = 4'b1010;
    assign location[2][0] = 4'b1010;
    assign location[3][0] = 4'b1100;
    assign location[4][0] = 4'b1001;   
    assign location[5][0] = 4'b1100;
    assign location[6][0] = 4'b1001;
    assign location[7][0] = 4'b1010;
    assign location[8][0] = 4'b1100;   
    assign location[9][0] = 4'b1101;
    assign location[10][0] = 4'b1001;
    assign location[11][0] = 4'b1110;
    assign location[12][0] = 4'b1001;   
    assign location[13][0] = 4'b1010;
    assign location[14][0] = 4'b1110;
    assign location[15][0] = 4'b1001;     // change to close
    assign location[16][0] = 4'b1000;   //up right down left
    assign location[17][0] = 4'b1100;
    assign location[18][0] = 4'b1001;
    assign location[19][0] = 4'b1100;
    assign location[20][0] = 4'b1001;   
    assign location[21][0] = 4'b1100;
    assign location[22][0] = 4'b1001;
    assign location[23][0] = 4'b1000;
    assign location[24][0] = 4'b1100;   //up right down left
    assign location[25][0] = 4'b1001;
    assign location[26][0] = 4'b1100;
    assign location[27][0] = 4'b1101;
    assign location[28][0] = 4'b1001;   
    assign location[29][0] = 4'b1010;
    assign location[30][0] = 4'b1010;
    assign location[31][0] = 4'b1100;
    
    assign location[0][1] = 4'b0100;   //up right down left
    assign location[1][1] = 4'b1101;
    assign location[2][1] = 4'b1001;
    assign location[3][1] = 4'b0110;
    assign location[4][1] = 4'b0111;   
    assign location[5][1] = 4'b0101;
    assign location[6][1] = 4'b0101;
    assign location[7][1] = 4'b1001;
    assign location[8][1] = 4'b0110;   
    assign location[9][1] = 4'b0101;
    assign location[10][1] = 4'b0101;
    assign location[11][1] = 4'b1001;
    assign location[12][1] = 4'b0010;   
    assign location[13][1] = 4'b1100;
    assign location[14][1] = 4'b1001;
    assign location[15][1] = 4'b0110;
    assign location[16][1] = 4'b0101;   //up right down left
    assign location[17][1] = 4'b0011;
    assign location[18][1] = 4'b0110;
    assign location[19][1] = 4'b0101;
    assign location[20][1] = 4'b0111;   
    assign location[21][1] = 4'b0011;
    assign location[22][1] = 4'b0110;
    assign location[23][1] = 4'b1001;
    assign location[24][1] = 4'b0110;   //up right down left
    assign location[25][1] = 4'b0101;
    assign location[26][1] = 4'b0011;
    assign location[27][1] = 4'b0110;
    assign location[28][1] = 4'b0011;   
    assign location[29][1] = 4'b1100;
    assign location[30][1] = 4'b1001;
    assign location[31][1] = 4'b0110;
    
    assign location[5'd0][5'd2] = 4'b0101;   //up right down left
    assign location[5'd1][5'd2] = 4'b0101;
    assign location[5'd2][5'd2] = 4'b0011;
    assign location[5'd3][5'd2] = 4'b1010;
    assign location[5'd4][5'd2] = 4'b1010;   
    assign location[5'd5][5'd2] = 4'b0110;
    assign location[5'd6][5'd2] = 4'b0111;
    assign location[5'd7][5'd2] = 4'b0101;
    assign location[5'd8][5'd2] = 4'b1001;   
    assign location[5'd9][5'd2] = 4'b0100;
    assign location[5'd10][5'd2] = 4'b0001;
    assign location[5'd11][5'd2] = 4'b0110;
    assign location[5'd12][5'd2] = 4'b1001;   
    assign location[5'd13][5'd2] = 4'b0110;
    assign location[5'd14][5'd2] = 4'b0011;
    assign location[5'd15][5'd2] = 4'b1100;
    assign location[5'd16][5'd2] = 4'b0011;   //up right down left
    assign location[5'd17][5'd2] = 4'b1100;
    assign location[5'd18][5'd2] = 4'b1101;
    assign location[5'd19][5'd2] = 4'b0011;
    assign location[5'd20][5'd2] = 4'b1010;   
    assign location[5'd21][5'd2] = 4'b1010;
    assign location[5'd22][5'd2] = 4'b1000;
    assign location[5'd23][5'd2] = 4'b0100;
    assign location[5'd24][5'd2] = 4'b1101;   //up right down left
    assign location[5'd25][5'd2] = 4'b0011;
    assign location[5'd26][5'd2] = 4'b1100;
    assign location[5'd27][5'd2] = 4'b1001;
    assign location[5'd28][5'd2] = 4'b1110;   
    assign location[5'd29][5'd2] = 4'b0101;
    assign location[5'd30][5'd2] = 4'b0011;
    assign location[5'd31][5'd2] = 4'b1100;
    
    assign location[5'd0][5'd3] = 4'b0101;   //up right down left
    assign location[5'd1][5'd3] = 4'b0101;
    assign location[5'd2][5'd3] = 4'b1001;
    assign location[5'd3][5'd3] = 4'b1010;
    assign location[5'd4][5'd3] = 4'b1010;   
    assign location[5'd5][5'd3] = 4'b1010;
    assign location[5'd6][5'd3] = 4'b1010;
    assign location[5'd7][5'd3] = 4'b0010;
    assign location[5'd8][5'd3] = 4'b0110;   
    assign location[5'd9][5'd3] = 4'b0011;
    assign location[5'd10][5'd3] = 4'b0110;
    assign location[5'd11][5'd3] = 4'b1001;
    assign location[5'd12][5'd3] = 4'b0010;   
    assign location[5'd13][5'd3] = 4'b1010;
    assign location[5'd14][5'd3] = 4'b1010;
    assign location[5'd15][5'd3] = 4'b0110;
    assign location[5'd16][5'd3] = 4'b1101;   
    assign location[5'd17][5'd3] = 4'b0101;
    assign location[5'd18][5'd3] = 4'b0001;
    assign location[5'd19][5'd3] = 4'b1100;
    assign location[5'd20][5'd3] = 4'b1001;   
    assign location[5'd21][5'd3] = 4'b1000;
    assign location[5'd22][5'd3] = 4'b0110;
    assign location[5'd23][5'd3] = 4'b0011;
    assign location[5'd24][5'd3] = 4'b0010;  
    assign location[5'd25][5'd3] = 4'b1100;
    assign location[5'd26][5'd3] = 4'b0011;
    assign location[5'd27][5'd3] = 4'b0010;
    assign location[5'd28][5'd3] = 4'b1100;   
    assign location[5'd29][5'd3] = 4'b0011;
    assign location[5'd30][5'd3] = 4'b1100;
    assign location[5'd31][5'd3] = 4'b0101;
    
    assign location[5'd0][5'd4] = 4'b0001;   //up right down left
    assign location[5'd1][5'd4] = 4'b0110;
    assign location[5'd2][5'd4] = 4'b0101;
    assign location[5'd3][5'd4] = 4'b1001;
    assign location[5'd4][5'd4] = 4'b1100;   
    assign location[5'd5][5'd4] = 4'b1001;
    assign location[5'd6][5'd4] = 4'b1010;
    assign location[5'd7][5'd4] = 4'b1100;
    assign location[5'd8][5'd4] = 4'b1101;   
    assign location[5'd9][5'd4] = 4'b1001;
    assign location[5'd10][5'd4] = 4'b1100;
    assign location[5'd11][5'd4] = 4'b0101;
    assign location[5'd12][5'd4] = 4'b1011;   
    assign location[5'd13][5'd4] = 4'b1010;
    assign location[5'd14][5'd4] = 4'b1000;
    assign location[5'd15][5'd4] = 4'b1010;
    assign location[5'd16][5'd4] = 4'b0110;   
    assign location[5'd17][5'd4] = 4'b0011;
    assign location[5'd18][5'd4] = 4'b0110;
    assign location[5'd19][5'd4] = 4'b0101;
    assign location[5'd20][5'd4] = 4'b0111;   
    assign location[5'd21][5'd4] = 4'b0011;
    assign location[5'd22][5'd4] = 4'b1010;
    assign location[5'd23][5'd4] = 4'b1010;
    assign location[5'd24][5'd4] = 4'b1110;  
    assign location[5'd25][5'd4] = 4'b0011;
    assign location[5'd26][5'd4] = 4'b1100;
    assign location[5'd27][5'd4] = 4'b1011;
    assign location[5'd28][5'd4] = 4'b0010;   
    assign location[5'd29][5'd4] = 4'b1010;
    assign location[5'd30][5'd4] = 4'b0110;
    assign location[5'd31][5'd4] = 4'b0101;
    
    assign location[5'd0][5'd5] = 4'b0101;   //up right down left
    assign location[5'd1][5'd5] = 4'b1011;
    assign location[5'd2][5'd5] = 4'b0100;
    assign location[5'd3][5'd5] = 4'b0101;
    assign location[5'd4][5'd5] = 4'b0011;   
    assign location[5'd5][5'd5] = 4'b0110;
    assign location[5'd6][5'd5] = 4'b1001;
    assign location[5'd7][5'd5] = 4'b0110;
    assign location[5'd8][5'd5] = 4'b0101;   
    assign location[5'd9][5'd5] = 4'b0101;
    assign location[5'd10][5'd5] = 4'b0011;
    assign location[5'd11][5'd5] = 4'b0110;
    assign location[5'd12][5'd5] = 4'b1001;   
    assign location[5'd13][5'd5] = 4'b1010;
    assign location[5'd14][5'd5] = 4'b0110;
    assign location[5'd15][5'd5] = 4'b1001;
    assign location[5'd16][5'd5] = 4'b1100;   
    assign location[5'd17][5'd5] = 4'b1011;
    assign location[5'd18][5'd5] = 4'b1000;
    assign location[5'd19][5'd5] = 4'b0110;
    assign location[5'd20][5'd5] = 4'b1001;   
    assign location[5'd21][5'd5] = 4'b1010;
    assign location[5'd22][5'd5] = 4'b1010;
    assign location[5'd23][5'd5] = 4'b1010;
    assign location[5'd24][5'd5] = 4'b1100;  
    assign location[5'd25][5'd5] = 4'b1001;
    assign location[5'd26][5'd5] = 4'b0000;
    assign location[5'd27][5'd5] = 4'b1100;
    assign location[5'd28][5'd5] = 4'b1001;   
    assign location[5'd29][5'd5] = 4'b1000;
    assign location[5'd30][5'd5] = 4'b1010;
    assign location[5'd31][5'd5] = 4'b0110;
    
    assign location[5'd0][5'd6] = 4'b0001;   //up right down left
    assign location[5'd1][5'd6] = 4'b1100;
    assign location[5'd2][5'd6] = 4'b0011;
    assign location[5'd3][5'd6] = 4'b0010;
    assign location[5'd4][5'd6] = 4'b1110;   
    assign location[5'd5][5'd6] = 4'b1001;
    assign location[5'd6][5'd6] = 4'b0010;
    assign location[5'd7][5'd6] = 4'b1100;
    assign location[5'd8][5'd6] = 4'b0101;   
    assign location[5'd9][5'd6] = 4'b0011;
    assign location[5'd10][5'd6] = 4'b1010;
    assign location[5'd11][5'd6] = 4'b1100;
    assign location[5'd12][5'd6] = 4'b0001;   
    assign location[5'd13][5'd6] = 4'b1000;
    assign location[5'd14][5'd6] = 4'b1010;
    assign location[5'd15][5'd6] = 4'b0110;
    assign location[5'd16][5'd6] = 4'b0101;   
    assign location[5'd17][5'd6] = 4'b1001;
    assign location[5'd18][5'd6] = 4'b0110;
    assign location[5'd19][5'd6] = 4'b1001;
    assign location[5'd20][5'd6] = 4'b0110;   
    assign location[5'd21][5'd6] = 4'b1101;
    assign location[5'd22][5'd6] = 4'b1001;
    assign location[5'd23][5'd6] = 4'b1110;
    assign location[5'd24][5'd6] = 4'b0101;  
    assign location[5'd25][5'd6] = 4'b0111;
    assign location[5'd26][5'd6] = 4'b0101;
    assign location[5'd27][5'd6] = 4'b0101;
    assign location[5'd28][5'd6] = 4'b0111;   
    assign location[5'd29][5'd6] = 4'b0101;
    assign location[5'd30][5'd6] = 4'b1011;
    assign location[5'd31][5'd6] = 4'b1100;
    
    assign location[5'd0][5'd7] = 4'b0101;   //up right down left
    assign location[5'd1][5'd7] = 4'b0011;
    assign location[5'd2][5'd7] = 4'b1100;
    assign location[5'd3][5'd7] = 4'b1011;
    assign location[5'd4][5'd7] = 4'b1100;   
    assign location[5'd5][5'd7] = 4'b0011;
    assign location[5'd6][5'd7] = 4'b1100;
    assign location[5'd7][5'd7] = 4'b0011;
    assign location[5'd8][5'd7] = 4'b0110;   
    assign location[5'd9][5'd7] = 4'b1001;
    assign location[5'd10][5'd7] = 4'b1010;
    assign location[5'd11][5'd7] = 4'b0010;
    assign location[5'd12][5'd7] = 4'b0110;   
    assign location[5'd13][5'd7] = 4'b0111;
    assign location[5'd14][5'd7] = 4'b1001;
    assign location[5'd15][5'd7] = 4'b1010;
    assign location[5'd16][5'd7] = 4'b0110;   
    assign location[5'd17][5'd7] = 4'b0011;
    assign location[5'd18][5'd7] = 4'b1010;
    assign location[5'd19][5'd7] = 4'b0110;
    assign location[5'd20][5'd7] = 4'b1001;   
    assign location[5'd21][5'd7] = 4'b0110;
    assign location[5'd22][5'd7] = 4'b0011;
    assign location[5'd23][5'd7] = 4'b1010;
    assign location[5'd24][5'd7] = 4'b0110;  
    assign location[5'd25][5'd7] = 4'b1001;
    assign location[5'd26][5'd7] = 4'b0110;
    assign location[5'd27][5'd7] = 4'b0111;
    assign location[5'd28][5'd7] = 4'b1001;   
    assign location[5'd29][5'd7] = 4'b0110;
    assign location[5'd30][5'd7] = 4'b1001;
    assign location[5'd31][5'd7] = 4'b0110;
    
    assign location[5'd0][5'd8] = 4'b0101;   //up right down left
    assign location[5'd1][5'd8] = 4'b1001;
    assign location[5'd2][5'd8] = 4'b0110;
    assign location[5'd3][5'd8] = 4'b1001;
    assign location[5'd4][5'd8] = 4'b0010;   
    assign location[5'd5][5'd8] = 4'b1010;
    assign location[5'd6][5'd8] = 4'b0110;
    assign location[5'd7][5'd8] = 4'b1001;
    assign location[5'd8][5'd8] = 4'b1010;   
    assign location[5'd9][5'd8] = 4'b0010;
    assign location[5'd10][5'd8] = 4'b1110;
    assign location[5'd11][5'd8] = 4'b1001;
    assign location[5'd12][5'd8] = 4'b1010;   
    assign location[5'd13][5'd8] = 4'b1100;
    assign location[5'd14][5'd8] = 4'b0111;
    assign location[5'd15][5'd8] = 4'b1001;
    assign location[5'd16][5'd8] = 4'b1010;   
    assign location[5'd17][5'd8] = 4'b1010;
    assign location[5'd18][5'd8] = 4'b1100;
    assign location[5'd19][5'd8] = 4'b1011;
    assign location[5'd20][5'd8] = 4'b0100;   
    assign location[5'd21][5'd8] = 4'b1001;
    assign location[5'd22][5'd8] = 4'b1100;
    assign location[5'd23][5'd8] = 4'b1001;
    assign location[5'd24][5'd8] = 4'b1110;  
    assign location[5'd25][5'd8] = 4'b0101;
    assign location[5'd26][5'd8] = 4'b1101;
    assign location[5'd27][5'd8] = 4'b1001;
    assign location[5'd28][5'd8] = 4'b0010;   
    assign location[5'd29][5'd8] = 4'b1110;
    assign location[5'd30][5'd8] = 4'b0101;
    assign location[5'd31][5'd8] = 4'b1101;
    
    assign location[5'd0][5'd9] = 4'b0101;   //up right down left
    assign location[5'd1][5'd9] = 4'b0011;
    assign location[5'd2][5'd9] = 4'b1100;
    assign location[5'd3][5'd9] = 4'b0101;
    assign location[5'd4][5'd9] = 4'b1011;   
    assign location[5'd5][5'd9] = 4'b1010;
    assign location[5'd6][5'd9] = 4'b1100;
    assign location[5'd7][5'd9] = 4'b0101;
    assign location[5'd8][5'd9] = 4'b1011;   
    assign location[5'd9][5'd9] = 4'b1100;
    assign location[5'd10][5'd9] = 4'b1001;
    assign location[5'd11][5'd9] = 4'b0010;
    assign location[5'd12][5'd9] = 4'b1110;   
    assign location[5'd13][5'd9] = 4'b0101;
    assign location[5'd14][5'd9] = 4'b1001;
    assign location[5'd15][5'd9] = 4'b0110;
    assign location[5'd16][5'd9] = 4'b1001;   
    assign location[5'd17][5'd9] = 4'b1100;
    assign location[5'd18][5'd9] = 4'b0011;
    assign location[5'd19][5'd9] = 4'b1010;
    assign location[5'd20][5'd9] = 4'b0011;   
    assign location[5'd21][5'd9] = 4'b0110;
    assign location[5'd22][5'd9] = 4'b0011;
    assign location[5'd23][5'd9] = 4'b0010;
    assign location[5'd24][5'd9] = 4'b1100;  
    assign location[5'd25][5'd9] = 4'b0011;
    assign location[5'd26][5'd9] = 4'b0100;
    assign location[5'd27][5'd9] = 4'b0101;
    assign location[5'd28][5'd9] = 4'b1001;   
    assign location[5'd29][5'd9] = 4'b1100;
    assign location[5'd30][5'd9] = 4'b0001;
    assign location[5'd31][5'd9] = 4'b0100;
    
    assign location[5'd0][5'd10] = 4'b0011;   //up right down left
    assign location[5'd1][5'd10] = 4'b1100;
    assign location[5'd2][5'd10] = 4'b0011;
    assign location[5'd3][5'd10] = 4'b0110;
    assign location[5'd4][5'd10] = 4'b1001;   
    assign location[5'd5][5'd10] = 4'b1000;
    assign location[5'd6][5'd10] = 4'b0110;
    assign location[5'd7][5'd10] = 4'b0011;
    assign location[5'd8][5'd10] = 4'b1100;   
    assign location[5'd9][5'd10] = 4'b0101;
    assign location[5'd10][5'd10] = 4'b0011;
    assign location[5'd11][5'd10] = 4'b1010;
    assign location[5'd12][5'd10] = 4'b1100;   
    assign location[5'd13][5'd10] = 4'b0101;
    assign location[5'd14][5'd10] = 4'b0011;
    assign location[5'd15][5'd10] = 4'b1100;
    assign location[5'd16][5'd10] = 4'b0101;   
    assign location[5'd17][5'd10] = 4'b0011;
    assign location[5'd18][5'd10] = 4'b1010;
    assign location[5'd19][5'd10] = 4'b1100;
    assign location[5'd20][5'd10] = 4'b1001;   
    assign location[5'd21][5'd10] = 4'b1010;
    assign location[5'd22][5'd10] = 4'b1010;
    assign location[5'd23][5'd10] = 4'b1110;
    assign location[5'd24][5'd10] = 4'b0101;  
    assign location[5'd25][5'd10] = 4'b1101;
    assign location[5'd26][5'd10] = 4'b0011;
    assign location[5'd27][5'd10] = 4'b0110;
    assign location[5'd28][5'd10] = 4'b0111;   
    assign location[5'd29][5'd10] = 4'b0011;
    assign location[5'd30][5'd10] = 4'b0110;
    assign location[5'd31][5'd10] = 4'b0101;
    
    assign location[5'd0][5'd11] = 4'b1001;   //up right down left
    assign location[5'd1][5'd11] = 4'b0110;
    assign location[5'd2][5'd11] = 4'b1011;
    assign location[5'd3][5'd11] = 4'b1100;
    assign location[5'd4][5'd11] = 4'b0101;   
    assign location[5'd5][5'd11] = 4'b0101;
    assign location[5'd6][5'd11] = 4'b1011;
    assign location[5'd7][5'd11] = 4'b1000;
    assign location[5'd8][5'd11] = 4'b0110;   
    assign location[5'd9][5'd11] = 4'b0011;
    assign location[5'd10][5'd11] = 4'b1100;
    assign location[5'd11][5'd11] = 4'b1101;
    assign location[5'd12][5'd11] = 4'b0101;   
    assign location[5'd13][5'd11] = 4'b0101;
    assign location[5'd14][5'd11] = 4'b1101;
    assign location[5'd15][5'd11] = 4'b0101;
    assign location[5'd16][5'd11] = 4'b0111;   
    assign location[5'd17][5'd11] = 4'b1001;
    assign location[5'd18][5'd11] = 4'b1010;
    assign location[5'd19][5'd11] = 4'b0110;
    assign location[5'd20][5'd11] = 4'b0101;   
    assign location[5'd21][5'd11] = 4'b1001;
    assign location[5'd22][5'd11] = 4'b1000;
    assign location[5'd23][5'd11] = 4'b1100;
    assign location[5'd24][5'd11] = 4'b0101;  
    assign location[5'd25][5'd11] = 4'b0011;
    assign location[5'd26][5'd11] = 4'b1000;
    assign location[5'd27][5'd11] = 4'b1010;
    assign location[5'd28][5'd11] = 4'b1010;   
    assign location[5'd29][5'd11] = 4'b1010;
    assign location[5'd30][5'd11] = 4'b1100;
    assign location[5'd31][5'd11] = 4'b0101;
    
    assign location[5'd0][5'd12] = 4'b0011;   //up right down left
    assign location[5'd1][5'd12] = 4'b1100;
    assign location[5'd2][5'd12] = 4'b1001;
    assign location[5'd3][5'd12] = 4'b0110;
    assign location[5'd4][5'd12] = 4'b0101;   
    assign location[5'd5][5'd12] = 4'b0011;
    assign location[5'd6][5'd12] = 4'b1010;
    assign location[5'd7][5'd12] = 4'b0110;
    assign location[5'd8][5'd12] = 4'b1001;   
    assign location[5'd9][5'd12] = 4'b1010;
    assign location[5'd10][5'd12] = 4'b0110;
    assign location[5'd11][5'd12] = 4'b0101;
    assign location[5'd12][5'd12] = 4'b0101;   
    assign location[5'd13][5'd12] = 4'b0011;
    assign location[5'd14][5'd12] = 4'b0110;
    assign location[5'd15][5'd12] = 4'b0101;
    assign location[5'd16][5'd12] = 4'b1001;   
    assign location[5'd17][5'd12] = 4'b0100;
    assign location[5'd18][5'd12] = 4'b1001;
    assign location[5'd19][5'd12] = 4'b1010;
    assign location[5'd20][5'd12] = 4'b0110;   
    assign location[5'd21][5'd12] = 4'b0101;
    assign location[5'd22][5'd12] = 4'b0101;
    assign location[5'd23][5'd12] = 4'b0101;
    assign location[5'd24][5'd12] = 4'b0011;  
    assign location[5'd25][5'd12] = 4'b1010;
    assign location[5'd26][5'd12] = 4'b0110;
    assign location[5'd27][5'd12] = 4'b1001;
    assign location[5'd28][5'd12] = 4'b1010;   
    assign location[5'd29][5'd12] = 4'b1110;
    assign location[5'd30][5'd12] = 4'b0011;
    assign location[5'd31][5'd12] = 4'b0100;
    
    assign location[5'd0][5'd13] = 4'b1011;   //up right down left
    assign location[5'd1][5'd13] = 4'b0010;
    assign location[5'd2][5'd13] = 4'b0010;
    assign location[5'd3][5'd13] = 4'b1100;
    assign location[5'd4][5'd13] = 4'b0011;   
    assign location[5'd5][5'd13] = 4'b1010;
    assign location[5'd6][5'd13] = 4'b1100;
    assign location[5'd7][5'd13] = 4'b1001;
    assign location[5'd8][5'd13] = 4'b0110;   
    assign location[5'd9][5'd13] = 4'b1011;
    assign location[5'd10][5'd13] = 4'b1010;
    assign location[5'd11][5'd13] = 4'b0010;
    assign location[5'd12][5'd13] = 4'b0010;   
    assign location[5'd13][5'd13] = 4'b1010;
    assign location[5'd14][5'd13] = 4'b1100;
    assign location[5'd15][5'd13] = 4'b0101;
    assign location[5'd16][5'd13] = 4'b0101;   
    assign location[5'd17][5'd13] = 4'b0111;
    assign location[5'd18][5'd13] = 4'b0101;
    assign location[5'd19][5'd13] = 4'b1001;
    assign location[5'd20][5'd13] = 4'b1100;   
    assign location[5'd21][5'd13] = 4'b0111;
    assign location[5'd22][5'd13] = 4'b0101;
    assign location[5'd23][5'd13] = 4'b0011;
    assign location[5'd24][5'd13] = 4'b1000;  
    assign location[5'd25][5'd13] = 4'b1100;
    assign location[5'd26][5'd13] = 4'b1101;
    assign location[5'd27][5'd13] = 4'b0001;
    assign location[5'd28][5'd13] = 4'b1010;   
    assign location[5'd29][5'd13] = 4'b1100;
    assign location[5'd30][5'd13] = 4'b1101;
    assign location[5'd31][5'd13] = 4'b0101;
    
    assign location[5'd0][5'd14] = 4'b1001;   //up right down left
    assign location[5'd1][5'd14] = 4'b1010;
    assign location[5'd2][5'd14] = 4'b1100;
    assign location[5'd3][5'd14] = 4'b0101;
    assign location[5'd4][5'd14] = 4'b1001;   
    assign location[5'd5][5'd14] = 4'b1110;
    assign location[5'd6][5'd14] = 4'b0011;
    assign location[5'd7][5'd14] = 4'b0110;
    assign location[5'd8][5'd14] = 4'b1001;   
    assign location[5'd9][5'd14] = 4'b1010;
    assign location[5'd10][5'd14] = 4'b1010;
    assign location[5'd11][5'd14] = 4'b1010;
    assign location[5'd12][5'd14] = 4'b1110;   
    assign location[5'd13][5'd14] = 4'b1001;
    assign location[5'd14][5'd14] = 4'b0010;
    assign location[5'd15][5'd14] = 4'b0110;
    assign location[5'd16][5'd14] = 4'b0011;   
    assign location[5'd17][5'd14] = 4'b1100;
    assign location[5'd18][5'd14] = 4'b0001;
    assign location[5'd19][5'd14] = 4'b0110;
    assign location[5'd20][5'd14] = 4'b0011;   
    assign location[5'd21][5'd14] = 4'b1100;
    assign location[5'd22][5'd14] = 4'b0101;
    assign location[5'd23][5'd14] = 4'b1001;
    assign location[5'd24][5'd14] = 4'b0110;  
    assign location[5'd25][5'd14] = 4'b0011;
    assign location[5'd26][5'd14] = 4'b0110;
    assign location[5'd27][5'd14] = 4'b0101;
    assign location[5'd28][5'd14] = 4'b1001;   
    assign location[5'd29][5'd14] = 4'b0110;
    assign location[5'd30][5'd14] = 4'b0011;
    assign location[5'd31][5'd14] = 4'b0100;
    
    assign location[5'd0][5'd15] = 4'b0111;   //up right down left
    assign location[5'd1][5'd15] = 4'b1001;
    assign location[5'd2][5'd15] = 4'b0110;
    assign location[5'd3][5'd15] = 4'b0101;
    assign location[5'd4][5'd15] = 4'b0011;   
    assign location[5'd5][5'd15] = 4'b1010;
    assign location[5'd6][5'd15] = 4'b1000;
    assign location[5'd7][5'd15] = 4'b1100;
    assign location[5'd8][5'd15] = 4'b0011;   
    assign location[5'd9][5'd15] = 4'b1100;
    assign location[5'd10][5'd15] = 4'b1011;
    assign location[5'd11][5'd15] = 4'b1000;
    assign location[5'd12][5'd15] = 4'b1010;   
    assign location[5'd13][5'd15] = 4'b0010;
    assign location[5'd14][5'd15] = 4'b1010;
    assign location[5'd15][5'd15] = 4'b1010;
    assign location[5'd16][5'd15] = 4'b1010;   
    assign location[5'd17][5'd15] = 4'b0110;
    assign location[5'd18][5'd15] = 4'b0011;
    assign location[5'd19][5'd15] = 4'b1010;
    assign location[5'd20][5'd15] = 4'b1110;   
    assign location[5'd21][5'd15] = 4'b0101;
    assign location[5'd22][5'd15] = 4'b0101;
    assign location[5'd23][5'd15] = 4'b0101;
    assign location[5'd24][5'd15] = 4'b1101;  
    assign location[5'd25][5'd15] = 4'b1001;
    assign location[5'd26][5'd15] = 4'b1010;
    assign location[5'd27][5'd15] = 4'b0110;
    assign location[5'd28][5'd15] = 4'b0101;   
    assign location[5'd29][5'd15] = 4'b1001;
    assign location[5'd30][5'd15] = 4'b1010;
    assign location[5'd31][5'd15] = 4'b0110;
    
    assign location[5'd0][5'd16] = 4'b1001;   //up right down left
    assign location[5'd1][5'd16] = 4'b0110;
    assign location[5'd2][5'd16] = 4'b1101;
    assign location[5'd3][5'd16] = 4'b0011;
    assign location[5'd4][5'd16] = 4'b1000;   
    assign location[5'd5][5'd16] = 4'b1010;
    assign location[5'd6][5'd16] = 4'b0110;
    assign location[5'd7][5'd16] = 4'b0011;
    assign location[5'd8][5'd16] = 4'b1010;   
    assign location[5'd9][5'd16] = 4'b0110;
    assign location[5'd10][5'd16] = 4'b1001;
    assign location[5'd11][5'd16] = 4'b0010;
    assign location[5'd12][5'd16] = 4'b1100;   
    assign location[5'd13][5'd16] = 4'b1011;
    assign location[5'd14][5'd16] = 4'b1010;
    assign location[5'd15][5'd16] = 4'b1000;
    assign location[5'd16][5'd16] = 4'b1100;   
    assign location[5'd17][5'd16] = 4'b1001;
    assign location[5'd18][5'd16] = 4'b1010;
    assign location[5'd19][5'd16] = 4'b1010;
    assign location[5'd20][5'd16] = 4'b1010;   
    assign location[5'd21][5'd16] = 4'b0110;
    assign location[5'd22][5'd16] = 4'b0101;
    assign location[5'd23][5'd16] = 4'b0011;
    assign location[5'd24][5'd16] = 4'b0110;  
    assign location[5'd25][5'd16] = 4'b0101;
    assign location[5'd26][5'd16] = 4'b1001;
    assign location[5'd27][5'd16] = 4'b1100;
    assign location[5'd28][5'd16] = 4'b0101;   
    assign location[5'd29][5'd16] = 4'b0011;
    assign location[5'd30][5'd16] = 4'b1010;
    assign location[5'd31][5'd16] = 4'b1100;
    
    assign location[5'd0][5'd17] = 4'b0001;   //up right down left
    assign location[5'd1][5'd17] = 4'b1110;
    assign location[5'd2][5'd17] = 4'b0101;
    assign location[5'd3][5'd17] = 4'b1001;
    assign location[5'd4][5'd17] = 4'b0110;   
    assign location[5'd5][5'd17] = 4'b1001;
    assign location[5'd6][5'd17] = 4'b1010;
    assign location[5'd7][5'd17] = 4'b1100;
    assign location[5'd8][5'd17] = 4'b1001;   
    assign location[5'd9][5'd17] = 4'b1000;
    assign location[5'd10][5'd17] = 4'b0110;
    assign location[5'd11][5'd17] = 4'b1101;
    assign location[5'd12][5'd17] = 4'b0011;   
    assign location[5'd13][5'd17] = 4'b1010;
    assign location[5'd14][5'd17] = 4'b1010;
    assign location[5'd15][5'd17] = 4'b0110;
    assign location[5'd16][5'd17] = 4'b0101;   
    assign location[5'd17][5'd17] = 4'b0001;
    assign location[5'd18][5'd17] = 4'b1100;
    assign location[5'd19][5'd17] = 4'b1101;
    assign location[5'd20][5'd17] = 4'b1001;   
    assign location[5'd21][5'd17] = 4'b1100;
    assign location[5'd22][5'd17] = 4'b0011;
    assign location[5'd23][5'd17] = 4'b1100;
    assign location[5'd24][5'd17] = 4'b1001;  
    assign location[5'd25][5'd17] = 4'b0100;
    assign location[5'd26][5'd17] = 4'b0101;
    assign location[5'd27][5'd17] = 4'b0011;
    assign location[5'd28][5'd17] = 4'b0110;   
    assign location[5'd29][5'd17] = 4'b1011;
    assign location[5'd30][5'd17] = 4'b1010;
    assign location[5'd31][5'd17] = 4'b0110;
    
    assign location[5'd0][5'd18] = 4'b0011;   //up right down left
    assign location[5'd1][5'd18] = 4'b1000;
    assign location[5'd2][5'd18] = 4'b0110;
    assign location[5'd3][5'd18] = 4'b0101;
    assign location[5'd4][5'd18] = 4'b1001;   
    assign location[5'd5][5'd18] = 4'b0010;
    assign location[5'd6][5'd18] = 4'b1110;
    assign location[5'd7][5'd18] = 4'b0101;
    assign location[5'd8][5'd18] = 4'b0111;   
    assign location[5'd9][5'd18] = 4'b0011;
    assign location[5'd10][5'd18] = 4'b1010;
    assign location[5'd11][5'd18] = 4'b0010;
    assign location[5'd12][5'd18] = 4'b1100;
    assign location[5'd13][5'd18] = 4'b1001;
    assign location[5'd14][5'd18] = 4'b1110;
    assign location[5'd15][5'd18] = 4'b1001;
    assign location[5'd16][5'd18] = 4'b0100;   
    assign location[5'd17][5'd18] = 4'b0111;
    assign location[5'd18][5'd18] = 4'b0001;
    assign location[5'd19][5'd18] = 4'b0010;
    assign location[5'd20][5'd18] = 4'b0110;   
    assign location[5'd21][5'd18] = 4'b0011;
    assign location[5'd22][5'd18] = 4'b1000;
    assign location[5'd23][5'd18] = 4'b0100;
    assign location[5'd24][5'd18] = 4'b0111;  
    assign location[5'd25][5'd18] = 4'b0101;
    assign location[5'd26][5'd18] = 4'b0001;
    assign location[5'd27][5'd18] = 4'b1010;
    assign location[5'd28][5'd18] = 4'b1100;   
    assign location[5'd29][5'd18] = 4'b1001;
    assign location[5'd30][5'd18] = 4'b1010;
    assign location[5'd31][5'd18] = 4'b1100;
    
    assign location[5'd0][5'd19] = 4'b1100;   //up right down left
    assign location[5'd1][5'd19] = 4'b0011;
    assign location[5'd2][5'd19] = 4'b1100;
    assign location[5'd3][5'd19] = 4'b0101;
    assign location[5'd4][5'd19] = 4'b0101;   
    assign location[5'd5][5'd19] = 4'b1101;
    assign location[5'd6][5'd19] = 4'b1001;
    assign location[5'd7][5'd19] = 4'b0010;
    assign location[5'd8][5'd19] = 4'b1010;   
    assign location[5'd9][5'd19] = 4'b1110;
    assign location[5'd10][5'd19] = 4'b1001;
    assign location[5'd11][5'd19] = 4'b1010;
    assign location[5'd12][5'd19] = 4'b0110;   
    assign location[5'd13][5'd19] = 4'b0101;
    assign location[5'd14][5'd19] = 4'b1001;
    assign location[5'd15][5'd19] = 4'b0110;
    assign location[5'd16][5'd19] = 4'b0011;   
    assign location[5'd17][5'd19] = 4'b1010;
    assign location[5'd18][5'd19] = 4'b0110;
    assign location[5'd19][5'd19] = 4'b1001;
    assign location[5'd20][5'd19] = 4'b1100;   
    assign location[5'd21][5'd19] = 4'b1011;
    assign location[5'd22][5'd19] = 4'b0100;
    assign location[5'd23][5'd19] = 4'b0011;
    assign location[5'd24][5'd19] = 4'b1010;  
    assign location[5'd25][5'd19] = 4'b0110;
    assign location[5'd26][5'd19] = 4'b0101;
    assign location[5'd27][5'd19] = 4'b1011;
    assign location[5'd28][5'd19] = 4'b0110;   
    assign location[5'd29][5'd19] = 4'b0011;
    assign location[5'd30][5'd19] = 4'b1110;
    assign location[5'd31][5'd19] = 4'b0101;
    
    assign location[5'd0][5'd20] = 4'b0001;   //up right down left
    assign location[5'd1][5'd20] = 4'b1010;
    assign location[5'd2][5'd20] = 4'b0010;
    assign location[5'd3][5'd20] = 4'b0110;
    assign location[5'd4][5'd20] = 4'b0101;   
    assign location[5'd5][5'd20] = 4'b0101;
    assign location[5'd6][5'd20] = 4'b0011;
    assign location[5'd7][5'd20] = 4'b1100;
    assign location[5'd8][5'd20] = 4'b1001;   
    assign location[5'd9][5'd20] = 4'b1010;
    assign location[5'd10][5'd20] = 4'b0100;
    assign location[5'd11][5'd20] = 4'b1001;
    assign location[5'd12][5'd20] = 4'b1010;   
    assign location[5'd13][5'd20] = 4'b0110;
    assign location[5'd14][5'd20] = 4'b0011;
    assign location[5'd15][5'd20] = 4'b1010;
    assign location[5'd16][5'd20] = 4'b1100;   
    assign location[5'd17][5'd20] = 4'b1011;
    assign location[5'd18][5'd20] = 4'b1100;
    assign location[5'd19][5'd20] = 4'b0101;
    assign location[5'd20][5'd20] = 4'b0111;   
    assign location[5'd21][5'd20] = 4'b1001;
    assign location[5'd22][5'd20] = 4'b0110;
    assign location[5'd23][5'd20] = 4'b1011;
    assign location[5'd24][5'd20] = 4'b1000;  
    assign location[5'd25][5'd20] = 4'b1100;
    assign location[5'd26][5'd20] = 4'b0011;
    assign location[5'd27][5'd20] = 4'b1100;
    assign location[5'd28][5'd20] = 4'b1001;   
    assign location[5'd29][5'd20] = 4'b1010;
    assign location[5'd30][5'd20] = 4'b1010;
    assign location[5'd31][5'd20] = 4'b0110;
    
    assign location[5'd0][5'd21] = 4'b0101;   //up right down left
    assign location[5'd1][5'd21] = 4'b1001;
    assign location[5'd2][5'd21] = 4'b1100;
    assign location[5'd3][5'd21] = 4'b1001;
    assign location[5'd4][5'd21] = 4'b0100;   
    assign location[5'd5][5'd21] = 4'b0011;
    assign location[5'd6][5'd21] = 4'b1010;
    assign location[5'd7][5'd21] = 4'b0110;
    assign location[5'd8][5'd21] = 4'b0101;   
    assign location[5'd9][5'd21] = 4'b1011;
    assign location[5'd10][5'd21] = 4'b0010;
    assign location[5'd11][5'd21] = 4'b0000;
    assign location[5'd12][5'd21] = 4'b1100;   
    assign location[5'd13][5'd21] = 4'b1011;
    assign location[5'd14][5'd21] = 4'b1100;
    assign location[5'd15][5'd21] = 4'b1001;
    assign location[5'd16][5'd21] = 4'b0010;   
    assign location[5'd17][5'd21] = 4'b1010;
    assign location[5'd18][5'd21] = 4'b0110;
    assign location[5'd19][5'd21] = 4'b0011;
    assign location[5'd20][5'd21] = 4'b1100;   
    assign location[5'd21][5'd21] = 4'b0101;
    assign location[5'd22][5'd21] = 4'b1001;
    assign location[5'd23][5'd21] = 4'b1100;
    assign location[5'd24][5'd21] = 4'b0101;  
    assign location[5'd25][5'd21] = 4'b0101;
    assign location[5'd26][5'd21] = 4'b1101;
    assign location[5'd27][5'd21] = 4'b0011;
    assign location[5'd28][5'd21] = 4'b0110;   
    assign location[5'd29][5'd21] = 4'b1001;
    assign location[5'd30][5'd21] = 4'b1010;
    assign location[5'd31][5'd21] = 4'b1100;
    
    assign location[5'd0][5'd22] = 4'b0001;   //up right down left
    assign location[5'd1][5'd22] = 4'b0110;
    assign location[5'd2][5'd22] = 4'b0101;
    assign location[5'd3][5'd22] = 4'b0101;
    assign location[5'd4][5'd22] = 4'b0011;   
    assign location[5'd5][5'd22] = 4'b1010;
    assign location[5'd6][5'd22] = 4'b1110;
    assign location[5'd7][5'd22] = 4'b1001;
    assign location[5'd8][5'd22] = 4'b0110;   
    assign location[5'd9][5'd22] = 4'b1001;
    assign location[5'd10][5'd22] = 4'b1100;
    assign location[5'd11][5'd22] = 4'b0101;
    assign location[5'd12][5'd22] = 4'b0011;   
    assign location[5'd13][5'd22] = 4'b1010;
    assign location[5'd14][5'd22] = 4'b0110;
    assign location[5'd15][5'd22] = 4'b0011;
    assign location[5'd16][5'd22] = 4'b1000;   
    assign location[5'd17][5'd22] = 4'b1010;
    assign location[5'd18][5'd22] = 4'b1010;
    assign location[5'd19][5'd22] = 4'b1010;
    assign location[5'd20][5'd22] = 4'b0110;   
    assign location[5'd21][5'd22] = 4'b0001;
    assign location[5'd22][5'd22] = 4'b0110;
    assign location[5'd23][5'd22] = 4'b0101;
    assign location[5'd24][5'd22] = 4'b0101;  
    assign location[5'd25][5'd22] = 4'b0101;
    assign location[5'd26][5'd22] = 4'b0001;
    assign location[5'd27][5'd22] = 4'b1010;
    assign location[5'd28][5'd22] = 4'b1110;   
    assign location[5'd29][5'd22] = 4'b0101;
    assign location[5'd30][5'd22] = 4'b1001;
    assign location[5'd31][5'd22] = 4'b0110;
    
    assign location[5'd0][5'd23] = 4'b0011;   //up right down left
    assign location[5'd1][5'd23] = 4'b1110;
    assign location[5'd2][5'd23] = 4'b0011;
    assign location[5'd3][5'd23] = 4'b0010;
    assign location[5'd4][5'd23] = 4'b1010;   
    assign location[5'd5][5'd23] = 4'b1010;
    assign location[5'd6][5'd23] = 4'b1010;
    assign location[5'd7][5'd23] = 4'b0010;
    assign location[5'd8][5'd23] = 4'b1010;   
    assign location[5'd9][5'd23] = 4'b0110;
    assign location[5'd10][5'd23] = 4'b0111;
    assign location[5'd11][5'd23] = 4'b0011;
    assign location[5'd12][5'd23] = 4'b1010;   
    assign location[5'd13][5'd23] = 4'b1010;
    assign location[5'd14][5'd23] = 4'b1010;
    assign location[5'd15][5'd23] = 4'b1110;
    assign location[5'd16][5'd23] = 4'b0011;   
    assign location[5'd17][5'd23] = 4'b1010;
    assign location[5'd18][5'd23] = 4'b1010;
    assign location[5'd19][5'd23] = 4'b1010;
    assign location[5'd20][5'd23] = 4'b1110;   
    assign location[5'd21][5'd23] = 4'b0011;
    assign location[5'd22][5'd23] = 4'b1110;
    assign location[5'd23][5'd23] = 4'b0011;
    assign location[5'd24][5'd23] = 4'b0110;  
    assign location[5'd25][5'd23] = 4'b0011;
    assign location[5'd26][5'd23] = 4'b0010;
    assign location[5'd27][5'd23] = 4'b1010;
    assign location[5'd28][5'd23] = 4'b1010;   
    assign location[5'd29][5'd23] = 4'b0110;
    assign location[5'd30][5'd23] = 4'b0011;
    assign location[5'd31][5'd23] = 4'b1110;
    
    assign move = ((key_valid == 1) && (key_down[last_change] == 1) && ((last_change == 9'h1D)||(last_change == 9'h1C)||(last_change == 9'h1B)||(last_change == 9'h23)));
    
    always@*    //decide the direction
    if(move)
    begin
        case(last_change)
        9'h1D: dire = 2'b00;//up
        9'h23: dire = 2'b01;//right
        9'h1B: dire = 2'b10;//down
        9'h1C: dire = 2'b11;//left 
        default dire = 2'b00;
        endcase
    end
    else
        dire = 2'b00;
        
        
    always@*
    if(move)
    begin 
        case(dire)
            2'b00://up
            begin 
                if(location[column][row][3] == 0)
                    begin
                        next_row = row-1;
                        next_column = column;
                        move_enable = 1'b1;
                    end
                else
                    begin 
                        next_row = row;
                        next_column = column;
                        move_enable = 1'b0;
                    end
            end
            
            2'b01://right
            begin 
                if(location[column][row][2] == 0)
                    begin
                        next_row = row;
                        next_column = column+1;
                        move_enable = 1'b1;
                    end
                else
                    begin 
                        next_row = row;
                        next_column = column;
                        move_enable = 1'b0;
                    end
            end
            
            2'b10:  //down
            begin 
                if(location[column][row][1] == 0)
                    begin
                        next_row = row+1;
                        next_column = column;
                        move_enable = 1'b1;
                    end
                else
                    begin 
                        next_row = row;
                        next_column = column;
                        move_enable = 1'b0;
                    end
            end
            
            2'b11://left
            begin 
                if(location[column][row][0] == 0)
                    begin
                        next_row = row;
                        next_column = column-1;
                        move_enable = 1'b1;
                    end
                else
                    begin 
                        next_row = row;
                        next_column = column;
                        move_enable = 1'b0;
                    end
            end
            
            default:
                begin 
                    next_row = row;
                    next_column = column;
                    move_enable = 1'b0;
                end
        endcase
        end
        else
        begin
             next_row = row;
             next_column = column;
             move_enable = 1'b0;  
        end
    
    always@(posedge clk or posedge rst)
        if(rst)
        begin 
            row <= 5'b00000;
            column <= 5'b00000;
         end
         
         else
         begin
            row <= next_row;
            column <= next_column;
         end
         
     assign locate = location[column][row];
    
endmodule
