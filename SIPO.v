// SIPO : Serial In Parallel Out

module SIPO #(parameter sipo_width=8)
( input clk,shift,
  input in,
  output [sipo_width-1:0]out);

 reg [sipo_width-1:0]out_r;

 assign out=out_r;

 always @ (posedge clk)
 begin
	if (shift)
	begin
	out_r <= {in,out_r[sipo_width-1:1]}; 
	end
	else
	out_r <= out_r;
 end
endmodule
