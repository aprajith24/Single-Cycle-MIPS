module jk_beh(j,k,clk,reset,out);
input j,k,clk,reset;
output reg out;
reg outbar;
always @(negedge clk or reset)
begin
if (reset == 1'b1)
begin
out<=1'b0;
outbar<=1'b1;
end
else
begin
if(j==1'b0 && k==1'b1)
begin
out<=1'b0;
outbar<=1'b1;
end
if(j==1'b1 && k==1'b0)
begin
out<=1'b1;
outbar<=1'b0;
end
if(j==1'b1 && k==1'b1)
begin
out<=outbar;
outbar<=out;
end
end
end
endmodule
