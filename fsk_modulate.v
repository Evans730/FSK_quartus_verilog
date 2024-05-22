`timescale 1ns / 1ps

module fsk_modulate(clk,enable,shuchu,clk1,code);//顶层
 
input clk,enable;
output shuchu,clk1,code;
 
wire [7:0] dt;
reg clk1=0;
 
wire [10:0] dout1,dout2;
wire code;
wire [10:0] shuchu;
reg [9:0] sum1=0;
 
always @(negedge clk)
begin
sum1<=sum1+1;     //计数，看什么时候下一个周期，用来控制下一个码元的出现
if(sum1==10'd1023)
	clk1=~clk1;
end
wave_gen wave_gen(.clk(clk),.dout1(dout1),.dout2(dout2));
DDS DDS(.clk(clk1),.enable(enable),.code(code),.dt(dt)); 
switch switch(.clk(clk),.code(code),.dataout(shuchu),.d1(dout1),.d2(dout2));
endmodule
module switch(clk,code,dataout,d1,d2);
input clk;
input code;
input d1,d2;
wire [10:0] d1,d2;
output dataout;
reg [10:0]dataout;
always @(negedge clk)
    begin
        case(code)
        1'b1:dataout<=d1;
        1'b0:dataout<=d2;
        endcase
    end
endmodule
