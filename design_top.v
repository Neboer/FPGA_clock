`include "clock.v"

module design_top(
    input wire sys_clk_i,// 50MHz clk siginal
    input wire ext_rst_n,// external reset switch
    output wire[3:0] dtube_cs_n,// which one to lignt
    output wire[7:0] dtube_data// digital shape
);

    clock clock(sys_clk_i, ext_rst_n, dtube_data, dtube_cs_n);

endmodule