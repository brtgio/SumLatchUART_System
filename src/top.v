module top(
    input clk,
    input reset_n,
    input save_a_n,
    input save_b_n,
    input [3:0] data_input,
    input uart_tx_en, 
    input uart_tx_en, 
    output uart_txd,
    output  uart_tx_busy
);

// Declaración de registros internos para los datos de entrada de latch
    wire [3:0] a, b; 

// Declaración de registro interno para almacenar la suma
wire [4:0] sum_reg; 

// Instanciación del módulo eight_bit_latch
latch_2x8 latch_inst (
    .clk(clk),
    .reset_n(reset_n),
    .save_a_n(save_a_n),
    .save_b_n(save_b_n),
    .data_input(data_input),
    .q_a(a), // Salida del latch para el primer operando
    .q_b(b)  // Salida del latch para el segundo operando
);

// Instanciación del módulo sum4bit_reg
fourbit_adder sum_inst (
    .a(a),
    .b(b),
    .sum(sum_reg)
);

// Instanciación del módulo uart_tx
uart_tx uart_tx_inst (
    .clk(clk),
    .resetn(reset_n),
    .uart_txd(uart_txd),
    .uart_tx_busy(uart_tx_busy),
    .uart_tx_en(uart_tx_en),
    .uart_tx_data(sum_reg) // Se utiliza la suma como dato a enviar por UART
);

endmodule
