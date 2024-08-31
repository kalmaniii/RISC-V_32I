`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 01:31:46 PM
// Design Name: 
// Module Name: seven_seg.sv
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

module SevenSegDisplay #(parameter FREQUENCY = 60)
(
    input wire clk,
    input wire rst_n,
    input var logic [2:0][7:0] value,
    output wire [7:0] AN,
    output wire [7:0] CT
);
    localparam CLKS_PER_MS = 100_000;
    localparam REFRESH_PERIOD = CLKS_PER_MS*(1000/FREQUENCY);
    localparam SEVEN_SEG_DIGIT_PERIOD = REFRESH_PERIOD >> 3; // divide by 8; each digit displays evenly per refersh period

    logic [31:0] refresh_period_counter = 0;
    logic [31:0] seven_seg_digit_period_counter = 0;
    logic [2:0] seven_seg_index = 0;
    logic [7:0] display_position = 8'b1111_1110;
    logic [7:0] display_value = '1;

    always @(posedge clk, negedge rst_n) begin
        if (rst_n == 0) begin
            seven_seg_index <= 0;
            seven_seg_digit_period_counter <= 0;
            refresh_period_counter <= 0;
            display_position <= 8'b1111_1110;
        end
        else begin
            if (refresh_period_counter < REFRESH_PERIOD) begin
                refresh_period_counter <= refresh_period_counter + 1;

                if (seven_seg_digit_period_counter < SEVEN_SEG_DIGIT_PERIOD) begin
                    seven_seg_digit_period_counter <= seven_seg_digit_period_counter + 1;
                end
                else begin
                    seven_seg_digit_period_counter <= 0;
                    seven_seg_index <= seven_seg_index + 1;
                    display_position <= ~(1 << (seven_seg_index + 1));
                end
            end
            else begin
                seven_seg_index <= 0;
                seven_seg_digit_period_counter <= 0;
                refresh_period_counter <= 0;
                display_position <= 8'b1111_1110;
            end
        end
    end

    always @(posedge clk, negedge rst_n) begin
        if (rst_n == 0) begin
            display_value <= '1;
        end
        else begin
            case (value[seven_seg_index])
                //  a = 0, b = 1, c = 2, d = 3, e = 4, f = 5, g = 6, DP = 7
                0:  display_value <= 8'b1100_0000;
                1:  display_value <= 8'b1111_1001; // bc
                2:  display_value <= 8'b1010_0100; // abged
                3:  display_value <= 8'b1011_0000; // abgcd
                4:  display_value <= 8'b1001_1001; // fgbc
                5:  display_value <= 8'b1001_0010; // afgcd
                6:  display_value <= 8'b1000_0010; // afedcg
                7:  display_value <= 8'b1101_1000; // fabc
                8:  display_value <= 8'b1000_0000; // abcdefg
                9:  display_value <= 8'b1001_0000; // abcdfg
                10:  display_value <= 8'b1000_1000; // 10 = A; efabcg
                11:  display_value <= 8'b1000_0011; // 11 = B; cdefg
                12:  display_value <= 8'b1100_0110; // 12 = C; afed
                13:  display_value <= 8'b1010_0001; // 13 = D; bcdeg
                14:  display_value <= 8'b1000_0110; // 14 = E; afedg
                15:  display_value <= 8'b1000_1110; // 15 = F; afeg
                default: display_value <= '1;
            endcase
        end
    end

    assign AN = display_position;
    assign CT = display_value;

endmodule