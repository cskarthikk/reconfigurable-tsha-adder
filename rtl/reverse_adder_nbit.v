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
module ra5(
    input wire A,
    input wire B,
    input wire Cin,
    input wire Fin,
    output wire Fout,
    output wire sum,
    output wire Cout
);
    assign sum  = Fin & ((A & B) | ~Cin);
    assign Fout = A;
    assign Cout = Fin;
endmodule
module ra5_Nbit #(
    parameter WIDTH = 4 
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire rev_carry_in,   
    output wire [WIDTH-1:0] Sum,
    output wire aux_out       
);
    wire [WIDTH:0] C;
    wire [WIDTH:0] F;

    assign C[WIDTH] = rev_carry_in;
    
  
    assign F[0] = 1'b1;

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : ra5_loop
            ra5 u_cell (
                .A    (A[i]), 
                .B    (B[i]), 
                .sum  (Sum[i]),
                .Cin  (C[i+1]), 
                .Cout (C[i]),
                .Fin  (F[i]), 
                .Fout (F[i+1])
            );
        end
    endgenerate

    
    assign aux_out = F[WIDTH];

endmodule
module ra3_Nbit #(
    parameter width= 4
)
(
    input wire [width-1:0] A,
    input wire [width-1:0] B,
    input wire aux_out,
    output wire [width-1:0] sum,
    output wire aux_out2,
    output wire rev_carry
);
    wire [width:0] C;
    wire [width:0] F;
    assign C[width]= 1'b0;
    assign F[0]= aux_out;
    genvar i;
    generate
        for(i=0;i<width;i=i+1) begin:ra3_loop
            ra3 u_cell(
                .A(A[i]),
                .B(B[i]),
                .sum(sum[i]),
                .Cin(C[i+1]),
                .Fin(F[i]),
                .Cout(C[i]),
                .Fout(F[i+1])
            );
        end
    endgenerate
    assign aux_out2= F[width];
    assign rev_carry= C[0];
endmodule
module full_adder_Nbit #(
    parameter width=4
)(
    input wire [width-1:0] A,
    input wire [width-1:0] B,
    input wire aux_out2,
    output wire [width-1:0] sum,
    output wire cout
);
    wire [width:0]c;
    assign c[0]=aux_out2;
    genvar i;
    generate
        for(i=0;i<width;i=i+1) begin:full_adder_loop
            full_adder u_fa(
            .a(A[i]),
            .b(B[i]),
            .sum(sum[i]),
            .cin(c[i]),
            .cout(c[i+1])
            );
        end
    assign cout= c[width];
    endgenerate
endmodule

module tsha_top #(
    parameter N =32,
    parameter h=24,
    parameter k=12
)(
    input wire [N-1:0]A,
    input wire [N-1:0]B,
    output wire [N-1:0]Sum,
    output wire final_cout
);
    wire lsp_fout;
    wire mesp_rev_carry;
    wire mesp_fout;
    ra5_Nbit #(
        .WIDTH(k)
    )u_lsp(
        .A(A[k-1:0]),
        .B(B[k-1:0]),
        .rev_carry_in(mesp_rev_carry),
        .Sum(Sum[k-1:0]),
        .aux_out(lsp_fout)
    );
    ra3_Nbit#(
        .width(h-k)
    )u_mesp(
        .A(A[h-1:k]),
        .B(B[h-1:k]),
        .sum(Sum[h-1:k]),
        .aux_out(lsp_fout),
        .aux_out2(mesp_fout),
        .rev_carry(mesp_rev_carry)
    );
    full_adder_Nbit#(
        .width(N-h)
    )u_fa(
        .A(A[N-1:h]),
        .B(B[N-1:h]),
        .sum(Sum[N-1:h]),
        .aux_out2(mesp_fout),
        .cout(final_cout)
    );
endmodule