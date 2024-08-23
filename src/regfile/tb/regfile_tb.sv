module regfile_tb;

logic clk_tb;
logic we3_tb;
logic [5:0] a1_tb, a2_tb, a3_tb;
logic [31:0] wd3_tb;
logic [31:0] rd1_tb, rd2_tb;

initial begin
	clk_tb = 1'b0;
	forever #10 clk_tb = ~clk_tb;
end

always @(clk_tb) begin
	wd3_tb = $urandom();
	#20;
end

initial begin
	$display("--- Starting regfile test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
	
	// TODO implement test with task that executes r/w  protocols	

	#50;
	
	$finish;
end

regfile tb_regfile(
	.clk(clk_tb),
	.we3(we3_tb),
	.a1(a1_tb),
	.a2(a2_tb),
	.a3(a3_tb),
	.wd3(wd3_tb),
	.rd1(rd1_tb),
	.rd2(rd2_tb)
);

endmodule

