// N-bit upcounter for UART IP

module counter_nbit #(parameter n=4)
(input clk,clear,inc,
 output reg [n-1:0]out);

always @ (posedge clk)
begin
	if(clear)
	out <= {n{1'b0}};
	else
	out <= out+1;
end
endmodule
