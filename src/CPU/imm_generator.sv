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
// 
//////////////////////////////////////////////////////////////////////////////////
`include "isa.sv"

module ImmGen(
    input wire logic clk,
    input wire logic rst_n,
    input var logic [31:0] instruction,
    output var logic [31:0] imm_value
);
    
    always_comb begin
        unique case(instruction[`INDEX_OPCODE])
            `OPCODE_ALUI: begin
                imm_value = {{20{instruction[31]}}, instruction[`INDEX_IMM_ITYPE]};
            end
            default: begin
                imm_value = 0;
            end
        endcase
    end
        
    

endmodule