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
    output var logic [31:0] reg_result
);

    // internal logic
    var logic [31:0] pc;
    var logic [31:0] instruction;
    var logic [31:0] branch_address;
    var logic pc_src;

    var logic [31:0] reg_a;
    var logic [31:0] reg_b;
    
    ProgramCounter program_counter(
        .clk(clk),
        .rst_n(rst_n),
        .pc_src(pc_src),
        .branch_address(branch_address),
        .pc(pc)
    );

    InstructionMem instructions(
        .pc(pc),
        .instruction(instruction)
    );

    RegisterFile register_file(
        .clk(clk),
        .rst_n(rst_n),
        .reg_wr(1'b1),
        .reg_wr_addr(instruction[11:7]),
        .reg_wr_data(reg_result),
        .reg_a_addr(instruction[19:15]),
        .reg_b_addr(instruction[24:20]),
        .reg_a_data(reg_a),
        .reg_b_data(reg_b)
    );

    ALU alu(
        .reg_a(reg_a),
        .reg_rdx(reg_b),
        .result(reg_result)
    );

    
endmodule