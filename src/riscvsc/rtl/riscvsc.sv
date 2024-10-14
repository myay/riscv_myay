module riscvsc(
	input logic clk,
	input logic reset,
	output logic [31:0] PC,
	input logic [31:0] Instr,
	output logic MemWrite,
	output logic [31:0] ALUResult,
	output logic [31:0] WriteData,
	output logic [1:0] AccessMode,
        input logic [31:0] ReadData,
	output logic DataExtendMode
);

logic ALUSrc, RegWrite, Jump, Zero, PCSrc;
logic [1:0] RegWriteSrc;
logic [1:0] ResultSrc;
logic [2:0] ImmSrc;
logic [3:0] ALUControl;
logic ArithmLog;
logic CSRWrite;

assign ArithmLog = Instr[30];

controller c(
	.op(Instr[6:0]), 
	.funct3(Instr[14:12]), 
	.funct7b5(Instr[30]), 
	.Zero(Zero),
	.ResultSrc(ResultSrc), 
	.MemWrite(MemWrite),
	.CSRWrite(CSRWrite),
	.RegWriteSrc(RegWriteSrc), 
	.PCSrc(PCSrc),
	.ALUSrc(ALUSrc), 
	.RegWrite(RegWrite), 
	.Jump(Jump),
	.ImmSrc(ImmSrc), 
	.ALUControl(ALUControl),
	.AccessMode(AccessMode),
	.DataExtendMode(DataExtendMode)
);

datapath dp(
	.clk(clk), 
	.reset(reset), 
	.ResultSrc(ResultSrc), 
	.PCSrc(PCSrc),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite),
	.RegWriteSrc(RegWriteSrc),
	.CSRWrite(CSRWrite),
	.ImmSrc(ImmSrc),
	.ALUControl(ALUControl),
	.ArithmLog(ArithmLog),
	.Zero(Zero), 
	.PC(PC), 
	.Instr(Instr),
	.ALUResult(ALUResult), 
	.WriteData(WriteData), 
	.ReadData(ReadData)
);
endmodule
