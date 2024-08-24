module riscvsc_top_tb;

logic clk_tb;
logic reset_tb;
logic [31:0] wd3_tb;

initial begin
	clk_tb = 1'b1;
	forever #10 clk_tb = ~clk_tb;
end

initial begin
	reset_tb = 0;
	//#10 reset_tb = 0;
	//#50 $finish;
end

always @(clk_tb) begin
	wd3_tb = $urandom();
	#20;
end

initial begin
	$display("--- Starting aludec test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
	
	#10000;
	
	$finish;
end

riscvsc_top tb_riscvsc_top(
	.clk(clk_tb),
	.reset(reset_tb),
	.WriteData(),
	.DataAdr(),
	.MemWrite()
);

endmodule
