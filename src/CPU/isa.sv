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

/****** OPCODES ******/
`define OPCODE_ALU    7'b0110011
`define OPCODE_ALUI   7'b0010011
`define OPCODE_LOAD   7'b0000011
`define OPCODE_STORE  7'b0100011
`define OPCODE_BRANCH 7'b1100011
`define OPCODE_JUL    7'b1101111
`define OPCODE_JULR   7'b1100111
`define OPCODE_LUI    7'b0110111
`define OPCODE_AUILPC 7'b0010111
`define OPCODE_ECALL  7'b1110011
`define OPCODE_EBREAK `OPCODE_EBREAK


/****** FUNCT3 ******/
// R-TYPE
`define FUNCT3_SUB  3'b000
`define FUNCT3_ADD  3'b000
`define FUNCT3_XOR  3'b100
`define FUNCT3_OR   3'b110
`define FUNCT3_AND  3'b111
`define FUNCT3_SLL  3'b001
`define FUNCT3_SRL  3'b101
`define FUNCT3_SRA  3'b101
`define FUNCT3_SLT  3'b010
`define FUNCT3_SLTU 3'b011
// I-TYPE
`define FUNCT3_ADDI  3'b000
`define FUNCT3_XORI  3'b100
`define FUNCT3_ORI   3'b110
`define FUNCT3_ANDI  3'b111
`define FUNCT3_SLLI  3'b001
`define FUNCT3_SRLI  3'b101
`define FUNCT3_SRAI  3'b101
`define FUNCT3_SLTI  3'b010
`define FUNCT3_SLTIU 3'b011


/****** FUNCT7 ******/
// R-type
`define FUNCT7_ADD  7'b0000000
`define FUNCT7_SUB  7'b0100000
`define FUNCT7_XOR  7'b0000000
`define FUNCT7_OR   7'b0000000
`define FUNCT7_AND  7'b0000000
`define FUNCT7_SLL  7'b0000000
`define FUNCT7_SRL  7'b0000000
`define FUNCT7_SRA  7'b0000100
`define FUNCT7_SLT  7'b0000000
`define FUNCT7_SLTU 7'b0000000
// I-type
`define FUNCT7_SLLI 7'b0000000
`define FUNCT7_SRLI 7'b0000000
`define FUNCT7_SRAI 7'b0100000


/****** ALU SELECT ******/
`define ALU_SELECT_NOP        3'b000
`define ALU_SELECT_ARITHMETIC 3'b001
`define ALU_SELECT_LOAD       3'b010


/****** ALU OPERATIONS ******/
`define ALU_OPERATIONS_NOP  8'h00
// arithmetic
`define ALU_OPERATIONS_SUB  8'h01
`define ALU_OPERATIONS_ADD  8'h02
`define ALU_OPERATIONS_ADDI 8'h03
// logical
`define ALU_OPERATIONS_OR   8'h04
`define ALU_OPERATIONS_XOR  8'h05
`define ALU_OPERATIONS_AND  8'h06
`define ALU_OPERATIONS_ORI  8'h07
`define ALU_OPERATIONS_XORI 8'h08
`define ALU_OPERATIONS_ANDI 8'h09
// shift
`define ALU_OPERATIONS_SLL   8'h0A
`define ALU_OPERATIONS_SRL   8'h0B
`define ALU_OPERATIONS_SRA   8'h0C
`define ALU_OPERATIONS_SLT   8'h0D
`define ALU_OPERATIONS_SLTU  8'h0E
`define ALU_OPERATIONS_SLLI  8'h0F
`define ALU_OPERATIONS_SRLI  8'h10
`define ALU_OPERATIONS_SRAI  8'h11
`define ALU_OPERATIONS_SLTI  8'h12
`define ALU_OPERATIONS_SLTIU 8'h13


/****** FUNCT INDEX ******/
`define INDEX_OPCODE 6:0

`define INDEX_FUNCT3_RTYPE 14:12
`define INDEX_FUNCT3_ITYPE 14:12

`define INDEX_FUNCT7_RTYPE 31:25
`define INDEX_FUNCT7_ITYPE 31:25

`define INDEX_IMM_ITYPE 31:20

`endif