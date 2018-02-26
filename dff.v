// D-Flip Flop for UART IP

module dff
(input clk,rst_n,
 input in,
 output reg q);

always @ (posedge clk, negedge rst_n)
begin 
	if (!rst_n)
	q <= 0;
	else
	q <= in;
end 

endmodule

