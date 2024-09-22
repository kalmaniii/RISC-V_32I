`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    
// 
// Create Date: 09/07/2024
// Design Name: 
// Module Name: instruction_parser.sv
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
`include "../common/isa.svh"

module InsructionParser(
    input logic [31:0] instruction,
    output logic [6:0] opcode,
    output logic [4:0] rd_addr,
    output logic [4:0] rs1_addr,
    output logic [4:0] rs2_addr,
    output logic [2:0] funct3,
    output logic [6:0] funct7
);

    assign opcode = instruction[`INDEX_OPCODE];
    assign rd_addr = instruction[`INDEX_RD];
    assign rs1_addr = instruction[`INDEX_RS1];
    assign rs2_addr = instruction[`INDEX_RS2];
    assign funct3 = instruction[`INDEX_FUNCT3];
    assign funct7 = instruction[`INDEX_FUNCT7];

endmodule