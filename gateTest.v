// code for simulation of all the gates

module gateTest
( input a, b,
  output and_out,or_out,xor_out,not_out,xnor_out,nand_out,nor_out);

assign and_out = a & b,
	or_out = a | b,
	xor_out = a ^ b,
	xnor_out = ~(a ^ b),
	nand_out = ~(a & b),
	nor_out = ~(a | b),
	not_out = ~a;

endmodule
