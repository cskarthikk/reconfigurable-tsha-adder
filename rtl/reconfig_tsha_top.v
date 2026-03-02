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
module ra5_reconfig(
    input wire a,
    input wire b,
    input wire up_in,
    output wire up_out,
    output wire sum,
    input wire sel,
    input wire down_in,
    output wire down_out
);
    wire x=a&b;
    wire y=a^b;
    wire sum_exact=y^up_in;
    wire cout_exact=(x)|(up_in&(y));

    wire sum_ra5=up_in&((x)|~down_in);
    wire fout_ra5=a;
    wire rev_cout_ra5=up_in;

    assign sum= (sel)?(sum_ra5):sum_exact;
    assign up_out= (sel)? (fout_ra5):cout_exact;
    assign down_out= (sel)? (rev_cout_ra5):1'b0; 
endmodule
module ra3_reconfig(
    input wire a,
    input wire b,
    input wire up_in,
    output wire up_out,
    output wire sum,
    input wire sel,
    input wire down_in,
    output wire down_out
);
    wire x=a&b;
    wire y=a^b;
    wire sum_exact=y^up_in;
    wire cout_exact=(x)|(up_in&(y));

    wire sum_ra3=up_in&((x)|~down_in);
    wire fout_ra3=x|y;
    wire rev_cout_ra3= up_in|(down_in&~(x));

    assign sum= (sel)?(sum_ra3):sum_exact;
    assign up_out= (sel)? (fout_ra3):cout_exact;
    assign down_out= (sel)? (rev_cout_ra3):1'b0;
endmodule
module ra5_Nbit#(
    parameter width= 4
)(
    input wire [width-1:0] A,
    input wire [width-1:0] B,
    input wire sel,
    input wire cin_exact,
    input wire rev_carry_in,
    output wire [width-1:0] sum,
    output wire aux_out
);
    wire [width:0] up_chain;
    wire [width:0] down_chain;

    assign up_chain[0]= (sel)? 1'b1:cin_exact;
    assign down_chain[width]= (sel)? rev_carry_in:1'b0;
    
    genvar i;
    generate
        for(i=0;i<width;i=i+1) begin:loop
            ra5_reconfig u_cell(
                .a(A[i]),
                .b(B[i]),
                .up_in(up_chain[i]),
                .up_out(up_chain[i+1]),
                .sum(sum[i]),
                .sel(sel),
                .down_in(down_chain[i+1]),
                .down_out(down_chain[i])
            );
        end
    endgenerate
    assign aux_out= up_chain[width];
endmodule
module ra3_Nbit #(
    parameter width=4
)(
    input wire [width-1:0] A,
    input wire [width-1:0] B,
    input wire sel,
    //input wire cin_exact;
    input wire aux_out,
    output wire [width-1:0] sum,
    output wire aux_out2,
    output wire rev_carry
);
    wire [width:0] up_chain;
    wire [width:0] down_chain;

   assign up_chain[0]=aux_out;
   assign down_chain[width]=1'b0;
    genvar i;
    generate
        for(i=0;i<width;i=i+1) begin:loop
            ra3_reconfig u_cell(
                .a(A[i]),
                .b(B[i]),
                .up_in(up_chain[i]),
                .up_out(up_chain[i+1]),
                .sum(sum[i]),
                .sel(sel),
                .down_in(down_chain[i+1]),
                .down_out(down_chain[i])
            );
        end
    endgenerate
    assign aux_out2= up_chain[width];
    assign rev_carry= down_chain[0];
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
    wire [width:0] c;
    assign c[0]=aux_out2;
    genvar i;
    generate
        for(i=0;i<width;i=i+1) begin:loop
            full_adder u_fa(
                .a(A[i]),
                .b(B[i]),
                .cin(c[i]),
                .sum(sum[i]),
                .cout(c[i+1])
            );
        end
    assign cout= c[width];
    endgenerate
endmodule
module tsha_top #(
    parameter N=32,
    parameter h=24,
    parameter k=12
)(
    input wire [N-1:0] A,
    input wire [N-1:0] B,
    output wire [N-1:0] Sum,
    input wire sel,
    output wire final_cout
);
    wire lsp_to_mesp_up;
    wire mesp_to_lsp_down;
    wire mesp_to_msb_up;
    ra5_Nbit #(
        .width(k)
    )u_lsp(
        .A(A[k-1:0]),
        .B(B[k-1:0]),
        .sum(Sum[k-1:0]),
        .sel(sel),
        .cin_exact(1'b0),
        .rev_carry_in(mesp_to_lsp_down),
        .aux_out(lsp_to_mesp_up)
    );
    ra3_Nbit #(
        .width(h-k)
    )u_mesp(
        .A(A[h-1:k]),
        .B(B[h-1:k]),
        .sum(Sum[h-1:k]),
        .sel(sel),
        .aux_out(lsp_to_mesp_up),
        .aux_out2(mesp_to_msb_up),
        .rev_carry(mesp_to_lsp_down)
    );
    full_adder_Nbit #(
        .width(N-h)
    )u_fa(
        .A(A[N-1:h]),
        .B(B[N-1:h]),
        .sum(Sum[N-1:h]),
        .aux_out2(mesp_to_msb_up),
        .cout(final_cout)
    );
    endmodule

