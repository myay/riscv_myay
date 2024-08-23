module adder_tb;

logic [31:0] a_in, b_in;

logic [31:0] y_out, y_out_tb;

function int add (input int a, int b);
	return a + b;
endfunction

initial begin
	$display("--- Starting adder test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();

	a_in = 32'h0;	
	b_in = 32'h0;
	y_out_tb = 32'h0;

	for (int i = 0; i < 10; i++) begin
		#100;
		a_in = $urandom(); 
		b_in = $urandom();
		y_out_tb = add(a_in, b_in);
		#1;
		assert (y_out == y_out_tb) else $error("Addition is wrong.");
	end
	#100;
	$finish;
end

adder tb_adder(
	.a(a_in),
	.b(b_in),
	.y(y_out)
);

endmodule
