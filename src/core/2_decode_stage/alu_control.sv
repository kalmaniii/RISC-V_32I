`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2024 01:45:46 PM
// Design Name: 
// Module Name: alu_control.sv
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
`include "../common/isa.sv"

module ALUControl(
    input var logic [31:0] instruction,
    input var logic [3:0] alu_select,
    output var logic [7:0] alu_operation
);

    always_comb begin
        unique case(alu_select)
            `ALU_SELECT_ARITHMETIC: begin: ARITHMETIC
                unique case(instruction[`INDEX_FUNCT3])
                    `FUNCT3_SUB,
                    `FUNCT3_ADD: begin
                        if (instruction[`INDEX_OPCODE] == `OPCODE_ALUI)
                            alu_operation = `ALU_OPERATIONS_ADD;
                        else if (instruction[`INDEX_FUNCT7] == `FUNCT7_ADD)
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
                        if (instruction[`INDEX_FUNCT7] == `FUNCT7_SRL)
                            alu_operation = `ALU_OPERATIONS_SRL;
                        else
                            alu_operation = `ALU_OPERATIONS_SRA;
                    end
                    `FUNCT3_SLT: alu_operation = `ALU_OPERATIONS_SLT;
                    `FUNCT3_SLTU: alu_operation = `ALU_OPERATIONS_SLTU;
                    default: alu_operation = `ALU_OPERATIONS_NOP;
                endcase
            end: ARITHMETIC

            `ALU_SELECT_LOAD: begin: LOAD
                unique case(instruction[`INDEX_FUNCT3])
                    `FUNCT3_LB: alu_operation = `ALU_OPERATIONS_LB; 
                    `FUNCT3_LH: alu_operation = `ALU_OPERATIONS_LH; 
                    `FUNCT3_LW: alu_operation = `ALU_OPERATIONS_LW; 
                    `FUNCT3_LBU: alu_operation = `ALU_OPERATIONS_LBU;
                    `FUNCT3_LHU: alu_operation = `ALU_OPERATIONS_LHU;
                    default: alu_operation = `ALU_OPERATIONS_NOP;
                endcase
            end: LOAD

            // `ALU_SELECT_STORE:
            `ALU_SELECT_STORE: begin: STORE
                unique case(instruction[`INDEX_FUNCT3])
                    `FUNCT3_SB: alu_operation = `ALU_OPERATIONS_SB; 
                    `FUNCT3_SH: alu_operation = `ALU_OPERATIONS_SH; 
                    `FUNCT3_SW: alu_operation = `ALU_OPERATIONS_SW; 
                    default: alu_operation = `ALU_OPERATIONS_NOP;
                endcase
            end: STORE

            // `ALU_SELECT_NOP
            default: alu_operation = `ALU_OPERATIONS_NOP;
        endcase
    end

endmodule