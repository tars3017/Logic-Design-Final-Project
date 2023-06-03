`define SSD_BIT_WIDTH 8
`define BCD_BIT_WIDTH 4
`define SSD_ZERO   `SSD_BIT_WIDTH'b0000_0011 // 0
`define SSD_ONE    `SSD_BIT_WIDTH'b1001_1111 // 1
`define SSD_TWO    `SSD_BIT_WIDTH'b0010_0101 // 2
`define SSD_THREE  `SSD_BIT_WIDTH'b0000_1101 // 3
`define SSD_FOUR   `SSD_BIT_WIDTH'b1001_1001 // 4
`define SSD_FIVE   `SSD_BIT_WIDTH'b0100_1001 // 5
`define SSD_SIX    `SSD_BIT_WIDTH'b0100_0001 // 6
`define SSD_SEVEN  `SSD_BIT_WIDTH'b0001_1111 // 7
`define SSD_EIGHT  `SSD_BIT_WIDTH'b0000_0001 // 8
`define SSD_NINE   `SSD_BIT_WIDTH'b0000_1001 // 9

module display(
  segs, // 14-segment segs output
  bin  // binary input
);
output [`SSD_BIT_WIDTH-1:0] segs; // 7-segment segs out
input [`BCD_BIT_WIDTH-1:0] bin; // binary input

reg [`SSD_BIT_WIDTH-1:0] segs; 

// Combinatioanl Logic
always @*
  case (bin)
    `BCD_BIT_WIDTH'd0: segs = `SSD_ZERO;
	`BCD_BIT_WIDTH'd1: segs = `SSD_ONE;
	`BCD_BIT_WIDTH'd2: segs = `SSD_TWO;
	`BCD_BIT_WIDTH'd3: segs = `SSD_THREE;
	`BCD_BIT_WIDTH'd4: segs = `SSD_FOUR;
	`BCD_BIT_WIDTH'd5: segs = `SSD_FIVE;
	`BCD_BIT_WIDTH'd6: segs = `SSD_SIX;
	`BCD_BIT_WIDTH'd7: segs = `SSD_SEVEN;
	`BCD_BIT_WIDTH'd8: segs = `SSD_EIGHT;
	`BCD_BIT_WIDTH'd9: segs = `SSD_NINE;
	`BCD_BIT_WIDTH'd10: segs = 8'b11111111;
	`BCD_BIT_WIDTH'd11: segs = 8'b11111111; 
	`BCD_BIT_WIDTH'd12: segs = 8'b11111111;
	`BCD_BIT_WIDTH'd13: segs = 8'b11111111;
	`BCD_BIT_WIDTH'd14: segs = 8'b11111111;
	`BCD_BIT_WIDTH'd15: segs = 8'b11111111;
	 default: segs = 8'b11111111;
  endcase
  
endmodule
