// PISO : Parallel In Serial Out 

module PISO #(parameter piso_width=9)
( input clk,shift,start,load,
  input [piso_width-1:0]in,
  output out);

 reg out_r;
 reg [piso_width-1:0]in_r;

 assign out=out_r;

 always @ (posedge clk)
 begin
	if (load)
	in_r <= in;
	else if (start)
	out_r <= 1'b0; 
	else if (shift)
	begin
	out_r <= in_r[0];
	in_r <= {1'b0,in_r[piso_width-1:1]};
	end
	else
	out_r <= out_r;
 end
endmodule
