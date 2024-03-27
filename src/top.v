module top (
input clk,
input reset_n,
input save_a_n,
input save_b_n,
input [3:0] ena,
input [3:0] data_input,
input uart_tx_en,
output  uartbusy,
output uart_txd
);

// Declaración de registros internos para los datos de entrada de latch
wire [3:0] a, b; 
wire [7:0] data_send;

// Instancia de latch
latch_2x8 latch_inst (
    .clk(clk),
    .reset_n(!reset_n),
    .save_a_n(save_a_n),
    .save_b_n(save_b_n),
    .data_input(data_input),
    .a(a), // Salida del latch para el primer operando
    .b(b)  // Salida del latch para el segundo operando
);

// Instancia de la ALU
alu alu_inst (
    .clk(clk),
    .reset_n(!reset_n),
    .ena(ena),
    .a(a),
    .b(b),
    .result(data_send));

// Instancia de UART
uart_tx uart_inst (
    .clk(clk),
    .reset_n(reset_n),
    .uart_tx_en(uart_tx_en), // Usando ena[0] para habilitar la transmisión UART
    .uart_tx_data(data_send), // Transmitir el resultado a través de UART
    .uart_txd(uart_txd), // Conectar a la línea de transmisión UART
    .uartbusy(uartbusy) // Indicador de ocupado de UART
);

endmodule
