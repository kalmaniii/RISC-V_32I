/*
    file: instruction_mem.sv
    brief: Block ram to represent the instruction memory used by the CPU.
*/
`timescale 1ns / 1ps
`include "../common/isa.svh"

module InstructionMem(
    input var logic [31:0] pc,
    output var logic [31:0] instruction
);

    (* ram_style = "block" *) var logic [7:0] instruction_memory [31:0];
    
    initial begin
        $readmemh("C:/Users/sanch/Documents/FPGA_Programming/RISC-V_32IM/src/instructions.mem", instruction_memory); // Load BRAM from .mem file
    end

    assign instruction = {
        instruction_memory[{pc[4:2], 2'b11}], 
        instruction_memory[{pc[4:2], 2'b10}], 
        instruction_memory[{pc[4:2], 2'b01}], 
        instruction_memory[{pc[4:2], 2'b00}]
    };

endmodule