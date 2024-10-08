module datapath(input logic clk, 
                input logic reset,
                input logic [1:0] ResultSrc,
                input logic PCSrc, ALUSrc,
                input logic RegWrite,
		input logic [1:0] RegWriteSrc,
		input logic CSRWrite,
                input logic [2:0] ImmSrc,
                input logic [3:0] ALUControl,
		input logic ArithmLog,
                output logic Zero,
                output logic [31:0] PC,
                input  logic [31:0] Instr,
                output logic [31:0] ALUResult, WriteData,
                input  logic [31:0] ReadData);

logic [31:0] PCNext, PCPlus4, PCTarget;
logic [31:0] ImmExt;
logic [31:0] SrcA, SrcB;
logic [31:0] Result;
logic [31:0] WriteRegData;
logic [31:0] PCPlusImm;
logic [31:0] CSRSrc;

// next PC logic
flopr #(32) pcreg(
	.clk(clk), 
	.reset(reset), 
	.d(PCNext), 
	.q(PC)
);
adder pcadd4(
	.a(PC), 
	.b(32'd4), 
	.y(PCPlus4)
);
adder pcaddbranch(
	.a(PC), 
	.b(ImmExt), 
	.y(PCTarget)
);
mux2 #(32) pcmux(
	.d0(PCPlus4), 
	.d1(PCTarget), 
	.s(PCSrc), 
	.y(PCNext)
);

// register file logic
regfile rf(
	.clk(clk), 
	.we3(RegWrite), 
	.a1({1'b0, Instr[19:15]}),
	.a2({1'b0, Instr[24:20]}),
	.a3({1'b0, Instr[11:7]}), 
	.wd3(WriteRegData), 
	.rd1(SrcA), 
	.rd2(WriteData)
);
extend ext(
	.instr(Instr[31:7]), 
	.immsrc(ImmSrc), 
	.immext(ImmExt)
);
//mux2 #(32) regwritesrcmux(Result, ImmExt, RegWriteSrc, WriteRegData); // for lui

// for lui and aupic
mux3 #(32) regwritesrcmux(
	.d0(Result),
	.d1(ImmExt),
	.d2(PCPlusImm),
	.s(RegWriteSrc),
	.y(WriteRegData)
);

// for auipic
adder pcplusimm(
	.a(PC),
	.b(ImmExt),
	.y(PCPlusImm)
); 

// ALU logic
mux2 #(32) srcbmux(
	.d0(WriteData), 
	.d1(ImmExt), 
	.s(ALUSrc), 
	.y(SrcB)
);
alu alu(
	.Src_A(SrcA), 
	.Src_B(SrcB), 
	.ALUControl(ALUControl),
	.ArithmLog(ArithmLog), 
	.ALUResult(ALUResult), 
	.Zero(Zero)
);
mux4 #(32) resultmux(
	.d0(ALUResult), 
	.d1(ReadData), 
	.d2(PCPlus4),
	.d3(CSRSrc), 
	.s(ResultSrc), 
	.y(Result)
);

// csr
csr csr_reg(
	.clk(clk),
	.we(CSRWrite),
	.instr_31_12(Instr[31:12]),
	.wd(SrcA),
	.rd(CSRSrc)	
);

endmodule
