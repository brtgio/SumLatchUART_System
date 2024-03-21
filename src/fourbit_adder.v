module fourbit_adder(
    input [3:0] a,
    input [3:0] b,
    output reg[4:0] sum
);

reg [4:0] sum_intermediate;

always @* begin
    sum_intermediate[0] = a[0] ^ b[0];
    sum_intermediate[1] = a[1] ^ b[1] ^ (a[0] & b[0]);
    sum_intermediate[2] = a[2] ^ b[2] ^ (a[1] & b[1]);
    sum_intermediate[3] = a[3] ^ b[3] ^ (a[2] & b[2]);
    sum_intermediate[4] = (a[3] & b[3]);
end


always @*begin
	sum = sum_intermediate;
end
endmodule














