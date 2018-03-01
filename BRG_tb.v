// Testbench for Baud Rate generator

//`timescale 1ns/1ps #271.2675 #10850.7
 
module BRG_tb #(parameter sel=3'b000);
reg fclk;
 //input [2:0]sel,
wire bclk,bclkx8;

BRG #(.sel(sel)) baud_rate_generator (.fclk(fclk),.bclk(bclk),.bclkx8(bclkx8));

initial
fclk=1'b0;

always
#222.65 fclk=~fclk;

initial 
#183000.3 $stop;

endmodule
