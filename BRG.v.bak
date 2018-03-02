// Baud Rate Generator for UART IP

// divisor = (fclk/(BRmax*C_samples*2))
//`define BRmax 38400

`define C_samples 4 //2**3=8
`define divisor 2

module BRG #(parameter sel=3'b000)
(input fclk,
 //input [2:0]sel,
 output bclk,bclkx8);

reg clkdiv;
wire bclk_r;
//reg [7:0]limit=2;
//reg bclkx8_r,bclk_r;
reg [1:0]q=2'd0;
//reg [2:0]k=3'd0;

counter_8bit #(.limit(8'd1<<(sel+1))) eight_bits_counter (.clkdiv(clkdiv),.out(bclkx8));

counter_8bit #(.limit(`C_samples)) divide_by_C_reg (.clkdiv(bclkx8),.out(bclk_r));

counter_8bit #(.limit(8'd1<<(sel+1))) divide_by_C (.clkdiv(bclk_r),.out(bclk));

always @ (posedge fclk)
begin
	if (q == `divisor)
	begin
		q <= 2'd0;
		clkdiv <= 1'b0;
	end
	else
	begin
		q <= q+1;
		clkdiv <= 1'b1;
	end
end
endmodule
