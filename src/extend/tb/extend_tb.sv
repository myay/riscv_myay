module extend_tb;

logic [31:0] instr_tb;
logic [1:0] immsrc_tb;
logic [31:0] immext;

initial begin
	$display("--- Starting extend test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
	
	// immedate extension	
	instr_tb = 32'hFDCA2E03;
	immsrc_tb = 2'b0;
	#10;
	
	// store extension
	instr_tb = 32'hFE79AD23;
	immsrc_tb = 2'b01;
	#10;
	
	// branch extension (beq)
	instr_tb = 32'h01E40863;
	immsrc_tb = 2'b10;
	#10;

	// jump extension (jal) 
	instr_tb = 32'h7F8A60EF;
	immsrc_tb = 2'b11;
	#10;
	$finish;
end

extend tb_extend(
	.instr(instr_tb[31:7]),
	.immsrc(immsrc_tb),
	.immext(immext)
);

endmodule
