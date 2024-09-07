`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 01:45:46 PM
// Design Name: 
// Module Name: data_mem.sv
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
`include "../common/isa.svh"

module DataMem(
    input wire logic clk,
    input var logic mem_rd_en,
    input var logic mem_wr_en,
    input var logic mem_data_select,
    input var logic [7:0] alu_operation,
    input var logic [31:0] reg_data_b,
    input var logic [31:0] alu_result,
    output var logic [31:0] writeback_result
);
    (* ram_style = "block" *) var logic [31:0] data_memory [7:0];
    initial begin
        foreach (data_memory[i]) data_memory[i] <= '0;
    end

    var logic [31:0] data_result;

    // STORE
    always_ff @(posedge clk) begin
        if (mem_rd_en == 0 && mem_wr_en == 1) begin
            unique case(alu_operation)
                `ALU_OPERATIONS_SB: data_memory[alu_result][7:0] <= reg_data_b[7:0];
                `ALU_OPERATIONS_SH: data_memory[alu_result][15:0] <= reg_data_b[15:0];
                `ALU_OPERATIONS_SW: data_memory[alu_result] <= reg_data_b;
                default: data_memory[alu_result] <= data_memory[alu_result];
            endcase
        end
    end

    // LOAD
    always_comb begin
        data_result = '0;
        if (mem_rd_en == 1 && mem_wr_en == 0)
            data_result = data_memory[alu_result];
    end

    // WRITE BACK RESULT
    always_comb begin
        if (mem_data_select)
            unique case(alu_operation)
                `ALU_OPERATIONS_LB,
                `ALU_OPERATIONS_LBU: writeback_result = {24'b0, data_result[7:0]};
                `ALU_OPERATIONS_LH,
                `ALU_OPERATIONS_LHU: writeback_result = {16'b0, data_result[15:0]};
                `ALU_OPERATIONS_LW: writeback_result = data_result;
                default: writeback_result = data_result;
            endcase
        else
            writeback_result = alu_result;
    end

endmodule