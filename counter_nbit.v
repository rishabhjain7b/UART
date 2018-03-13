// N-bit upcounter for UART IP

module counter_nbit #(parameter n=4)
(input clk,clear,inc,
 output [n-1:0]out);

reg [n-1:0]out_r={n{1'b0}};

assign out=out_r;

always @ (posedge clk)
begin
	if(clear)
	out_r <= {n{1'b0}};
	else if (inc)
	out_r <= out_r+1;
	else 
	out_r <= out_r;
end
endmodule
