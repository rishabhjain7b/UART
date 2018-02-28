// Baud Rate Generator for UART IP

// divisor = (fclk/(BRmax*C_samples*2))
//`define BRmax 38400

`define C_samples 8
`define divisor 3

module BRG
(input fclk,
 input [2:0]sel,
 output bclk,bclkx8);

reg clkdiv;
reg [7:0]bits;
reg bclkx8_r,bclk_r;

assign bclkx8 = bclkx8_r,
	bclk = bclk_r;

always @ (posedge fclk)
begin
	clkdiv = fclk/(`divisor);
	case(sel)
	3'b000: bclkx8_r = clkdiv >> 1;
	3'b001: bclkx8_r = clkdiv >> 2;
	3'b010: bclkx8_r = clkdiv >> 3;
	3'b011: bclkx8_r = clkdiv >> 4;
	3'b100: bclkx8_r = clkdiv >> 5;
	3'b101: bclkx8_r = clkdiv >> 6;
	3'b110: bclkx8_r = clkdiv >> 7;
	3'b111: bclkx8_r = clkdiv >> 8;
	endcase
	bclk_r = bclkx8_r/`C_samples;
end
endmodule
