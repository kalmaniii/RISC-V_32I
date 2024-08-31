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
`ifndef ISA_SV
`define ISA_SV

// R-TYPE
`define OPCODE_R 7'b011011  // [6:0]
`define RD_R 5'b00001       // [11:7] -- results will write to register 1
`define FUNCT3_R 3'b000     // [14:12] -- ADD inst
`define RS1_R 5'b00010      // [19:15] -- source is register 2
`define RS2_R 5'b00011      // [24:20] -- source is register 3
`define FUNCT7_R 7'b0000000 // [31:25] -- ADD inst

`define ADD {`FUNCT7_R, `RS2_R, `RS1_R, `FUNCT3_R, `RD_R, `OPCODE_R}

`endif