`timescale 1ns / 1ps
`define hertz 30'd50000000

module sec_pulse(
    input wire clk,// fixed-frquency clock, comes from clk from clock
    input wire[1:0] operation,// operation from encoder
    output reg clk_s=0, // output clock per seconds
    output reg res = 0// output to encoder, let it reset the operation
);

// 
// madd 10
// sto0 01
// res  11
// nor  00

    reg[19:0] count=0; // count the small tick per second
    // integer count;
    always@(posedge clk) begin
        if (count == `hertz - 1)
            begin
                count <= 0;
                clk_s <= 1;
            end
        else if (count == 0)
            begin
                clk_s = 0;
                count <= count +1;
            end
        else
            begin
                count <= count+1;
            end
    end
endmodule

module the_core(
    input wire[0:0] reset,
    input wire[0:0] clk_s,
    output reg[3:0] dis_mX = 0, // a number
    output reg[3:0] dis_mU = 0,
    output reg[3:0] dis_sX = 0,
    output reg[3:0] dis_sU = 0
    );

    reg reset_is_set = 0;

    always@(posedge reset) begin // on reset button presed
        reset_is_set <= 1;
    end

    always@(posedge clk_s) begin // on second
        if (reset_is_set) begin
            dis_mX <= 0;
            dis_mU <= 0;
            dis_sX <= 0;
            dis_sU <= 0;
        end
        // first, check whether needs carry numbers
        if (dis_sU == 4'd9) begin // unit is nine, needs carry
            if (dis_sX == 4'd5) begin// tens is four, needs carry
                if (dis_mU == 4'd9) begin
                    if (dis_mX == 4'd5) begin// full counter space, reset.
                        dis_mX <= 0;
                        dis_mU <= 0;
                        dis_sX <= 0;
                        dis_sU <= 0;
                    end
                    else begin// mU needs carry to mX, and another minute in.
                        dis_sU <= 0;
                        dis_sX <= 0;
                        dis_mU <= 0;
                        dis_mX <= dis_mX + 1;
                    end
                end
                else begin // mU don't need carry, but another minute in.
                    dis_sU <= 0;
                    dis_sX <= 0;
                    dis_mU <= dis_mU + 1;
                end
            end
            else begin// sX don't need carry
                dis_sU <= 0;
                dis_sX <= dis_sX + 1;
            end
        end
        else begin// no carry
            dis_sU <= dis_sU + 1;
        end
    end
endmodule
