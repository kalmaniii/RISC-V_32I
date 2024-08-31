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
    input var logic [31:0] pc,
    output var logic [31:0] instruction
);

    var logic [31:0][31:0] instruction_memory;
    
    initial begin
        foreach (instruction_memory[i]) instruction_memory[i] <= `ADD;
    end

    assign instruction = instruction_memory[pc];

endmodule