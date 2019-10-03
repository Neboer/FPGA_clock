`define minute_add 2'b10
`define sec_to_zero 2'b01
`define clock_reset 2'b11
`define no_operation 2'b00

module counter(
    input wire clk,
    input wire[1:0] operation,
    output reg encoder_reset,
    output reg[3:0] dis_mX = 0, // a number
    output reg[3:0] dis_mU = 0,
    output reg[3:0] dis_sX = 0,
    output reg[3:0] dis_sU = 0
);

// madd 10
// sto0 01
// res  11
// nor  00
    always@(posedge clk) begin
        case (operation)
            2'b10 : 
                begin
                    if (dis_mU == 9) begin
                        if (dis_mX == 5) begin
                            dis_mX = 0;
                        end
                        dis_mX = di
                        
                        s_mX + 1;
                        dis_mU = 0;
                    end
                    dis_mU = dis_mU + 1;

            2'b01 : 
                begin
                    dis_sU <= 0;
                    dis_sX <= 0;
                end
            2'b11 :
                begin
                    dis_sU <= 0;
                    dis_sX <= 0;
                    dis_mU <= 0;
                    dis_mX <= 0;
                end
    end

endmodule