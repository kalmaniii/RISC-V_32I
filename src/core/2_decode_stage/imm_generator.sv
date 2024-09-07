`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2024 01:45:46 PM
// Design Name: 
// Module Name: imm_generator.sv
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
// 0000_0000_0010_0000_1000_1000_0110_0011
//////////////////////////////////////////////////////////////////////////////////
`include "../common/isa.svh"

module ImmGen(
    input wire logic clk,
    input wire logic rst_n,
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
            `OPCODE_AUIPC: imm_value = {instruction[31:12], 12'b0};
            `OPCODE_JAL: imm_value = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            default: begin
                imm_value = 0;
            end
        endcase
    end
        

endmodule