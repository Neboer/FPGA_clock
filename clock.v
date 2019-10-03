`include "counter.v"
`include "display.v"
`timescale 1ns / 1ps



module clock(
    input wire clk,
    input wire reset,
    output wire[7:0] shape,
    output wire[3:0] choose_light_sig
    );
    
    wire clk_s;
    wire[3:0] mX, mU, sX, sU;
    wire[7:0] digit_shape;
    wire[3:0] which_to_light;

    sec_pulse pulse(
        reset,
        clk,
        clk_s
    );

    the_core core(
        reset,
        clk_s,
        mX, mU, sX, sU
    );

    display video_card(
        clk,
        mX, mU, sX, sU,
        digit_shape,
        which_to_light
    );

    assign shape = digit_shape;
    assign choose_light_sig = which_to_light;
    
endmodule
