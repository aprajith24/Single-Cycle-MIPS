module stimulus_mux;
reg s0,s1,i0,i1,i2,i3;
wire out;
integer i=0;
mux_4_1 mux(s0,s1,i0,i1,i2,i3,out);
initial
begin 
s0=1'b0;
s1=1'b0;
i0=1'b0;
i1=1'b0;
i2=1'b0;
i3=1'b0;
for (i=0;i<64;i=i+1)
begin
#5
{s0,s1,i0,i1,i2,i3}=i;
end
#20 $stop;
end
endmodule