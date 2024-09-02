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
`include "isa.sv"

module RV_CPU(
    input wire logic clk,
    input wire logic rst_n,
    output var logic [31:0] reg_destination
);

    /**** internal logic ****/
    // program counter
    var logic [31:0] pc;
    var logic [31:0] branch_address = 0;
    var logic pc_src = 0;

    // instruction memory
    var logic [31:0] instruction;
    
    // control signals
    var logic regfile_wr_en;
    // var logic branch_control;
    // var logic mem_to_reg;
    // var logic mem_read;
    // var logic mem_write;
    // var logic rs1_select;
    // var logic rs2_select;
    var logic [2:0] alu_select;
    var logic [7:0] alu_operation;

    // immediate generator
    var logic [31:0] imm_value;
    
    // register file
    var logic [31:0] reg_s1;
    var logic [31:0] reg_s2;
    
    ProgramCounter program_counter(
        .clk(clk),
        .rst_n(rst_n),
        .pc_src(pc_src),
        .branch_address(branch_address),
        .pc(pc)
    );

    InstructionMem instructions(
        .clk(clk),
        .rst_n(rst_n),
        .pc(pc),
        .instruction(instruction)
    );

    ControlSignals control_signals(
        .clk(clk),
        .rst_n(rst_n),
        .opcode(instruction[6:0]),
        .instruction(instruction),
        .regfile_wr_en(regfile_wr_en),
        .branch_control(),
        .mem_to_reg(),
        .mem_read(),
        .mem_write(),
        .rs1_select(),
        .rs2_select(),
        .alu_select(alu_select),
        .alu_operation(alu_operation)
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
        .reg_wr_data(reg_destination),
        .reg_s1_data(reg_s1),
        .reg_s2_data(reg_s2)
    );

    ALU alu(
        .clk(clk),
        .rst_n(rst_n),
        .alu_select(alu_select),
        .alu_operation(alu_operation),
        .imm_value(imm_value),
        .reg_s1(reg_s1),
        .reg_s2(reg_s2),
        .reg_destination(reg_destination)
    );

    
endmodule