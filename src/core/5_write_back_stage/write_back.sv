/*
    file: write_back.sv
    brief: Resolves the final value that will be written back to the architectural registers.
*/
`timescale 1ns / 1ps
`include "../common/isa.svh"

module WriteBack(
    input var logic mem_data_select,
    input var logic [5:0] alu_operation,
    input var logic [31:0] alu_result,
    input var logic [31:0] data_result,
    output var logic [31:0] writeback_result
);

    // WRITE BACK RESULT
    always_comb begin
        if (mem_data_select)
            writeback_result = data_result;
        else
            writeback_result = alu_result;
    end

endmodule