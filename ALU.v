module ALU(BusW, Zero, BusA, BusB, ALUCtrl);
`define AND 4'b0000 
`define OR 4'b0001 
`define ADD 4'b0010 
`define SLL 4'b0011 
`define SRL 4'b0100 
`define SUB 4'b0110 
`define SLT 4'b0111 
`define ADDU 4'b1000 
`define SUBU 4'b1001 
`define XOR 4'b1010 
`define SLTU 4'b1011 
`define NOR 4'b1100 
`define SRA 4'b1101 
`define LUI 4'b1110 
input[31:0] BusA;
input[31:0] BusB;
input[3:0] ALUCtrl;
output Zero;
output reg [31:0] BusW;
reg overflow; 
assign Zero=(BusW==0)?1'b1:1'b0;

always @(ALUCtrl or BusA or BusB)
begin 
case(ALUCtrl)
`AND: BusW<=BusA&BusB;
`OR: BusW<=BusA|BusB;
`ADD: {overflow,BusW}<=BusA+BusB;
`SLL: BusW<=BusB<<BusA;
`SRL: BusW<=BusB>>BusA;
`SUB: {overflow,BusW}<=BusA-BusB;
`SLT: BusW<=($signed(BusA)<$signed(BusB))?1:0;
`ADDU: {overflow,BusW}<=BusA+BusB;
`SUBU: {overflow,BusW}<=BusA-BusB;
`XOR: BusW<=BusA^BusB;
`SLTU: BusW<=(BusA<BusB)?1:0;
`NOR: BusW<=~(BusA|BusB);
`SRA: BusW<=$signed(BusB)>>>BusA;
`LUI: BusW<={BusB[15:0],16'b0};
endcase
end

endmodule
