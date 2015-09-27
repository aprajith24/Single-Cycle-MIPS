module DataMemory(ReadData,Address,WriteData,MemoryRead,MemoryWrite,Clock);
parameter MEMSIZE=64;
parameter MEMWIDTH=32;
parameter ADDSIZE=6;
input [ADDSIZE-1:0] Address;
input [MEMWIDTH-1:0] WriteData;
input MemoryRead,MemoryWrite,Clock;
output reg [MEMWIDTH-1:0] ReadData;
reg[MEMWIDTH-1:0] datamem[MEMSIZE-1:0];
integer k=0;

initial
begin
for(k=0;k<MEMSIZE;k=k+1)
begin
datamem[k]=32'h0;
end
end

always @(posedge Clock)
begin
if(MemoryRead)
begin
ReadData<=datamem[Address];
end
end

always @(negedge Clock)
begin
if(MemoryWrite)
begin
datamem[Address]<=WriteData;
end
end

endmodule



