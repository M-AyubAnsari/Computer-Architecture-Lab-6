`timescale 1ns / 1ps
module ALU(
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  ALUControl,
    output reg [31:0] ALUResult,
    output Zero
    );

    always @(*)
    begin
        case (ALUControl)
        
            4'b0000: ALUResult = A & B; // AND Operation        
            4'b0001: ALUResult = A | B; // OR Operation           
            4'b0010: ALUResult = A + B; // Add operation             
            4'b0110: ALUResult = A - B; // Sub Operation            
            4'b0011: ALUResult = A ^ B; // XOR operation            
            4'b0100: ALUResult = A << B[4:0]; // SLL Operation           
            4'b0101: ALUResult = A >> B[4:0]; // SRL Operation
                       
            default: ALUResult = 32'b0; // Default case
            
        endcase
    end
    assign Zero = (ALUResult == 32'b0); // Zero result triggered if 32 bit answer is equal to 0.

endmodule
