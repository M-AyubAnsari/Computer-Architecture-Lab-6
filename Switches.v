`timescale 1ns / 1ps

module switches(
    input clk,
    input rst,
    input [15:0] switches_in,
    output reg [31:0] switches_out
    );

    always @(posedge clk or posedge rst)
    begin
        if (rst)
            switches_out <= 32'b0;
        else
            switches_out <= {16'b0, switches_in};  // zero-extend
    end

endmodule
