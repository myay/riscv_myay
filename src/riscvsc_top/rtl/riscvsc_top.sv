module riscvsc_top(input logic clk, 
           input logic reset,
           output logic [31:0] WriteData, 
           output logic [31:0] DataAdr,
           output logic MemWrite);

logic [31:0] PC, Instr, ReadData, ReadData_ext;
logic [1:0] AccessMode;
logic DataExtendMode;
// instantiate processor and memories
riscvsc rvsc(
	.clk(clk), 
	.reset(reset), 
	.PC(PC), 
	.Instr(Instr), 
	.MemWrite(MemWrite),
	.ALUResult(DataAdr),  
	.WriteData(WriteData),
	.AccessMode(AccessMode),
	.ReadData(ReadData_ext),
	.DataExtendMode(DataExtendMode)
);

imem i_imem(
	.a(PC), 
	.rd(Instr)
);

dmem_vam i_dmem_vam(
	.clk(clk),
	.accessmode(AccessMode),
	.we(MemWrite), 
	.a(DataAdr), 
	.wd(WriteData), 
	.rd(ReadData)
);

extend_dmem i_extend_dmem(
	.extendmode(DataExtendMode),
	.accessmode(AccessMode),
	.in_data(ReadData),
	.out_data(ReadData_ext)
);
	
endmodule
