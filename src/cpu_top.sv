/*
    file: cpu_top.sv
    brief: The top level module that connnects required modules to construct a RISC-V CPU
*/
`timescale 1ns / 1ps
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

    // instruction parser
    var logic [6:0] opcode;
    var logic [4:0] rd_addr;
    var logic [4:0] rs1_addr;
    var logic [4:0] rs2_addr;
    var logic [2:0] funct3;
    var logic [6:0] funct7;
    
    // control signals
    var logic regfile_wr_en;
    var logic is_branch_instruction;
    var logic is_jal_instruction;
    var logic is_jalr_instruction;
    var logic mem_data_select;
    var logic mem_rd_en;
    var logic mem_wr_en;
    var logic reg_select_b;
    var logic [3:0] alu_select;
    var logic [5:0] alu_operation;

    // immediate generator
    var logic [31:0] imm_value;
    
    // ALU
    var logic [31:0] alu_operand1;
    var logic [31:0] reg_data_b;
    var logic [31:0] alu_operand2;
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
        .pc(pc[31:2]),
        .instruction(instruction)
    );

    InsructionParser instruction_parser(
        .instruction(instruction),
        .opcode(opcode),
        .rd_addr(rd_addr),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .funct3(funct3),
        .funct7(funct7)
    );

    ControlSignals control_signals(
        .opcode(opcode),
        .regfile_wr_en(regfile_wr_en),
        .is_branch_instruction(is_branch_instruction),
        .is_jal_instruction(is_jal_instruction),
        .is_jalr_instruction(is_jalr_instruction),
        .mem_data_select(mem_data_select),
        .mem_rd_en(mem_rd_en),
        .mem_wr_en(mem_wr_en),
        .reg_select_b(reg_select_b),
        .alu_select(alu_select)
    );

    ImmGen imm_gen(
        .instruction(instruction),
        .imm_value(imm_value)
    );

    RegisterFile register_file(
        .clk(clk),
        .rst_n(rst_n),
        .regfile_wr_en(regfile_wr_en),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .wr_addr(rd_addr),
        .wr_data(writeback_result),
        .reg_data_a(alu_operand1),
        .reg_data_b(reg_data_b)
    );

    ALUOperand get_operand(
        .reg_select_b(reg_select_b),
        .reg_data_b(reg_data_b),
        .imm_value(imm_value),
        .alu_operand2_data(alu_operand2)
    );

    ALUControl alu_control(
        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode),
        .alu_select(alu_select),
        .alu_operation(alu_operation)
    );

    ALU alu(
        .pc(pc),
        .is_branch_instruction(is_branch_instruction),
        .alu_operation(alu_operation),
        .operand1(alu_operand1),
        .operand2(alu_operand2),
        .alu_result(alu_result),
        .branch_taken(branch_taken),
        .jalr_address(jalr_address)
    );

    DataMem data_mem(
        .clk(clk),
        .mem_rd_en(mem_rd_en),
        .mem_wr_en(mem_wr_en),
        .alu_operation(alu_operation),
        .wr_data(reg_data_b),
        .mem_addr(alu_result),
        .mem_data(memory_data)
    );

    WriteBack write_back(
        .mem_data_select(mem_data_select),
        .alu_operation(alu_operation),
        .alu_result(alu_result),
        .data_result(memory_data),
        .writeback_result(writeback_result)
    );
    
endmodule