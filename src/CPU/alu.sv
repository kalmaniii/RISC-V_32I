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
`include "isa.sv"

module ALU(
    input wire logic clk,
    input wire logic rst_n,
    input var logic [2:0] alu_select,
    input var logic [7:0] alu_operation,
    input var logic [31:0] imm_value,
    input var logic [31:0] reg_s1,
    input var logic [31:0] reg_s2,
    output var logic [31:0] reg_destination
);

    always_comb begin
        unique case(alu_select)
            `ALU_SELECT_ARITHMETIC: begin: ARITHMETIC
                unique case(alu_operation)
                    // register
                    `ALU_OPERATIONS_SUB: reg_destination = reg_s1 - reg_s2;
                    `ALU_OPERATIONS_ADD: reg_destination = reg_s1 + reg_s2;
                    `ALU_OPERATIONS_OR: reg_destination = reg_s1 | reg_s2;
                    `ALU_OPERATIONS_XOR: reg_destination = reg_s1 ^ reg_s2;
                    `ALU_OPERATIONS_AND: reg_destination = reg_s1 & reg_s2;
                    `ALU_OPERATIONS_SLL: reg_destination = reg_s1 << reg_s2;
                    `ALU_OPERATIONS_SRL: reg_destination = reg_s1 >> reg_s2;
                    `ALU_OPERATIONS_SRA: reg_destination = $signed(reg_s1) >>> reg_s2;
                    `ALU_OPERATIONS_SLT: reg_destination = (reg_s1 < reg_s2) ? 1:0;
                    `ALU_OPERATIONS_SLTU: reg_destination = (reg_s1 < reg_s2) ? 32'd1 : 32'd0;
                    
                    // immediate
                    `ALU_OPERATIONS_ADDI: reg_destination = reg_s1 + imm_value;
                    `ALU_OPERATIONS_ORI: reg_destination = reg_s1 | imm_value;
                    `ALU_OPERATIONS_XORI: reg_destination = reg_s1 ^ imm_value;
                    `ALU_OPERATIONS_ANDI: reg_destination = reg_s1 & imm_value;
                    `ALU_OPERATIONS_SLLI: reg_destination = reg_s1 << imm_value[4:0];
                    `ALU_OPERATIONS_SRLI: reg_destination = reg_s1 >> imm_value[4:0];
                    `ALU_OPERATIONS_SRAI: reg_destination = $signed(reg_s1) >>> imm_value[4:0];
                    `ALU_OPERATIONS_SLTI: reg_destination = (reg_s1 < imm_value) ? 1:0;
                    `ALU_OPERATIONS_SLTIU: reg_destination = (reg_s1 < imm_value) ? 32'd1 : 32'd0;
                    
                    // `ALU_OPERATIONS_NOP,
                    default: reg_destination = reg_destination;
                endcase
            end: ARITHMETIC

            `ALU_SELECT_LOAD: begin: LOAD
                unique case(alu_operation)
                    // `ALU_SELECT_NOP: reg_destination = reg_destination;
                    default: reg_destination = reg_destination;
                endcase
            end: LOAD

            // `ALU_SELECT_NOP: reg_destination = reg_destination;
            default: reg_destination = reg_destination;
        endcase
    end

endmodule