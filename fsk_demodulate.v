`timescale 1ns / 1ps
module fsk_demodulate(clk,enable,count,cnt,dout,shuchu,code);
input clk,enable;
 
wire code;
output dout;
output count,cnt,shuchu;//count记512(相当于记零点）的个数，cnt记脉冲的个数，shuchu是引的调制的输出
output code;
 
reg [10:0] buffer;
wire[10:0]shuchu;
reg [10:0] cnt=0;
 
reg dout=0;      //输出的为原基带信号  0  1
integer count=0;
 
//实例化部分
//  解调部分采用过零检测的方法，即数一个码元周期内零点的个数，个数多的是高频对应原数字信息1，反之则对应0
wire clk1;
 
always @(negedge clk)
	begin
	buffer<=shuchu;
	cnt<=cnt+1;
	if(buffer==11'd128)
		count<=count+1;
	if(cnt==2047)
		begin
			if(count <= 16)
				dout<=1;
			else
				dout<=0;
			count<=0;
		 end
	end
fsk_modulate fsk_modulate(.clk(clk),.enable(enable),.shuchu(shuchu),.clk1(clk1),.code(code));
endmodule
