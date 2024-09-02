`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2024 01:45:46 PM
// Design Name: 
// Module Name: run_project.sv
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

module sim_cpu();
    logic clk = 0;
    logic rst = 1;
    wire logic [7:0] AN;
    wire logic [7:0] CT;
    
    // Clock definition
    localparam CLK_PERIOD = 10; // 100 Mhz (counter is in ns)
    localparam RST_COUNT = 1; //Clock cycles that reset is high
    
    always begin
        clk = #(CLK_PERIOD/2) ~clk;
    end
    
    // reset definition
    initial begin
        rst = 1;
        #(RST_COUNT*CLK_PERIOD);
        @(posedge clk);
        rst = 0;
    end

    main main_inst(
        .clk(clk),
        .rst_n(~rst),
        .AN(AN),
        .CT(CT)
    );

endmodule