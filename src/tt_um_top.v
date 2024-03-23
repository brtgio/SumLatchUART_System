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

    toptop #(
    ) top_inst (
        .clk(ui_in[7]),          // Asignando el bit 7 de ui_in (clk) al puerto clk del módulo top_inst
        .reset_n(ui_in[6]),      // Asignando el bit 6 de ui_in (rst_n) al puerto reset_n del módulo top_inst
        .save_a_n(uio_in[5]),    // Asignando el bit 5 de uio_in al puerto save_a_n del módulo top_inst
        .save_b_n(uio_in[4]),    // Asignando el bit 4 de uio_in al puerto save_b_n del módulo top_inst
        .data_input(ui_in[3:0]), // Asignando los bits 0 a 3 de ui_in al puerto data_input del módulo top_inst
        .uart_txd(uio_out[0]),   // Asignando el bit 0 de uio_out al puerto uart_txd del módulo top_inst
        .uart_tx_busy(uo_out[7]) // Asignando el bit 7 de uo_out (uart_tx_busy) al puerto uart_tx_busy del módulo top_inst
    );
    
    // Asignando los bits no usados a 0
    assign uo_out [7:1] = 7'b0000000;
    assign uio_out [7:1] = 7'b0000000;
    
    // Configurando uio_oe como entrada (asignando todos los bits a 1)
    assign uio_oe [7:0] = 8'b11111111;

endmodule




