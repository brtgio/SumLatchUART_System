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

    latch_2x8  top_inst (
     .clk(ui_in [0]),         
     .reset_n(ui_in [1]),      
     .save_a_n(ui_in [2]),
     .save_b_n(ui_in [3]),
     .data_input(ui_in [7:4]),
     .q_a(uo_out [3:0]),
     .q_b(uo_out [7:4])
    );
    // Assigning the non-used bits to 0
    assign uio_out [7:0] = 8'b00000000;
    
    
    // Configuring uio_oe as output (assigning all bits to 1)
    assign uio_oe [7:0] = 8'b11111111;
endmodule





