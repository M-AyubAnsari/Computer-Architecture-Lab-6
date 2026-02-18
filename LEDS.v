`timescale 1ns / 1ps

module leds(
    input clk,
    input rst,
    input [31:0] data_in,
    output reg [15:0] leds
    );

    always @(posedge clk or posedge rst)
    begin
        if (rst)
            leds <= 16'b0;
        else
            leds <= data_in[15:0];   // display lower 16 bits
    end

endmodule
