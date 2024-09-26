module csr_tb;

logic clk_tb;
logic [31:0] instr_tb;
logic [31:0] wd_tb;
logic [31:0] rd_tb;
logic [3:0] CSRControl_tb;

initial begin
	clk_tb = 1'b0;
	forever #10 clk_tb = ~clk_tb;
end

initial begin
	$display("--- Starting csr test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
	
	$finish;
end

csr tb_csr(
	.clk(clk_tb),
	.CSRControl(CSRControl_tb),
	.instr(instr_tb),
	.wd(wd_tb),
	.rd(rd_tb)
);

endmodule
