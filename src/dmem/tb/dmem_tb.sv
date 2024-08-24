module dmem_tb;

logic clk_tb;
logic we_tb;
logic [31:0] a_tb;
logic [31:0] wd_tb;
logic [31:0] rd_tb;

logic [31:0] rand_wd;
logic [31:0] lin_a;

initial begin
	clk_tb = 1'b0;
	forever #10 clk_tb = ~clk_tb;
end

task write_dmem(input logic[31:0] wd_val, input logic[31:0] a_val);
	wd_tb = wd_val;
	a_tb = a_val;
	//@(posedge clk_tb);
	#1;
	we_tb = 1'b1;
	//@(posedge clk_tb);
	#20;
	we_tb = 1'b0;
endtask

initial begin
	$display("--- Starting dmem test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
	
	we_tb = 1'b0;

	#20;
	// write to all memory locations
	for (int i = 0; i < 84; i+=4) begin			
		lin_a = 32'(i);
		rand_wd = $urandom();
		write_dmem(rand_wd, lin_a);
		#100;
	end
	$finish;
end

dmem tb_dmem(
	.clk(clk_tb),
	.we(we_tb),
	.a(a_tb),
	.wd(wd_tb),
	.rd(rd_tb)
);

endmodule
