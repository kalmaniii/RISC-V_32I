`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 01:45:46 PM
// Design Name: 
// Module Name: instruction_mem.sv
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

module InstructionMem(
    input wire logic clk,
    input wire logic rst_n,
    input var logic [31:0] pc,
    output var logic [31:0] instruction
);

    (* ram_style = "block" *) var logic [7:0] instruction_memory [31:0];
    
    initial begin
        $readmemh("instructions.mem", instruction_memory); // Load BRAM from .mem file
    end

    assign instruction = {
        instruction_memory[{pc[4:2], 2'b11}], 
        instruction_memory[{pc[4:2], 2'b10}], 
        instruction_memory[{pc[4:2], 2'b01}], 
        instruction_memory[{pc[4:2], 2'b00}]
    };

endmodule