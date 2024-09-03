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
`define OPCODE_EBREAK `OPCODE_ECALL


/****** FUNCT3 ******/
// R-TYPE
`define FUNCT3_SUB  3'h0
`define FUNCT3_ADD  3'h0
`define FUNCT3_XOR  3'h4
`define FUNCT3_OR   3'h6
`define FUNCT3_AND  3'h7
`define FUNCT3_SLL  3'h1
`define FUNCT3_SRL  3'h5
`define FUNCT3_SRA  3'h5
`define FUNCT3_SLT  3'h2
`define FUNCT3_SLTU 3'h3
// I-TYPE
`define FUNCT3_ADDI  3'h0
`define FUNCT3_XORI  3'h4
`define FUNCT3_ORI   3'h6
`define FUNCT3_ANDI  3'h7
`define FUNCT3_SLLI  3'h1
`define FUNCT3_SRLI  3'h5
`define FUNCT3_SRAI  3'h5
`define FUNCT3_SLTI  3'h2
`define FUNCT3_SLTIU 3'h3
// LOAD
`define FUNCT3_LB   3'h0 
`define FUNCT3_LH   3'h1 
`define FUNCT3_LW   3'h2 
`define FUNCT3_LBU  3'h4 
`define FUNCT3_LHU  3'h5 
// STORE
`define FUNCT3_SB   3'h0 
`define FUNCT3_SH   3'h1 
`define FUNCT3_SW   3'h2
// BRANCH
`define FUNCT3_BEQ  3'h0
`define FUNCT3_BNE  3'h1
`define FUNCT3_BLT  3'h4
`define FUNCT3_BGE  3'h5
`define FUNCT3_BLTU 3'h6
`define FUNCT3_BGEU 3'h7


/****** FUNCT7 ******/
// arithmetic
`define FUNCT7_ADD  7'b0000000 // 0x0
`define FUNCT7_SUB  7'b0100000 // 0x20
`define FUNCT7_XOR  7'b0000000 // 0x0
`define FUNCT7_OR   7'b0000000 // 0x0
`define FUNCT7_AND  7'b0000000 // 0x0
`define FUNCT7_SLL  7'b0000000 // 0x0
`define FUNCT7_SRL  7'b0000000 // 0x0
`define FUNCT7_SRA  7'b0000100 // 0x4
`define FUNCT7_SLT  7'b0000000 // 0x0
`define FUNCT7_SLTU 7'b0000000 // 0x0
// arithmetic imm
`define FUNCT7_SLLI 7'b0000000 // 0x0
`define FUNCT7_SRLI 7'b0000000 // 0x0
`define FUNCT7_SRAI 7'b0100000 // 0x20
// environment
`define FUNCT7_ECALL 1'b0
`define FUNCT7_EBREAK 1'b1



/****** ALU SELECT ******/
`define ALU_SELECT_NOP        4'h0
`define ALU_SELECT_ARITHMETIC 4'h1
`define ALU_SELECT_LOAD       4'h2
`define ALU_SELECT_STORE      4'h3
`define ALU_SELECT_BRANCH     4'h4
`define ALU_SELECT_JUL        4'h5
`define ALU_SELECT_JULR       4'h6
`define ALU_SELECT_LUI        4'h7
`define ALU_SELECT_AUILPC     4'h8
`define ALU_SELECT_ECALL      4'h9

/****** ALU OPERATIONS ******/
`define ALU_OPERATIONS_NOP    8'h00
// arithmetic
`define ALU_OPERATIONS_SUB    8'h01
`define ALU_OPERATIONS_ADD    8'h02
// logical
`define ALU_OPERATIONS_OR     8'h03
`define ALU_OPERATIONS_XOR    8'h04
`define ALU_OPERATIONS_AND    8'h05
// shift
`define ALU_OPERATIONS_SLL    8'h06
`define ALU_OPERATIONS_SRL    8'h07
`define ALU_OPERATIONS_SRA    8'h08
`define ALU_OPERATIONS_SLT    8'h09
`define ALU_OPERATIONS_SLTU   8'h0A
// loads
`define ALU_OPERATIONS_LB     8'h0B
`define ALU_OPERATIONS_LH     8'h0C
`define ALU_OPERATIONS_LW     8'h0D
`define ALU_OPERATIONS_LBU    8'h0E
`define ALU_OPERATIONS_LHU    8'h0F
// stores
`define ALU_OPERATIONS_SB     8'h10
`define ALU_OPERATIONS_SH     8'h11
`define ALU_OPERATIONS_SW     8'h12
// branches
`define ALU_OPERATIONS_BEQ    8'h13
`define ALU_OPERATIONS_BNE    8'h14
`define ALU_OPERATIONS_BLT    8'h15
`define ALU_OPERATIONS_BGE    8'h16
`define ALU_OPERATIONS_BLTU   8'h17
`define ALU_OPERATIONS_BGEU   8'h18
// jumps
`define ALU_OPERATIONS_JAL    8'h19
`define ALU_OPERATIONS_JALR   8'h1A
// upper
`define ALU_OPERATIONS_LUI    8'h1B
`define ALU_OPERATIONS_AUIPC  8'h1C
// environment
`define ALU_OPERATIONS_ECALL  8'h1D
`define ALU_OPERATIONS_EBREAK 8'h1E

/****** FUNCT INDEX ******/
`define INDEX_OPCODE 6:0

`define INDEX_FUNCT3 14:12
`define INDEX_FUNCT7 31:25

`define INDEX_IMM_ITYPE 31:20

`endif