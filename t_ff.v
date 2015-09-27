module t_ff(q, clk, reset); 
output q; 
input clk, reset; 
wire d; 
d_ff dff0(q, d, clk, reset); 
not n1(d, q); // not is a verilog-provided primitive 
endmodule 
