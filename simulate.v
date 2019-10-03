`include "design_top.v"

module simulation();
    reg clk;
    reg reset;
    wire[7:0] digit_shape;
    wire[3:0] which_light;

    initial begin
        clk = 0;
        reset = 0;
    end

    always #0.001
        begin
            clk = ~clk;
        end
    
    design_top design_top(clk, reset, which_light, digit_shape);

endmodule