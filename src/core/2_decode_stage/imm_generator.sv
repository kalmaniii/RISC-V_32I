/*
    file: imm_generator.sv
    brief: Creates the sign extended value used for various instructions.
*/
`timescale 1ns / 1ps
`include "../common/isa.svh"

module ImmGen(
    input var logic [31:0] instruction,
    output var logic [31:0] imm_value
);
    
    always_comb begin
        unique case(instruction[`INDEX_OPCODE])
            `OPCODE_ALUI,
            `OPCODE_LOAD,
            `OPCODE_JALR,
            `OPCODE_ECALL,
            `OPCODE_EBREAK: imm_value = {{20{instruction[31]}}, instruction[31:20]};
            `OPCODE_STORE:  imm_value = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            `OPCODE_BRANCH: imm_value = {{21{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8]};
            `OPCODE_LUI,
            `OPCODE_AUIPC: imm_value = {{12{instruction[31]}}, instruction[31:12]};
            `OPCODE_JAL: imm_value = {{12{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21]};
            default: begin
                imm_value = 0;
            end
        endcase
    end
        

endmodule