`timescale 1ns / 1ps
module top(
    input clk,
    input rst,
    input [15:0] switches,
    input btn,
    output [15:0] leds
    );
    wire [31:0] A = 32'h10101010;
    wire [31:0] B = 32'h01010101;
    wire [31:0] switch_data;

    switches sw_inst(
        .clk(clk),
        .rst(rst),
        .switches_in(switches),
        .switches_out(switch_data)
    );

    wire btn_clean;

    debouncer db_inst(
        .clk(clk),
        .rst(rst),
        .pbin(btn),
        .pbout(btn_clean)
    );

    wire [3:0] ALUControl;
    assign ALUControl = switch_data[3:0];

    wire [31:0] ALUResult;
    wire Zero;

    ALU alu_inst(
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    reg state;
    parameter IDLE = 1'b0;
    parameter EXECUTE = 1'b1;

    reg [31:0] result_reg;

    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            state <= IDLE;
            result_reg <= 32'b0;
        end
        else
        begin
            case (state)
            
                IDLE:
                begin
                    if (btn_clean)
                        state <= EXECUTE;
                end
                
                EXECUTE:
                begin
                    result_reg <= ALUResult;
                    state <= IDLE;
                end
                
            endcase
        end
    end
    
    
    leds led_inst(
        .clk(clk),
        .rst(rst),
        .data_in(result_reg),
        .leds(leds)
    );

endmodule
