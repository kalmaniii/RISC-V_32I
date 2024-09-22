/*
    file: data_mem.sv
    brief: Represents the data memory used by the RISC-V CPU.
*/
`timescale 1ns / 1ps
`include "../common/isa.svh"

module DataMem(
    input wire logic clk,
    input var logic mem_rd_en,
    input var logic mem_wr_en,
    input var logic [5:0] alu_operation,
    input var logic [31:0] wr_data,
    input var logic [31:0] mem_addr,
    output var logic [31:0] mem_data
);
    (* ram_style = "block" *) var logic [31:0] data_memory [7:0];
    initial begin
        foreach (data_memory[i]) data_memory[i] <= '0;
    end

    // STORE
    always_ff @(posedge clk) begin
        if (mem_rd_en == 0 && mem_wr_en == 1) begin
            unique case(alu_operation)
                `ALU_OPERATIONS_SB: data_memory[mem_addr][7:0] <= wr_data[7:0];
                `ALU_OPERATIONS_SH: data_memory[mem_addr][15:0] <= wr_data[15:0];
                `ALU_OPERATIONS_SW: data_memory[mem_addr] <= wr_data;
                default: data_memory[mem_addr] <= data_memory[mem_addr];
            endcase
        end
    end

    // LOAD
    always_comb begin
        if (mem_rd_en == 1 && mem_wr_en == 0)
            mem_data = data_memory[mem_addr];
        else
            mem_data = '0;
    end

endmodule