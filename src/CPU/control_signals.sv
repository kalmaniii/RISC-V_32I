`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2024 01:45:46 PM
// Design Name: 
// Module Name: control_signals.sv
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

module ControlSignals(
    input wire logic clk,
    input wire logic rst_n,
    input var logic [6:0] opcode,
    input var logic [31:0] instruction,
    output var logic regfile_wr_en,
    output var logic branch_control,
    output var logic mem_to_reg,
    output var logic mem_read,
    output var logic mem_write,
    output var logic rs1_select,
    output var logic rs2_select,
    output var logic [2:0] alu_select,
    output var logic [7:0] alu_operation
);
    
    always_comb begin
        unique case (opcode)
            `OPCODE_ALU: begin: ALU
                regfile_wr_en = 1;
                alu_select = `ALU_SELECT_ARITHMETIC;

                unique case (instruction[`INDEX_FUNCT3_RTYPE])
                    `FUNCT3_SUB,
                    `FUNCT3_ADD: begin
                        if (instruction[`INDEX_FUNCT7_RTYPE] == `FUNCT7_ADD)
                            alu_operation = `ALU_OPERATIONS_ADD;
                        else
                            alu_operation = `ALU_OPERATIONS_SUB;
                    end
                    `FUNCT3_OR: alu_operation = `ALU_OPERATIONS_OR;
                    `FUNCT3_XOR: alu_operation = `ALU_OPERATIONS_XOR;
                    `FUNCT3_AND: alu_operation = `ALU_OPERATIONS_AND;
                    `FUNCT3_SLL: alu_operation = `ALU_OPERATIONS_SLL;
                    `FUNCT3_SRL,
                    `FUNCT3_SRA: begin
                        if (instruction[`INDEX_FUNCT7_RTYPE] == `FUNCT7_SRL)
                            alu_operation = `ALU_OPERATIONS_SRL;
                        else
                            alu_operation = `ALU_OPERATIONS_SRA;
                    end
                    `FUNCT3_SLT: alu_operation = `ALU_OPERATIONS_SLT;
                    `FUNCT3_SLTU: alu_operation = `ALU_OPERATIONS_SLTU;
                    default: alu_operation = `ALU_OPERATIONS_NOP;
                endcase
            end: ALU

            `OPCODE_ALUI: begin: ALUI
                regfile_wr_en = 1;
                alu_select = `ALU_SELECT_ARITHMETIC;

                unique case (instruction[`INDEX_FUNCT3_ITYPE])
                    `FUNCT3_ADDI: alu_operation = `ALU_OPERATIONS_ADDI;
                    `FUNCT3_ORI: alu_operation = `ALU_OPERATIONS_ORI;
                    `FUNCT3_XORI: alu_operation = `ALU_OPERATIONS_XORI;
                    `FUNCT3_ANDI: alu_operation = `ALU_OPERATIONS_ANDI;
                    `FUNCT3_SLLI: alu_operation = `ALU_OPERATIONS_SLLI;
                    `FUNCT3_SRLI,
                    `FUNCT3_SRAI: begin
                        if (instruction[`INDEX_FUNCT7_ITYPE] == `FUNCT7_SRLI)
                            alu_operation = `ALU_OPERATIONS_SRLI;
                        else
                            alu_operation = `ALU_OPERATIONS_SRAI;
                    end
                    `FUNCT3_SLTI: alu_operation = `ALU_OPERATIONS_SLTI;
                    `FUNCT3_SLTIU: alu_operation = `ALU_OPERATIONS_SLTIU;
                    default: alu_operation = `ALU_OPERATIONS_NOP;
                endcase
            end: ALUI

            default: begin
                regfile_wr_en = 0;
                alu_select = `ALU_SELECT_NOP;
                alu_operation = `ALU_OPERATIONS_NOP;
            end
        endcase
        
    end


endmodule