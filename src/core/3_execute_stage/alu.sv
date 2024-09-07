`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2024 01:45:46 PM
// Design Name: 
// Module Name: alu.sv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "../common/isa.svh"

module ALU(
    input wire logic clk,
    input wire logic rst_n,
    input var logic is_branch_instruction,
    input var logic [7:0] alu_operation,
    input var logic [31:0] operand1,
    input var logic [31:0] operand2,
    output var logic [31:0] alu_result,
    output var logic branch_taken
);

    always_comb begin
        alu_result = 0;
        branch_taken = 0;
        
        unique case(alu_operation)
            // ARITHMETIC
            `ALU_OPERATIONS_SUB: alu_result = operand1 - operand2;
            `ALU_OPERATIONS_ADD: alu_result = operand1 + operand2;

            // LOGICAL
            `ALU_OPERATIONS_OR: alu_result = operand1 | operand2;
            `ALU_OPERATIONS_XOR: alu_result = operand1 ^ operand2;
            `ALU_OPERATIONS_AND: alu_result = operand1 & operand2;

            // SHIFT
            `ALU_OPERATIONS_SLL: alu_result = operand1 << operand2[4:0];
            `ALU_OPERATIONS_SRL: alu_result = operand1 >> operand2[4:0];
            `ALU_OPERATIONS_SRA: alu_result = $signed(operand1) >>> operand2[4:0];
            `ALU_OPERATIONS_SLT: alu_result = (operand1 < operand2) ? 1:0;
            `ALU_OPERATIONS_SLTU: alu_result = (operand1 < operand2) ? 32'd1 : 32'd0;

            // LOAD
            `ALU_OPERATIONS_LB, 
            `ALU_OPERATIONS_LH,
            `ALU_OPERATIONS_LW,
            `ALU_OPERATIONS_LBU,
            `ALU_OPERATIONS_LHU,
            // STORE
            `ALU_OPERATIONS_SB, 
            `ALU_OPERATIONS_SH,
            `ALU_OPERATIONS_SW: alu_result = operand1 + operand2;

            // BRANCH
            `ALU_OPERATIONS_BEQ: branch_taken = is_branch_instruction && (operand1 == operand2);
            `ALU_OPERATIONS_BNE: branch_taken = is_branch_instruction && (operand1 != operand2);
            `ALU_OPERATIONS_BLT: branch_taken = is_branch_instruction && (operand1 < operand2);
            `ALU_OPERATIONS_BGE: branch_taken = is_branch_instruction && (operand1 >= operand2);
            `ALU_OPERATIONS_BLTU: branch_taken = is_branch_instruction && (operand1 < operand2);
            `ALU_OPERATIONS_BGEU: branch_taken = is_branch_instruction && (operand1 >= operand2);
            
            // `ALU_OPERATIONS_NOP,
            default: begin 
                alu_result = 0;
                branch_taken = 0;
            end
        endcase
    end

endmodule