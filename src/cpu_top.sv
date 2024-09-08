`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 01:45:46 PM
// Design Name: 
// Module Name: cpu_top.sv
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
`include "core/common/isa.svh"

module RVCPU(
    input wire logic clk,
    input wire logic rst_n
);

    /**** internal logic ****/
    // program counter
    var logic [31:0] pc;
    var logic [31:0] jalr_address;
    var logic branch_taken;

    // instruction memory
    var logic [31:0] instruction;
    
    // control signals
    var logic regfile_wr_en;
    var logic is_branch_instruction;
    var logic is_jal_instruction;
    var logic is_jalr_instruction;
    var logic mem_data_select;
    var logic mem_rd_en;
    var logic mem_wr_en;
    var logic reg_b_select;
    var logic [3:0] alu_select;
    var logic [7:0] alu_operation;

    // immediate generator
    var logic [31:0] imm_value;
    
    // ALU
    var logic [31:0] reg_data_a;
    var logic [31:0] reg_data_b;
    var logic [31:0] reg_data_x;
    var logic [31:0] alu_result;

    // memory stage
    var logic [31:0] memory_data;

    // write back
    var logic [31:0] writeback_result;
    
    ProgramCounter program_counter(
        .clk(clk),
        .rst_n(rst_n),
        .branch_taken(branch_taken),
        .branch_address(imm_value),
        .is_jal_instruction(is_jal_instruction),
        .is_jalr_instruction(is_jalr_instruction),
        .jalr_address(jalr_address),
        .pc(pc)
    );

    InstructionMem instruction_mem(
        .clk(clk),
        .rst_n(rst_n),
        .pc(pc),
        .instruction(instruction)
    );

    ControlSignals control_signals(
        .clk(clk),
        .rst_n(rst_n),
        .opcode(instruction[6:0]),
        .regfile_wr_en(regfile_wr_en),
        .is_branch_instruction(is_branch_instruction),
        .is_jal_instruction(is_jal_instruction),
        .is_jalr_instruction(is_jalr_instruction),
        .mem_data_select(mem_data_select),
        .mem_rd_en(mem_rd_en),
        .mem_wr_en(mem_wr_en),
        .reg_b_select(reg_b_select),
        .alu_select(alu_select)
    );

    ImmGen imm_gen(
        .clk(clk),
        .rst_n(rst_n),
        .instruction(instruction),
        .imm_value(imm_value)
    );

    RegisterFile register_file(
        .clk(clk),
        .rst_n(rst_n),
        .regfile_wr_en(regfile_wr_en),
        .instruction(instruction),
        .reg_wr_data(writeback_result),
        .reg_data_a(reg_data_a),
        .reg_data_b(reg_data_b)
    );

    ALUOperand get_operand(
        .reg_b_select(reg_b_select),
        .reg_data_b(reg_data_b),
        .imm_value(imm_value),
        .reg_data_x(reg_data_x)
    );

    ALUControl alu_control(
        .instruction(instruction),
        .alu_select(alu_select),
        .alu_operation(alu_operation)
    );

    ALU alu(
        .clk(clk),
        .rst_n(rst_n),
        .pc(pc),
        .is_branch_instruction(is_branch_instruction),
        .alu_operation(alu_operation),
        .operand1(reg_data_a),
        .operand2(reg_data_x),
        .alu_result(alu_result),
        .branch_taken(branch_taken),
        .jalr_address(jalr_address)
    );

    DataMem data_mem(
        .clk(clk),
        .mem_rd_en(mem_rd_en),
        .mem_wr_en(mem_wr_en),
        .alu_operation(alu_operation),
        .reg_data_b(reg_data_b),
        .alu_result(alu_result),
        .memory_data(memory_data)
    );

    WriteBack write_back(
        .mem_data_select(mem_data_select),
        .alu_operation(alu_operation),
        .alu_result(alu_result),
        .data_result(memory_data),
        .writeback_result(writeback_result)
    );
    
endmodule