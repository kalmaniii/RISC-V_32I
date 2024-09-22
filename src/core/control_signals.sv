/*
    file: control_signals.sv
    brief: Takes in the current opcode to resolve how to drive the control signals used 
    throughout other modules in the CPU.
*/
`timescale 1ns / 1ps
`include "common/isa.svh"

module ControlSignals(
    input var logic [6:0] opcode,
    output var logic regfile_wr_en,
    output var logic is_branch_instruction,
    output var logic is_jal_instruction,
    output var logic is_jalr_instruction,
    output var logic mem_data_select,
    output var logic mem_rd_en,
    output var logic mem_wr_en,
    output var logic reg_select_b,
    output var logic [3:0] alu_select
);
    
    always_comb begin
        alu_select = `ALU_SELECT_NOP;
        regfile_wr_en = 0;
        reg_select_b = 0;
        mem_data_select = 0;
        mem_rd_en = 0;
        mem_wr_en = 0;
        is_branch_instruction = 0;
        is_jalr_instruction = 0;
        is_jal_instruction = 0;

        unique case (opcode)
            `OPCODE_ALU: begin: ALU
                regfile_wr_en = 1;
                reg_select_b = 1;
                alu_select = `ALU_SELECT_ARITHMETIC;
            end: ALU

            `OPCODE_ALUI: begin: ALUI
                regfile_wr_en = 1;
                alu_select = `ALU_SELECT_ARITHMETIC;
            end: ALUI

            `OPCODE_LOAD: begin: LOAD
                regfile_wr_en = 1;
                mem_data_select = 1;
                mem_rd_en = 1;
                alu_select = `ALU_SELECT_LOAD;
            end: LOAD

            `OPCODE_STORE: begin: STORE
                mem_wr_en = 1;
                alu_select = `ALU_SELECT_STORE;
            end: STORE

            `OPCODE_BRANCH: begin: BRANCH
                reg_select_b = 1;
                is_branch_instruction = 1;
                alu_select = `ALU_SELECT_BRANCH;
            end: BRANCH

            `OPCODE_JAL: begin: JAL
                regfile_wr_en = 1;
                reg_select_b = 1;
                is_jal_instruction = 1;
                alu_select = `ALU_SELECT_JAL;
            end: JAL

            `OPCODE_JALR: begin: JALR
                regfile_wr_en = 1;
                reg_select_b = 1;
                is_jalr_instruction = 1;
                alu_select = `ALU_SELECT_JALR;
            end: JALR

            `OPCODE_LUI: begin: LUI
                regfile_wr_en = 1;
                alu_select = `ALU_SELECT_LUI;
            end: LUI

            `OPCODE_AUIPC: begin: AUIPC
                regfile_wr_en = 1;
                alu_select = `ALU_SELECT_AUILPC;
            end: AUIPC

            default: begin
                alu_select = `ALU_SELECT_NOP;
                regfile_wr_en = 0;
                reg_select_b = 0;
                mem_data_select = 0;
                mem_rd_en = 0;
                mem_wr_en = 0;
                is_branch_instruction = 0;
                is_jalr_instruction = 0;
                is_jal_instruction = 0;
            end
        endcase
    end


endmodule