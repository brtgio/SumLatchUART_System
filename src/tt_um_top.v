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
    input  wire       enable,   // enable signal
    input  wire       clock,    // clock signal
    input  wire       reset     // reset signal
);

    uart_tx uart_inst (
        .clk(clock),                // Connect top-level clock signal
        .resetn(~reset),            // Connect top-level reset signal (inverted)
        .uart_tx_en(enable),       // Connect enable signal to UART transmitter
        .uart_tx_data(ui_in[6:3]), // Connect data_input signal to UART transmitter
        .uart_txd(uio_out[0]),     // UART transmit data connected to the least significant bit of uio_out
        .uart_tx_busy(uio_out[7])  // UART transmit busy signal connected to the most significant bit of uio_out
    );

    // Assigning the non-used output bits to 0
    assign uo_out[7:0] = 8'b00000000;

    // Configuring uio_oe as output (assigning all bits to 1)
    assign uio_oe[7:0] = 8'b11111111;

endmodule





