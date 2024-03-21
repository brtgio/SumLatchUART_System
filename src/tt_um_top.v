/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    top (
        .clk(clk), 
        .reset_n(rst_n),
        .save_a_n(uio_in[5]),
        .save_b_n(uio_in[6]),
        .data_input(uio_in[4:0]),
        .uart_txd(uio_out[1]),
        .uart_tx_busy(uio_out[2])
    );
  // All output pins must be assigned. If not used, assign to 0.
    assign uio_out [7:3] = 5'b00000;
    assign uo_out [7:0] = 8'b00000000;
    assign uio_eo [7:0] = 8'b00000000;;

endmodule
