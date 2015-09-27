module RegisterFile(BusA,BusB,BusW,RA,RB,RW,RegWr,Clk);
`define ADDSIZE 5
`define REGWIDTH 32
`define REGSIZE 32
output [`REGWIDTH-1:0] BusA,BusB;
input [`ADDSIZE-1:0] RA,RB,RW;
input RegWr,Clk;
input [`REGWIDTH-1:0] BusW;
reg[`REGWIDTH-1:0] registers[`REGSIZE-1:0];
assign BusA= registers[RA];
assign BusB= registers[RB];
integer k=0;

initial
begin
for(k=0;k<`REGSIZE;k=k+1)
begin
registers[k]=32'h0;
end
end

always @*
begin
registers[0]=32'h0;
end

always @(negedge Clk)
begin
if (RegWr && RW!=0)
begin
registers[RW]<=BusW;
end
end

endmodule
