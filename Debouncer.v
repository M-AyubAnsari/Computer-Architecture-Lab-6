`timescale 1ns / 1ps

module debouncer(
    input clk,
    input rst,
    input pbin,
    output reg pbout
    );

    reg [19:0] counter;
    reg state;

    parameter DELAY = 20'd500000; 

    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            counter <= 0;
            state <= 0;
            pbout <= 0;
        end
        else
        begin
            if (pbin != state)
            begin
                counter <= counter + 1;
                
                if (counter >= DELAY)
                begin
                    state <= pbin;
                    pbout <= pbin;
                    counter <= 0;
                end
            end
            else
            begin
                counter <= 0;
            end
        end
    end

endmodule
