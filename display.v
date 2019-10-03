module display(
    input wire clk,
    input wire[3:0] mX, mU, sX, sU,
    output reg[7:0] shape = 7'b0111111,// the shape of digit screen "8"
    output reg[3:0] choose_light = 4'b1101 // 1101 the third is light up, this value determined which digit will light up.
);
    reg[7:0] digit_shape[0:9];

    always @(posedge clk) begin// do another thing!
        // initialize the seven digital value! TODO: need more 
        digit_shape[0] = 8'h3f;
        digit_shape[1] = 8'h06;
        digit_shape[2] = 8'h5b;
        digit_shape[3] = 8'h4f;
        digit_shape[4] = 8'h66;
        digit_shape[5] = 8'h6d;
        digit_shape[6] = 8'h7d;
        digit_shape[7] = 8'h07;
        digit_shape[8] = 8'h7f;
        digit_shape[9] = 8'h6f;


        //next thing is move right ->
        if (choose_light == 4'b1110)
            begin
                choose_light = 4'b0111;
            end
        else 
            begin
                // we use a trick to do this !
                choose_light = ~((~choose_light) >> 1);// this is soooo tricky, hahahahaha, fun with verilog!
            end
        // now the choose_light will at the right place! show you number now!
        // and there is also a question: find out number 0 is at which bit and determine which number to display.

        case (choose_light) 
        //   0   1   1   1 
        //   ^   ^   ^   ^
        //   mX  mU  sX  sU
        4'b0111: shape <= digit_shape[mX];
        4'b1011: shape <= digit_shape[mU];
        4'b1101: shape <= digit_shape[sX];
        4'b1110: shape <= digit_shape[sU];
        endcase
    end

endmodule