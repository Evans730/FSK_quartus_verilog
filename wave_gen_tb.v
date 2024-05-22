`timescale 1ns / 1ps

module wave_gen_tb;

reg clk;
wire [10:0] dout1, dout2;

// 实例化被测试模块
wave_gen uut (
    .clk(clk),
    .dout1(dout1),
    .dout2(dout2)
);

// 定义期望的输出值
// 注意：这些值需要根据rom的内容来设置
localparam [10:0] expected_dout1 = 11'h123;
localparam [10:0] expected_dout2 = 11'h456;

// 生成50MHz的时钟信号
always #10 clk = ~clk; // 20ns周期，因此10ns翻转一次

initial begin
    // 初始化输入和测试环境
    clk = 0;
    
    // 运行仿真
    #100; // 等待一段时间以观察初始状态
    
    // 检查dout1和dout2的初始状态是否为x（未定义）
    if (dout1 === 11'bx || dout2 === 11'bx) begin
        $display("Test Passed: Initial state is undefined (x)");
    end else begin
        $display("Test Failed: Initial state is not undefined (x)");
    end
    
    // 仿真运行一定时间，观察输出变化
    #1000; // 等待1000纳秒，即50个时钟周期
    
    // 检查dout1和dout2是否按预期变化
    if (dout1 == expected_dout1 && dout2 == expected_dout2) begin
        $display("Test Passed: Outputs changed as expected");
    end else begin
        $display("Test Failed: Outputs did not change as expected");
    end
    
    // 结束仿真
//    $finish;
end

endmodule
