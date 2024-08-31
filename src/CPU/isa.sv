//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 01:51:46 PM
// Design Name: 
// Module Name: isa.sv
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
`define OPCODE_IMM = 7'b0000000;
`define RD = 5'b00000; 
`define FUNCT3_ADDI = 3'b000;
`define RS1 = 5'b00000;
`define IMM = 12'b000000000000;

`define NOP {`IMM, `RS1, `FUNCT3_ADDI, `RD, `OPCODE_IMM};

`define ADDI {12'b000000000001, 5'b00001, 3'b000, 5'b00010, 7'b0000001};