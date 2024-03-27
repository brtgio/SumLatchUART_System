module alu (
    input clk,            // Señal de reloj
    input reset_n,        // Señal de reset
    input [3:0] ena,      // Señal de selección de operación
    input [3:0] a,        // Primer operando (4 bits)
    input [3:0] b,        // Segundo operando (4 bits)
    output [7:0] result   // Resultado de la operación (8 bits)
);

// Registros para mantener el estado interno
reg [7:0] internal_result;

// Proceso secuencial para realizar las operaciones en cada flanco de subida del reloj
always @(posedge clk or posedge reset_n) begin
    if (reset_n) begin
        // En caso de reset, se limpia el registro del resultado
        internal_result <= 8'b0;
    end else begin
        // Selección de la operación basada en la señal de selección
        case (ena)
            4'b0001: internal_result <= {4'b0000, a} + {4'b0000, b}; // Suma
            4'b0010: internal_result <= {4'b0000, a} - {4'b0000, b}; // Resta
            4'b0011: internal_result <= {4'b0000, a} & {4'b0000, b}; // AND
            4'b0100: internal_result <= {4'b0000, a} | {4'b0000, b}; // OR
            4'b0101: internal_result <= {4'b0000, a} ^ {4'b0000, b}; // XOR
            4'b0110: internal_result <= {4'b0000, a} * {4'b0000, b}; // Multiplicación
            4'b0111: internal_result <= {4'b0000, a} << 1; // Desplazamiento a la izquierda (shift left)
            4'b1000: internal_result <= {4'b0000, a} >> 1; // Desplazamiento a la derecha (shift right)
            4'b1001: internal_result <= ~{4'b0000, a}; // Negación de bits (complemento a uno)
            4'b1010: internal_result <= (a == b) ? 8'b00000001 : 8'b00000000; // Igualdad
            4'b1011: internal_result <= (a != b) ? 8'b00000001 : 8'b00000000; // Desigualdad
            4'b1100: internal_result <= (a > b) ? 8'b00000001 : 8'b00000000; // Mayor que
            4'b1101: internal_result <= (a < b) ? 8'b00000001 : 8'b00000000; // Menor que
            default: internal_result <= 8'b0; // Si no coincide con ninguna operación, el resultado es 0
        endcase
    end
end

// Asignación del resultado a la salida
assign result = internal_result;

endmodule

