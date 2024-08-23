module flopenr_tb;

logic clk_tb;
logic reset_tb;
logic en_tb;
logic [31:0] d_tb;
logic [31:0] q_tb;

initial begin
	clk_tb = 1'b0;
	forever #10 clk_tb = ~clk_tb;
end

always @(clk_tb) begin
	d_tb = $urandom();
	#20;
end

initial begin
	$display("--- Starting flopr test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
	
	en_tb = 1'b1;
	#30;
	for (int i = 0; i < 10; i++) begin		
		assert (d_tb == q_tb) else $error("FF returns wrong value.");
		#30;
	end
	#30;
	reset_tb = 1'b1;
	#10;
	assert (q_tb == 32'b0) else $error("FF returns wrong value.");
	$finish;
end

flopenr #(.WIDTH(32)) tb_flopenr(
	.clk(clk_tb),
	.reset(reset_tb),
	.en(en_tb),
	.d(d_tb),
	.q(q_tb)
);

endmodule

