/*
    file: alu.sv
    brief: Performs the alu operation on the two incoming operand.
*/
`timescale 1ns / 1ps
`include "../common/isa.svh"

module ALU(
    input var logic [31:0] pc,
    input var logic is_branch_instruction,
    input var logic [5:0] alu_operation,
    input var logic [31:0] operand1,
    input var logic [31:0] operand2,
    output var logic [31:0] alu_result,
    output var logic branch_taken,
    output var logic [31:0] jalr_address
);

    always_comb begin
        alu_result = 0;
        branch_taken = 0;
        jalr_address = 0;
        
        unique case(alu_operation)
            // ARITHMETIC
            `ALU_OPERATIONS_SUB: alu_result = $signed(operand1) - $signed(operand2);
            `ALU_OPERATIONS_ADD: alu_result = $signed(operand1) + $signed(operand2);
            
            // MULTIPLY EXTENSION
            `ALU_OPERATIONS_MUL: alu_result = $signed(operand1) * $signed(operand2);
            `ALU_OPERATIONS_MULH: alu_result = ($signed(operand1) * $signed(operand2)) >> 32;
            `ALU_OPERATIONS_MULSU: alu_result = ($signed(operand1) * operand2) >> 32;
            `ALU_OPERATIONS_MULU: alu_result = (operand1 * operand2) >> 32;
            `ALU_OPERATIONS_DIV: begin
                if (operand2 == 0) 
                    alu_result = 0;
                else
                    alu_result = $signed(operand1) / $signed(operand2);
            end
            `ALU_OPERATIONS_DIVU: begin
                if (operand2 == 0)
                    alu_result = 0;
                else
                    alu_result = operand1 / operand2; 
            end
            `ALU_OPERATIONS_REM: begin
                if (operand2 == 0)
                    alu_result = 0;
                else
                    alu_result = $signed(operand1) % $signed(operand2); 
            end
            `ALU_OPERATIONS_REMU: begin
                if (operand2 == 0)
                    alu_result = 0;
                else
                    alu_result = operand1 % operand2; 
            end

            // LOGICAL
            `ALU_OPERATIONS_OR: alu_result = operand1 | operand2;
            `ALU_OPERATIONS_XOR: alu_result = operand1 ^ operand2;
            `ALU_OPERATIONS_AND: alu_result = operand1 & operand2;

            // SHIFT
            `ALU_OPERATIONS_SLL: alu_result = operand1 << operand2[4:0];
            `ALU_OPERATIONS_SRL: alu_result = operand1 >> operand2[4:0];
            `ALU_OPERATIONS_SRA: alu_result = $signed(operand1) >>> operand2[4:0];
            `ALU_OPERATIONS_SLT: alu_result = $signed(operand1) < $signed(operand2) ? 32'd1:32'd0;
            `ALU_OPERATIONS_SLTU: alu_result = operand1 < operand2 ? 32'd1:32'd0;

            // LOAD
            `ALU_OPERATIONS_LB, 
            `ALU_OPERATIONS_LH,
            `ALU_OPERATIONS_LW,
            `ALU_OPERATIONS_LBU,
            `ALU_OPERATIONS_LHU,
            // STORE
            `ALU_OPERATIONS_SB, 
            `ALU_OPERATIONS_SH,
            `ALU_OPERATIONS_SW: alu_result = operand1 + operand2;

            // BRANCH
            `ALU_OPERATIONS_BEQ: branch_taken = is_branch_instruction && (operand1 == operand2);
            `ALU_OPERATIONS_BNE: branch_taken = is_branch_instruction && (operand1 != operand2);
            `ALU_OPERATIONS_BLT: branch_taken = is_branch_instruction && (operand1 < operand2);
            `ALU_OPERATIONS_BGE: branch_taken = is_branch_instruction && (operand1 >= operand2);
            `ALU_OPERATIONS_BLTU: branch_taken = is_branch_instruction && (operand1 < operand2);
            `ALU_OPERATIONS_BGEU: branch_taken = is_branch_instruction && (operand1 >= operand2);

            // JAL
            `ALU_OPERATIONS_JAL: alu_result = pc + 4;

            // JALR
            `ALU_OPERATIONS_JALR: begin 
                jalr_address = operand1 + operand2;
                alu_result = pc + 4;
            end
            
            // LUI
            `ALU_OPERATIONS_LUI: alu_result = operand2 << 12;

            // AUIPC
            `ALU_OPERATIONS_AUIPC: alu_result = (pc + (operand2 << 12));

            // `ALU_OPERATIONS_NOP
            default: begin
                alu_result = 0;
                branch_taken = 0;
                jalr_address = 0;
            end
        endcase
    end

endmodule