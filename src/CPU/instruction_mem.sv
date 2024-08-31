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

module InstructionMem(
    input var logic [31:0] pc,
    output var logic [31:0] instruction
);

    var logic [31:0][31:0] instruction_memory;
    initial begin
        // all elemets should be init to 0 (AKA a NOP)
        instruction_memory[100] <= `ADDI;
    end

    assign instruction = instruction_memory[pc];

endmodule