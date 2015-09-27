module d_flipflop(clk,d,out,reset);
input clk,d,reset;
output reg out;
reg outb;
always @(posedge clk or reset)
begin
if (reset==1)
begin
out<=1'b0;
outb<=1'b1;
end
else
begin
out<=d;
outb<=~d;
end
end
endmodule
