module mux_2_1(s,i0,i1,op);
input s,i0,i1;
output op;
wire sb;
wire o0,o1;
not n1(sb,s);
and a1(o0,sb,i0);
and a2(o1,s,i1);
or or1(op,o0,o1);
endmodule

