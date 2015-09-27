module jk_ff(j,k,reset,clk,out);
input j,k,clk,reset;
output out;
wire outbar,resetb,clkb,o1,o2;
wire o3,o4,o5,o6;
not no2(clkb,clk);
not no1(resetb,reset);
nand n1(o1,j,clk,outbar);
nand n2(o2,k,clk,out);
nand n3(o3,o1,o4);
nand n4(o4,o2,o3,resetb);
nand n5(o5,o3,clkb);
nand n6(o6,o4,clkb);
nand n7(out,o5,outbar);
nand n8(outbar,o6,out,resetb);
endmodule
