module ra3(
    input wire A,
    input wire B,
    input wire Cin,
    input wire Fin,
    output wire Fout,
    output wire sum,
    output wire Cout
);
    assign sum= Fin&((A&B)|(~Cin));
    assign Fout= A|B;
    assign Cout = Fin |(Cin&~(A&B));
endmodule

module ra3_32bit(
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire [31:0] Sum,
    output wire aux_out
);
    wire [32:0] C;
    wire [32:0] F;

    assign C[32] = 1'b0;
    assign F[32] = 1'b0;

    ra3 ut31 (.A(A[31]), .B(B[31]), .sum(Sum[31]), .Cin(C[32]), .Fin(F[32]), .Cout(C[31]), .Fout(F[31]));
    ra3 ut30 (.A(A[30]), .B(B[30]), .sum(Sum[30]), .Cin(C[31]), .Fin(F[31]), .Cout(C[30]), .Fout(F[30]));
    ra3 ut29 (.A(A[29]), .B(B[29]), .sum(Sum[29]), .Cin(C[30]), .Fin(F[30]), .Cout(C[29]), .Fout(F[29]));
    ra3 ut28 (.A(A[28]), .B(B[28]), .sum(Sum[28]), .Cin(C[29]), .Fin(F[29]), .Cout(C[28]), .Fout(F[28]));
    ra3 ut27 (.A(A[27]), .B(B[27]), .sum(Sum[27]), .Cin(C[28]), .Fin(F[28]), .Cout(C[27]), .Fout(F[27]));
    ra3 ut26 (.A(A[26]), .B(B[26]), .sum(Sum[26]), .Cin(C[27]), .Fin(F[27]), .Cout(C[26]), .Fout(F[26]));
    ra3 ut25 (.A(A[25]), .B(B[25]), .sum(Sum[25]), .Cin(C[26]), .Fin(F[26]), .Cout(C[25]), .Fout(F[25]));
    ra3 ut24 (.A(A[24]), .B(B[24]), .sum(Sum[24]), .Cin(C[25]), .Fin(F[25]), .Cout(C[24]), .Fout(F[24]));
    ra3 ut23 (.A(A[23]), .B(B[23]), .sum(Sum[23]), .Cin(C[24]), .Fin(F[24]), .Cout(C[23]), .Fout(F[23]));
    ra3 ut22 (.A(A[22]), .B(B[22]), .sum(Sum[22]), .Cin(C[23]), .Fin(F[23]), .Cout(C[22]), .Fout(F[22]));
    ra3 ut21 (.A(A[21]), .B(B[21]), .sum(Sum[21]), .Cin(C[22]), .Fin(F[22]), .Cout(C[21]), .Fout(F[21]));
    ra3 ut20 (.A(A[20]), .B(B[20]), .sum(Sum[20]), .Cin(C[21]), .Fin(F[21]), .Cout(C[20]), .Fout(F[20]));
    ra3 ut19 (.A(A[19]), .B(B[19]), .sum(Sum[19]), .Cin(C[20]), .Fin(F[20]), .Cout(C[19]), .Fout(F[19]));
    ra3 ut18 (.A(A[18]), .B(B[18]), .sum(Sum[18]), .Cin(C[19]), .Fin(F[19]), .Cout(C[18]), .Fout(F[18]));
    ra3 ut17 (.A(A[17]), .B(B[17]), .sum(Sum[17]), .Cin(C[18]), .Fin(F[18]), .Cout(C[17]), .Fout(F[17]));
    ra3 ut16 (.A(A[16]), .B(B[16]), .sum(Sum[16]), .Cin(C[17]), .Fin(F[17]), .Cout(C[16]), .Fout(F[16]));
    ra3 ut15 (.A(A[15]), .B(B[15]), .sum(Sum[15]), .Cin(C[16]), .Fin(F[16]), .Cout(C[15]), .Fout(F[15]));
    ra3 ut14 (.A(A[14]), .B(B[14]), .sum(Sum[14]), .Cin(C[15]), .Fin(F[15]), .Cout(C[14]), .Fout(F[14]));
    ra3 ut13 (.A(A[13]), .B(B[13]), .sum(Sum[13]), .Cin(C[14]), .Fin(F[14]), .Cout(C[13]), .Fout(F[13]));
    ra3 ut12 (.A(A[12]), .B(B[12]), .sum(Sum[12]), .Cin(C[13]), .Fin(F[13]), .Cout(C[12]), .Fout(F[12]));
    ra3 ut11 (.A(A[11]), .B(B[11]), .sum(Sum[11]), .Cin(C[12]), .Fin(F[12]), .Cout(C[11]), .Fout(F[11]));
    ra3 ut10 (.A(A[10]), .B(B[10]), .sum(Sum[10]), .Cin(C[11]), .Fin(F[11]), .Cout(C[10]), .Fout(F[10]));
    ra3 ut9  (.A(A[9]),  .B(B[9]),  .sum(Sum[9]),  .Cin(C[10]), .Fin(F[10]), .Cout(C[9]),  .Fout(F[9]));
    ra3 ut8  (.A(A[8]),  .B(B[8]),  .sum(Sum[8]),  .Cin(C[9]),  .Fin(F[9]),  .Cout(C[8]),  .Fout(F[8]));
    ra3 ut7  (.A(A[7]),  .B(B[7]),  .sum(Sum[7]),  .Cin(C[8]),  .Fin(F[8]),  .Cout(C[7]),  .Fout(F[7]));
    ra3 ut6  (.A(A[6]),  .B(B[6]),  .sum(Sum[6]),  .Cin(C[7]),  .Fin(F[7]),  .Cout(C[6]),  .Fout(F[6]));
    ra3 ut5  (.A(A[5]),  .B(B[5]),  .sum(Sum[5]),  .Cin(C[6]),  .Fin(F[6]),  .Cout(C[5]),  .Fout(F[5]));
    ra3 ut4  (.A(A[4]),  .B(B[4]),  .sum(Sum[4]),  .Cin(C[5]),  .Fin(F[5]),  .Cout(C[4]),  .Fout(F[4]));
    ra3 ut3  (.A(A[3]),  .B(B[3]),  .sum(Sum[3]),  .Cin(C[4]),  .Fin(F[4]),  .Cout(C[3]),  .Fout(F[3]));
    ra3 ut2  (.A(A[2]),  .B(B[2]),  .sum(Sum[2]),  .Cin(C[3]),  .Fin(F[3]),  .Cout(C[2]),  .Fout(F[2]));
    ra3 ut1  (.A(A[1]),  .B(B[1]),  .sum(Sum[1]),  .Cin(C[2]),  .Fin(F[2]),  .Cout(C[1]),  .Fout(F[1]));
    ra3 ut0  (.A(A[0]),  .B(B[0]),  .sum(Sum[0]),  .Cin(C[1]),  .Fin(F[1]),  .Cout(C[0]),  .Fout(F[0]));

    assign aux_out = C[31];
endmodule
