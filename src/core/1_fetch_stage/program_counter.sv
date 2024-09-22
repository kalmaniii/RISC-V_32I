/*
    file: program_counter.sv
    brief: Resolves the value of the PC.
*/
`timescale 1ns / 1ps

module ProgramCounter(
    input wire logic clk,
    input wire logic rst_n,
    input var logic branch_taken,
    input var logic is_jal_instruction,
    input var logic is_jalr_instruction,
    input var logic [31:0] jalr_address,
    input var logic [31:0] branch_address,
    output var logic [31:0] pc
);

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) pc <= 0;
        else begin
            if (branch_taken || is_jal_instruction) pc <= pc + (branch_address << 1);
            else if (is_jalr_instruction) pc <= jalr_address;
            else pc <= pc + 4;
        end
    end

endmodule