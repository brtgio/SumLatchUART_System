/* Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_top (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    toptop  top_inst (
        .clk(ui_in [7]),         // Clock connected to the most significant bit of ui_in
        .reset_n(ui_in [0]),      // Reset signal connected to the least significant bit of ui_in
        .save_a_n(ui_in [1]),     // Save_a_n signal connected to the second least significant bit of ui_in
        .save_b_n(ui_in [2]),     // Save_b_n signal connected to the third least significant bit of ui_in
        .data_input(ui_in [6:3]), // Data_input signal connected to bits [6:3] of ui_in
        .uart_txd(uio_out [0]),   // UART transmit data connected to the least significant bit of uio_out
        .uart_tx_busy(uio_out [7]) // UART transmit busy signal connected to the most significant bit of uio_out
    );

    // Assigning the non-used output bits to 0
    assign uo_out [7:0] = 8'b00000000;

    // Configuring uio_oe as output (assigning all bits to 1)
    assign uio_oe [7:0] = 8'b11111111;
endmodule





