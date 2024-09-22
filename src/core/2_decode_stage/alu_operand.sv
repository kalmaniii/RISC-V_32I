/*
    file: alu_operand.sv
    brief: Drives the ALU second operand with either the value from the register file or the immediate value.
*/
`timescale 1ns / 1ps


module ALUOperand(
    input var logic reg_select_b,
    input var logic [31:0] reg_data_b,
    input var logic [31:0] imm_value,
    output var logic [31:0] alu_operand2_data
);
    
    always_comb begin
        if (reg_select_b) alu_operand2_data <= reg_data_b;
        else alu_operand2_data <= imm_value;
    end

endmodule