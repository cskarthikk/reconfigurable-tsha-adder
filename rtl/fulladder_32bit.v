module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule


module thirty_two_bit_adder(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire Cin,
    output wire [31:0] Sum,
    output wire cout
);
    wire [31:0] c;

    full_adder u0  (.a(A[0]),  .b(B[0]),  .cin(Cin),  .sum(Sum[0]),  .cout(c[0]));
    full_adder u1  (.a(A[1]),  .b(B[1]),  .cin(c[0]), .sum(Sum[1]),  .cout(c[1]));
    full_adder u2  (.a(A[2]),  .b(B[2]),  .cin(c[1]), .sum(Sum[2]),  .cout(c[2]));
    full_adder u3  (.a(A[3]),  .b(B[3]),  .cin(c[2]), .sum(Sum[3]),  .cout(c[3]));
    full_adder u4  (.a(A[4]),  .b(B[4]),  .cin(c[3]), .sum(Sum[4]),  .cout(c[4]));
    full_adder u5  (.a(A[5]),  .b(B[5]),  .cin(c[4]), .sum(Sum[5]),  .cout(c[5]));
    full_adder u6  (.a(A[6]),  .b(B[6]),  .cin(c[5]), .sum(Sum[6]),  .cout(c[6]));
    full_adder u7  (.a(A[7]),  .b(B[7]),  .cin(c[6]), .sum(Sum[7]),  .cout(c[7]));
    full_adder u8  (.a(A[8]),  .b(B[8]),  .cin(c[7]), .sum(Sum[8]),  .cout(c[8]));
    full_adder u9  (.a(A[9]),  .b(B[9]),  .cin(c[8]), .sum(Sum[9]),  .cout(c[9]));
    full_adder u10 (.a(A[10]), .b(B[10]), .cin(c[9]), .sum(Sum[10]), .cout(c[10]));
    full_adder u11 (.a(A[11]), .b(B[11]), .cin(c[10]),.sum(Sum[11]), .cout(c[11]));
    full_adder u12 (.a(A[12]), .b(B[12]), .cin(c[11]),.sum(Sum[12]), .cout(c[12]));
    full_adder u13 (.a(A[13]), .b(B[13]), .cin(c[12]),.sum(Sum[13]), .cout(c[13]));
    full_adder u14 (.a(A[14]), .b(B[14]), .cin(c[13]),.sum(Sum[14]), .cout(c[14]));
    full_adder u15 (.a(A[15]), .b(B[15]), .cin(c[14]),.sum(Sum[15]), .cout(c[15]));
    full_adder u16 (.a(A[16]), .b(B[16]), .cin(c[15]),.sum(Sum[16]), .cout(c[16]));
    full_adder u17 (.a(A[17]), .b(B[17]), .cin(c[16]),.sum(Sum[17]), .cout(c[17]));
    full_adder u18 (.a(A[18]), .b(B[18]), .cin(c[17]),.sum(Sum[18]), .cout(c[18]));
    full_adder u19 (.a(A[19]), .b(B[19]), .cin(c[18]),.sum(Sum[19]), .cout(c[19]));
    full_adder u20 (.a(A[20]), .b(B[20]), .cin(c[19]),.sum(Sum[20]), .cout(c[20]));
    full_adder u21 (.a(A[21]), .b(B[21]), .cin(c[20]),.sum(Sum[21]), .cout(c[21]));
    full_adder u22 (.a(A[22]), .b(B[22]), .cin(c[21]),.sum(Sum[22]), .cout(c[22]));
    full_adder u23 (.a(A[23]), .b(B[23]), .cin(c[22]),.sum(Sum[23]), .cout(c[23]));
    full_adder u24 (.a(A[24]), .b(B[24]), .cin(c[23]),.sum(Sum[24]), .cout(c[24]));
    full_adder u25 (.a(A[25]), .b(B[25]), .cin(c[24]),.sum(Sum[25]), .cout(c[25]));
    full_adder u26 (.a(A[26]), .b(B[26]), .cin(c[25]),.sum(Sum[26]), .cout(c[26]));
    full_adder u27 (.a(A[27]), .b(B[27]), .cin(c[26]),.sum(Sum[27]), .cout(c[27]));
    full_adder u28 (.a(A[28]), .b(B[28]), .cin(c[27]),.sum(Sum[28]), .cout(c[28]));
    full_adder u29 (.a(A[29]), .b(B[29]), .cin(c[28]),.sum(Sum[29]), .cout(c[29]));
    full_adder u30 (.a(A[30]), .b(B[30]), .cin(c[29]),.sum(Sum[30]), .cout(c[30]));
    full_adder u31 (.a(A[31]), .b(B[31]), .cin(c[30]),.sum(Sum[31]), .cout(cout));

endmodule
