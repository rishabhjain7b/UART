// PIPO : Parallel In Parallel Out

module PIPO #(parameter pipo_width=8)
( input clk,load,
  input [pipo_width-1:0]in,
  output [pipo_width-1:0]out);

 reg [pipo_width-1:0]out_r;

 assign out=out_r;

 always @ (posedge clk)
 begin
	if (load)
	begin
	out_r <= in; 
	end
	else
	out_r <= out_r;
 end
endmodule
