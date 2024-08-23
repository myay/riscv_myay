module alu_tb;

logic [31:0] src_a_tb, src_b_tb;
logic [2:0] alucontrol_tb;
logic [31:0] aluresult_tb;
logic alucond;

initial begin
	$display("--- Starting alu test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();

	src_a_tb = 32'h0;	
	src_b_tb = 32'h0;
	alucontrol_tb = 3'b0;

	#100;

	for (int i = 0; i < 8; i++) begin
		alucond = (alucontrol_tb != 3'b100) && (alucontrol_tb != 3'b111); 		
		$display("alucond: %b", alucond);
		$display("alucontrol: %b", alucontrol_tb);
		if (alucond) begin
				src_a_tb = $urandom(); 
				src_b_tb = $urandom();
			end else begin
				$display("in else path, alucond: %b", alucond);
				src_a_tb = $urandom_range(0, 15); 
				src_b_tb = $urandom_range(0, 15);
			end
			#100;
			alucontrol_tb += 1;
	end
	#100;
	$finish;
end

alu tb_alu(
	.Src_A(src_a_tb),
	.Src_B(src_b_tb),
	.ALUControl(alucontrol_tb),
	.ALUResult(aluresult_tb),
	.Zero()
);

endmodule
