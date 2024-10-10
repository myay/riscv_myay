module dmem_vam_tb;

logic clk_tb;
logic we_tb;
logic [31:0] a_tb;
logic [31:0] wd_tb;
logic [31:0] rd_tb;
logic [1:0] accessmode_tb;

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
	
	for (int j = 0; j < 2; j+=1) begin
		// 8 bit access mode
		accessmode_tb = 2'b0;
		#20;
		// write to all memory locations
		for (int i = 0; i < 21*4; i+=1) begin			
			lin_a = 32'(i);
			rand_wd = $urandom();
			write_dmem(rand_wd, lin_a);
			#100;
		end

		// 16 bit access mode
		accessmode_tb = 2'b01;
		#100
		// write to all memory locations
		for (int i = 0; i < 21*2; i+=2) begin			
			lin_a = 32'(i);
			rand_wd = $urandom();
			write_dmem(rand_wd, lin_a);
			#100;
		end
		
		// 32 bit access mode
		accessmode_tb = 2'b10;
		#100
		// write to all memory locations
		for (int i = 0; i < 21; i+=4) begin			
			lin_a = 32'(i);
			rand_wd = $urandom();
			write_dmem(rand_wd, lin_a);
			#100;
		end
	end
	$finish;
end

dmem_vam tb_dmem(
	.clk(clk_tb),
	.accessmode(accessmode_tb),
	.we(we_tb),
	.a(a_tb),
	.wd(wd_tb),
	.rd(rd_tb)
);

endmodule
