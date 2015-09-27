module jk_flipflop(j,k,clk,reset,out);
input j,k,clk,reset;
output out;
wire int,clkb;
not n1(clkb,clk);
jk_ff ff1(j,k,clkb,reset,int);
jk_ff ff2(,,clk,reset,out);
endmodule
