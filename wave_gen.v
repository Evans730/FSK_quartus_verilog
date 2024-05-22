`timescale 1ns / 1ps

module wave_gen(clk,dout1,dout2);
 
input clk;
output dout1,dout2;
 
wire [10:0] dout1,dout2;
reg [9:0] addr1 =0,addr2 =0;
 
 
rom rom1(
			.clock(clk),
			.address(addr1),
			.q(dout1)
			);
 
rom rom2(
			.clock(clk),
			.address(addr2),
			.q(dout2)
			);
 
always @(negedge clk)
	begin
		addr1<=addr1+1;
	end
 
always @(negedge clk)
	begin
		addr2<=addr2+2;
	end
endmodule
