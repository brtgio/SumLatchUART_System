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

    top #(
        .bits(5)
    top_inst (
        .clk(clk),
        .reset_n(rst_n),
        .save_a_n(ui_in[0]),
        .save_b_n(ui_in[1]),
        .data_input(ui_in[4:2]),
        .uart_tx_en(ena),
        .uart_txd(uio_out[1]),
        .uart_tx_busy(uio_out[2])
    );
    
    assign uio_out[7:3] = 5'b00000;
    assign uo_out[7:0] = 8'b00000000;
    assign uio_oe[7:0] = 8'b00000000;

endmodule


