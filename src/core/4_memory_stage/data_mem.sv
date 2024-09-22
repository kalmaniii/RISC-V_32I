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
    var logic [7:0] load_byte_value;
    var logic [15:0] load_half_value;
    var logic [31:0] load_word_value;
    
    (* ram_style = "block" *) var logic [7:0] data_memory [31:0];
    initial begin
        $readmemh("C:/Users/sanch/Documents/FPGA_Programming/RISC-V_32IM/src/ROM.mem", data_memory); // load binary
    end

    // STORE
    always_ff @(posedge clk) begin
        if (mem_rd_en == 0 && mem_wr_en == 1)
            unique case(alu_operation)
                `ALU_OPERATIONS_SB: data_memory[mem_addr] <= wr_data[7:0];
                `ALU_OPERATIONS_SH: {data_memory[mem_addr + 1], data_memory[mem_addr]} <= wr_data[15:0];
                `ALU_OPERATIONS_SW: {data_memory[mem_addr + 3], data_memory[mem_addr + 2], data_memory[mem_addr + 1], data_memory[mem_addr]} <= wr_data;
                default: data_memory[mem_addr] <= data_memory[mem_addr];
            endcase
        else
            data_memory[mem_addr] <= data_memory[mem_addr];
    end

    // LOAD
    always_comb begin
        load_byte_value = data_memory[mem_addr];
        load_half_value = {data_memory[mem_addr + 1], data_memory[mem_addr]};
        load_word_value = {data_memory[mem_addr + 3], data_memory[mem_addr + 2], data_memory[mem_addr + 1], data_memory[mem_addr]};

        if (mem_rd_en == 1 && mem_wr_en == 0)
            unique case(alu_operation)
                `ALU_OPERATIONS_LB: mem_data = {{24{load_byte_value[7]}}, load_byte_value};
                `ALU_OPERATIONS_LH: mem_data = {{16{load_half_value[15]}}, load_half_value};
                `ALU_OPERATIONS_LW: mem_data = load_word_value;
                `ALU_OPERATIONS_LBU: mem_data = {24'b0, load_byte_value};
                `ALU_OPERATIONS_LHU: mem_data = {16'b0, load_half_value};
                default: mem_data = '0;
            endcase
        else
            mem_data = '0;
    end

endmodule