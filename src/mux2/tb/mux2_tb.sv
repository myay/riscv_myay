module mux2_tb;

logic [31:0] d0_tb, d1_tb;
logic s_tb;
logic [31:0] y_tb;

initial begin
	$display("--- Starting adder test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();

	d0_tb = 32'h0;	
	d1_tb = 32'h0;
	s_tb = 1'b0;

	for (int i = 0; i < 10; i++) begin
		#100;
		d0_tb = $urandom(); 
		d1_tb = $urandom();
		s_tb = d0_tb[0];
		#100;
	end
	#100;
	$finish;
end

mux2 #(.WIDTH(32)) tb_mux2(
	.d0(d0_tb),
	.d1(d1_tb),
	.s(s_tb),
	.y(y_tb)
);

endmodule
