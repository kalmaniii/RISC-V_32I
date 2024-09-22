/*
    file: alu_control.sv
    brief: Drives "alu_operation" to provide the ALU context on what operation to perform.
*/
`timescale 1ns / 1ps
`include "../common/isa.svh"

module ALUControl(
    input var logic [2:0] funct3,
    input var logic [6:0] funct7,
    input var logic [6:0] opcode,
    input var logic [3:0] alu_select,
    output var logic [5:0] alu_operation
);

    always_comb begin
        unique case(alu_select)
            `ALU_SELECT_ARITHMETIC: begin: ARITHMETIC
                if (funct7 == `FUNCT7_MULTIPLY)
                    unique case(funct3)
                        `FUNCT3_MUL: alu_operation = `ALU_OPERATIONS_MUL;
                        `FUNCT3_MULH: alu_operation = `ALU_OPERATIONS_MULH;
                        `FUNCT3_MULSU: alu_operation = `ALU_OPERATIONS_MULSU;
                        `FUNCT3_MULU: alu_operation = `ALU_OPERATIONS_MULU;
                        `FUNCT3_DIV: alu_operation = `ALU_OPERATIONS_DIV;
                        `FUNCT3_DIVU: alu_operation = `ALU_OPERATIONS_DIVU;
                        `FUNCT3_REM: alu_operation = `ALU_OPERATIONS_REM;
                        `FUNCT3_REMU: alu_operation = `ALU_OPERATIONS_REMU;
                        default: alu_operation = `ALU_OPERATIONS_NOP;
                    endcase
                else
                    unique case(funct3)
                        `FUNCT3_SUB,
                        `FUNCT3_ADD: begin
                            if (opcode == `OPCODE_ALUI)
                                alu_operation = `ALU_OPERATIONS_ADD;
                            else if (funct7 == `FUNCT7_ADD)
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
                            if (funct7 == `FUNCT7_SRL)
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
                unique case(funct3)
                    `FUNCT3_LB: alu_operation = `ALU_OPERATIONS_LB; 
                    `FUNCT3_LH: alu_operation = `ALU_OPERATIONS_LH; 
                    `FUNCT3_LW: alu_operation = `ALU_OPERATIONS_LW; 
                    `FUNCT3_LBU: alu_operation = `ALU_OPERATIONS_LBU;
                    `FUNCT3_LHU: alu_operation = `ALU_OPERATIONS_LHU;
                    default: alu_operation = `ALU_OPERATIONS_NOP;
                endcase
            end: LOAD

            `ALU_SELECT_STORE: begin: STORE
                unique case(funct3)
                    `FUNCT3_SB: alu_operation = `ALU_OPERATIONS_SB; 
                    `FUNCT3_SH: alu_operation = `ALU_OPERATIONS_SH; 
                    `FUNCT3_SW: alu_operation = `ALU_OPERATIONS_SW; 
                    default: alu_operation = `ALU_OPERATIONS_NOP;
                endcase
            end: STORE

            `ALU_SELECT_BRANCH: begin: BRANCH
                unique case(funct3)
                    `FUNCT3_BEQ: alu_operation = `ALU_OPERATIONS_BEQ;
                    `FUNCT3_BNE: alu_operation = `ALU_OPERATIONS_BNE;
                    `FUNCT3_BLT: alu_operation = `ALU_OPERATIONS_BLT;
                    `FUNCT3_BGE: alu_operation = `ALU_OPERATIONS_BGE;
                    `FUNCT3_BLTU: alu_operation = `ALU_OPERATIONS_BLTU;
                    `FUNCT3_BGEU: alu_operation = `ALU_OPERATIONS_BGEU;
                    default: alu_operation = `ALU_OPERATIONS_NOP;
                endcase
            end: BRANCH

            `ALU_SELECT_JAL: alu_operation = `ALU_OPERATIONS_JAL;
            `ALU_SELECT_JALR: alu_operation = `ALU_OPERATIONS_JALR;
            `ALU_SELECT_LUI: alu_operation = `ALU_OPERATIONS_LUI;
            `ALU_SELECT_AUILPC: alu_operation = `ALU_OPERATIONS_AUIPC;

            // `ALU_SELECT_NOP
            default: alu_operation = `ALU_OPERATIONS_NOP;
        endcase
    end

endmodule