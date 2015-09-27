module mux_4_1(s0,s1,i0,i1,i2,i3,out);
input s0,s1,i0,i1,i2,i3;
output out;
wire o1,o2;
mux_2_1 mux1(.s(s0),.i0(i0),.i1(i1),.op(o1));
mux_2_1 mux2(.s(s0),.i0(i2),.i1(i3),.op(o2));
mux_2_1 mux3(.s(s1),.i0(o1),.i1(o2),.op(out));
endmodule
