module csr_tb;

logic clk_tb;
logic [31:0] instr_tb;
logic we_tb;
logic [31:0] wd_tb;
logic [31:0] rd_tb;

initial begin
	clk_tb = 1'b0;
	forever #10 clk_tb = ~clk_tb;
end

initial begin
	$display("--- Starting csr test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
	
	#20;
	// csrrw
	// instruction
	// instr_tb = 32'b000000000001 00001 001 00001 11100 11;
	instr_tb = 32'b00000000000100001001000011110011;
	wd_tb = 32'b11;
	we_tb = 1'b1;		
	#20;
	
	// csrrs
	// instr_tb = 32' 000000000001 00001 010 00001 11100 11;
	instr_tb = 32'b00000000000100001010000011110011;		
	wd_tb = 32'hFFFFFFFF;
	we_tb = 1'b1;		
	#20;

	// csrrc
	// instr_tb = 32' 000000000001 00001 011 00001 11100 11;
	instr_tb = 32'b00000000000100001011000011110011;		
	wd_tb = 32'hFFFFFFFF;
	we_tb = 1'b1;		
	#20;

	// csrrwi
	// instr_tb = 32' 000000000001 10000 101 00001 11100 11;
	instr_tb = 32'b00000000000110000101000011110011;		
	wd_tb = 32'b111;
	we_tb = 1'b1;		
	#20;
	
	// csrrsi
	// instr_tb = 32' 000000000001 11111 110 00001 11100 11;
	instr_tb = 32'b00000000000111111110000011110011;		
	wd_tb = 32'hFFFFFFFF;
	we_tb = 1'b1;		
	#20;
	
	// csrrci
	// instr_tb = 32' 000000000001 11111 111 00001 11100 11;
	instr_tb = 32'b00000000000111111111000011110011;		
	wd_tb = 32'hFFFFFFFF;
	we_tb = 1'b1;		
	#20;
	
	$finish;
end

csr tb_csr(
	.clk(clk_tb),
	.we(we_tb),
	.instr_31_12(instr_tb[31:12]),
	.wd(wd_tb),
	.rd(rd_tb)
);

endmodule
