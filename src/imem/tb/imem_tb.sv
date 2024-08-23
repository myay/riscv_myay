module imem_tb;

logic clk_tb;
logic reset_tb;
logic [31:0] a_tb;
logic [31:0] rd_tb;


initial begin
	$display("--- Starting imem test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
	
	#20;
	for (int i = 0; i < 84; i+=4) begin			
		a_tb = i;
		#100;
	end
	$finish;
end

imem tb_imem(
	.a(a_tb),
	.rd(rd_tb)
);

endmodule
