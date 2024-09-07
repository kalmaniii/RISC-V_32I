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
`include "common/isa.svh"

module ControlSignals(
    input wire logic clk,
    input wire logic rst_n,
    input var logic [6:0] opcode,
    output var logic regfile_wr_en,
    output var logic is_branch_instruction,
    output var logic mem_data_select,
    output var logic mem_rd_en,
    output var logic mem_wr_en,
    output var logic reg_b_select,
    output var logic [3:0] alu_select
);
    
    always_comb begin
        unique case (opcode)
            `OPCODE_ALU: begin: ALU
                regfile_wr_en = 1;
                reg_b_select = 1;
                mem_data_select = 0;
                mem_rd_en = 0;
                mem_wr_en = 0;
                is_branch_instruction = 0;
                alu_select = `ALU_SELECT_ARITHMETIC;
            end: ALU

            `OPCODE_ALUI: begin: ALUI
                regfile_wr_en = 1;
                reg_b_select = 0;
                mem_data_select = 0;
                mem_rd_en = 0;
                mem_wr_en = 0;
                is_branch_instruction = 0;
                alu_select = `ALU_SELECT_ARITHMETIC;
            end: ALUI

            `OPCODE_LOAD: begin: LOAD
                regfile_wr_en = 1;
                reg_b_select = 0;
                mem_data_select = 1;
                mem_rd_en = 1;
                mem_wr_en = 0;
                is_branch_instruction = 0;
                alu_select = `ALU_SELECT_LOAD;
            end: LOAD

            `OPCODE_STORE: begin: STORE
                regfile_wr_en = 0;
                reg_b_select = 0;
                mem_data_select = 0;
                mem_rd_en = 0;
                mem_wr_en = 1;
                is_branch_instruction = 0;
                alu_select = `ALU_SELECT_STORE;
            end: STORE

            `OPCODE_BRANCH: begin: BRANCH
                regfile_wr_en = 0;
                reg_b_select = 1;
                mem_data_select = 0;
                mem_rd_en = 0;
                mem_wr_en = 0;
                is_branch_instruction = 1;
                alu_select = `ALU_SELECT_BRANCH;
            end: BRANCH

            default: begin
                regfile_wr_en = 0;
                reg_b_select = 0;
                mem_data_select = 0;
                mem_rd_en = 0;
                mem_wr_en = 0;
                is_branch_instruction = 0;
                alu_select = `ALU_SELECT_NOP;
            end
        endcase
    end


endmodule