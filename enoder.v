// when a signal arrives, encoder keeps it with reg until receive a reset signal from counter. When encoder 
module encoder(
    input wire[2:0] msr,// operation = {minute_add, sec_to_zero, reset}
    input wire encoder_reset,// on receiving this, put the output low to 0
    output reg[1:0] operate
);

// madd 10
// sto0 01
// res  11
// nor  00
always @* begin

    if (encoder_reset) begin
        operate = 0;
    end

    if (msr[2]) begin
        operate = 2'b10;
    end

    if (msr[1]) begin
        operate = 2'b01;
    end

    if (msr[0]) begin
        operate = 2'b11;
    end

end

endmodule