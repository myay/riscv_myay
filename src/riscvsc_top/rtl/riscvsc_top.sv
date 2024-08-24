module riscvsc_top(input logic clk, 
           input logic reset,
           output logic [31:0] WriteData, 
           output logic [31:0] DataAdr,
           output logic MemWrite);

logic [31:0] PC, Instr, ReadData;
// instantiate processor and memories
	riscvsc rvsc(
	.clk(clk), 
	.reset(reset), 
	.PC(PC), 
	.Instr(Instr), 
	.MemWrite(MemWrite),
	.ALUResult(DataAdr),  
	.WriteData(WriteData), 
	.ReadData(ReadData)
	);

	imem imem(
	.a(PC), 
	.rd(Instr)
	);
   
	dmem dmem(
	.clk(clk), 
	.we(MemWrite), 
	.a(DataAdr), 
	.wd(WriteData), 
	.rd(ReadData)
	);
 endmodule
