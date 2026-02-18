`timescale 1ns / 1ps
module ALUTestBench;

    reg [31:0] A;
    reg [31:0] B;
    reg [3:0]  ALUControl;
    wire [31:0] ALUResult;
    wire Zero;
    
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );
    
    initial
    begin
        // AND Test
        A = 32'h0000000F;
        B = 32'h00000000;
        ALUControl = 4'b0000;
        #10;
        
        // OR Test
        ALUControl = 4'b0001;
        #10;
        
        // ADD Test
        A = 32'd10;
        B = 32'd5;
        ALUControl = 4'b0010;
        #10;
        
        // SUB Test
        ALUControl = 4'b0110;
        #10;
        
        // XOR Test
        ALUControl = 4'b0011;
        #10;

        // SLL Test
        A = 32'd4;     // 100
        B = 32'd2;     // Shifting by 2
        ALUControl = 4'b0100;
        #10;

        // SRL Test
        ALUControl = 4'b0101;
        #10;
        
        // Zero result check
        A = 32'd15;
        B = 32'd15;
        ALUControl = 4'b0110; // SUB
        #10;
        
        $stop;
        
    end
endmodule
