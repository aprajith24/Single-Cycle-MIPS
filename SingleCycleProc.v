module SingleCycleProc(CLK, Reset_L, startPC, dMemOut);
input CLK, Reset_L;
input[31:0] startPC;
output[31:0] dMemOut;

wire[31:0] ALUOut,BusA,BusB;
wire[3:0] ALUCtrl;
wire Zero;
wire[3:0] ALUOp;
wire RegDst, ALUSrc1, ALUSrc2, MemToReg, RmegWrite, MemRead, MemWrite, Branch, Jump, SignExtend;
wire[31:0] RegBusA, RegBusB, RegBusW;
wire[4:0] RegRW;
wire[31:0] InstMemDataOut;
reg[31:0] PCAdd;
wire BranchOut;
wire[31:0] BranchAdd, PCInc, NextAdd, JumpAdd, PCInp, ShiftOut, Imm, SEOut; 
 

ALU u_ALU(.BusW(ALUOut), .Zero(Zero), .BusA(BusA), .BusB(BusB), .ALUCtrl(ALUCtrl));
ALUControl u_ALUControl(.ALUCtrl(ALUCtrl), .ALUOp(ALUOp), .FuncCode(SEOut[5:0]));
SingleCycleControl u_SingleCycleControl(.RegDst(RegDst), .ALUSrc1(ALUSrc1), .ALUSrc2(ALUSrc2), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .Jump(Jump), .SignExtend(SignExtend), .ALUOp(ALUOp), .Opcode(InstMemDataOut[31:26]), .Func(InstMemDataOut[5:0]));
DataMemory #(.MEMSIZE(64),.ADDSIZE(6)) u_DataMemory(.ReadData(dMemOut),.Address(ALUOut[5:0]),.WriteData(RegBusB),.MemoryRead(MemRead),.MemoryWrite(MemWrite),.Clock(CLK));
RegisterFile u_RegisterFile(.BusA(RegBusA),.BusB(RegBusB),.BusW(RegBusW),.RA(InstMemDataOut[25:21]),.RB(InstMemDataOut[20:16]),.RW(RegRW),.RegWr(RegWrite),.Clk(CLK));
InstructionMemory u_InstructionMemory(.Data(InstMemDataOut), .Address(PCAdd));

assign NextAdd=BranchOut?BranchAdd:PCInc;
assign PCInp=Jump?JumpAdd:NextAdd;
assign RegRW=RegDst?InstMemDataOut[15:11]:InstMemDataOut[20:16];
assign BusA=ALUSrc1?Imm:RegBusA;
assign BusB=ALUSrc2?SEOut:RegBusB;
assign RegBusW=MemToReg?dMemOut:ALUOut;

assign SEOut=SignExtend?{{16{InstMemDataOut[15]}},InstMemDataOut[15:0]}:{{16{1'b0}},InstMemDataOut[15:0]};
assign Imm={27'b0,InstMemDataOut[10:6]};

assign PCInc=PCAdd+4;
assign ShiftOut=SEOut<<2;
assign BranchAdd=PCInc+ShiftOut;
assign BranchOut=Zero&Branch;
assign JumpAdd={PCInc[31:28],InstMemDataOut[25:0],{2{1'b0}}};

always @(negedge CLK or negedge Reset_L)
begin
if(Reset_L==0)
begin
PCAdd<=startPC;
end
else
begin
PCAdd<=PCInp;
end
end

endmodule


