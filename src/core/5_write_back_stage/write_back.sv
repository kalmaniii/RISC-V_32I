`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2024 01:45:46 PM
// Design Name: 
// Module Name: write_back.sv
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

module WriteBack(
    input var logic mem_data_select,
    input var logic alu_operation,
    input var logic [31:0] alu_result,
    input var logic [31:0] data_result,
    output var logic [31:0] writeback_result
);

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