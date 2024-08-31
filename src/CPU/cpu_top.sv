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
    input wire clk,
    input wire rst_n
);

    // internal logic
    var logic [31:0] pc = 0;
    var logic [31:0] instruction = 0;
    
    ProgramCounter program_counter(.clk(clk), .rst_n(rst_n), .pc(pc));

    InstructionMem instructions(.pc(pc), .instruction(instruction));


    
endmodule