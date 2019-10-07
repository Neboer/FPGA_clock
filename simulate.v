`include "design_top.v"
`timescale 1ms/100ns

module simulation();
    reg clk;
    reg reset;
    wire[7:0] digit_shape;
    wire[3:0] which_light;

    initial begin
        clk = 0;
        reset = 0;
        forever #0.5 clk = ~clk;
    end

    initial begin
        #9800
        reset = 1;
        #1500
        reset = 0;
    end
    
    design_top design_top(clk, 1'b0, 1'b0, reset, which_light, digit_shape);

endmodule