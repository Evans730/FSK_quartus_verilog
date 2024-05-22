`timescale 1ns / 1ps
module fsk_demodulate_tb;
reg clk=0;
wire dout;
wire [10:0] cnt;
wire [10:0]shuchu;
reg enable=1;
wire  code;
always #2 clk=~clk;
fsk_demodulate fsk_demodulate(.clk(clk),.enable(enable),.cnt(cnt),.dout(dout),.shuchu(shuchu),.code(code));
endmodule
