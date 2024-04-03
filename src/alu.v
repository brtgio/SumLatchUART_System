module alu (
    input clk,            // Clock signal
    input reset_n,        // Reset signal
    input [3:0] OP_select,      // Operation selection signal
    input signed [3:0] a,        // First operand (4 bits), signed
    input signed [3:0] b,        // Second operand (4 bits), signed
    output [7:0] result   // Operation result (8 bits)
);

// Registers to maintain internal state
reg [7:0] internal_result;

// Sequential process to perform operations on each rising edge of the clock
always @(posedge clk or posedge reset_n) begin
    if (reset_n) begin
        // Reset: clear the result register
        internal_result <= 8'b0;
    end else begin
        // Operation selection based on the selection signal
        case (OP_select)
            4'b0001: internal_result <= {4'b0000, a} + {4'b0000, b}; // Addition
            4'b0010: internal_result <= {4'b0000, a} - {4'b0000, b}; //  Subtraction
            4'b1110: internal_result <= {4'b0000, a} / {4'b0000, b}; // Division
            4'b0011: internal_result <= {4'b0000, a} & {4'b0000, b}; // AND
            4'b0100: internal_result <= {4'b0000, a} | {4'b0000, b}; // OR
            4'b0101: internal_result <= {4'b0000, a} ^ {4'b0000, b}; // XOR
            4'b0110: internal_result <= {4'b0000, a} * {4'b0000, b}; // Multiplication
            4'b0111: internal_result <= {4'b0000, a} << 1; // Left shift
            4'b1000: internal_result <= {4'b0000, a} >> 1; // Right shift
            4'b1001: internal_result <= ~{4'b0000, a}; // Ones' complement
            4'b1010: internal_result <= (a == b) ? 8'b00000001 : 8'b00000000; // Equality
            4'b1011: internal_result <= (a != b) ? 8'b00000001 : 8'b00000000; // Inequality
            4'b1100: internal_result <= (a > b) ? 8'b00000001 : 8'b00000000; // Greater than
            4'b1101: internal_result <= (a < b) ? 8'b00000001 : 8'b00000000; // Less than
            default: internal_result <= 8'b0; // If no operation matches, result is 0
        endcase
    end
end

// Assign the result to the output
assign result = internal_result;

endmodule


