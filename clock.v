`include "new_counter.v"
`include "encoder.v"
`include "display.v"
`timescale 1ns / 1ps



module clock(
    input wire clk,
    input wire[2:0] msr,
    output wire[7:0] shape,
    output wire[3:0] choose_light_sig
    );
    
    wire clk_s, encoder_reset_sig;
    wire[1:0] operate_sig;
    wire[3:0] mX, mU, sX, sU;

    encoder encoder(msr, encoder_reset_sig, operate_sig);

    counter counter(clk, operate_sig, encoder_reset_sig,
        mX, mU, sX, sU);
    
    display video_card(
        clk,
        mX, mU, sX, sU,
        shape,
        choose_light_sig
    );
    
endmodule
