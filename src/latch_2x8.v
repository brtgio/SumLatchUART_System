module latch_2x8(
    input clk,              // Reloj
    input reset_n,          // Pulsador de reset (activo en bajo)
    input save_a_n,         // Pulsador de save A (activo en bajo)
    input save_b_n,         // Pulsador de save B (activo en bajo)
    input [3:0] data_input, // Entrada de 4 bits para controlar el latch
    output [3:0] a,   // Salida del latch A de 4 bits
    output  [3:0] b    // Salida del latch B de 4 bits
);

reg [3:0] latch_a; // Latch del grupo A de 4 bits
reg [3:0] latch_b; // Latch del grupo B de 4 bits

// Proceso para controlar el latch A
always @(posedge clk) begin
    if (reset_n) begin
        latch_a <= 4'b0; // Resetea el latch A cuando se activa el reset
    end else if (!save_a_n) begin // Guarda en el latch A si se activa el botón de guardar A
        latch_a <= data_input; // Guarda los 4 bits de entrada en el latch A
    end
end

// Proceso para controlar el latch B
always @(posedge clk) begin
    if (reset_n) begin
        latch_b <= 4'b0; // Resetea el latch B cuando se activa el reset
    end else if (!save_b_n) begin // Guarda en el latch B si se activa el botón de guardar B
        latch_b <= data_input; // Guarda los 4 bits de entrada en el latch B
    end
end

// Asignación de las salidas de los latches A y B
	assign q_a = latch_a;
	assign q_b = latch_b;
endmodule









