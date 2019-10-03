`define minute_add 2'b10
`define sec_to_zero 2'b01
`define clock_reset 2'b11
`define no_operation 2'b00
`define hertz 30'd5000

module counter(
    input wire clk,
    input wire[1:0] operation,
    output reg encoder_reset = 0,
    output reg[3:0] dis_mX = 0, // a number
    output reg[3:0] dis_mU = 0,
    output reg[3:0] dis_sX = 0,
    output reg[3:0] dis_sU = 0
);

    reg[29:0] counts = 0;
// madd 10
// sto0 01
// res  11
// nor  00
    always@(posedge clk) begin
        if (operation) begin
            case (operation)
                2'b10 : 
                    begin
                        if (dis_mU == 9) begin
                            if (dis_mX == 5) begin
                                dis_mX = 0;
                            end
                            dis_mX = dis_mX + 1;
                            dis_mU = 0;
                        end
                        dis_mU = dis_mU + 1;
                    end
                2'b01 : 
                    begin
                        dis_sU = 0;
                        dis_sX = 0;
                    end
                2'b11 :
                    begin
                        dis_sU = 0;
                        dis_sX = 0;
                        dis_mU = 0;
                        dis_mX = 0;
                    end
            endcase
            encoder_reset = 1;
        end
        else begin
            encoder_reset = 0;
        end
        
        if (counts == `hertz) begin// Carry on numbers!!!
            counts = 1;
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
        else begin
            counts = counts + 1;
        end
    end

endmodule