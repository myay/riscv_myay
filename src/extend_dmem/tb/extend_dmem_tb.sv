module extend_dmem_tb;

logic extendmode_tb;
logic [1:0] accessmode_tb;
logic [31:0] data_i_tb;
logic [31:0] data_o_tb;

initial begin
	$display("--- Starting extend test. ---");
	$dumpfile("dump.vcd");
	$dumpvars();
		
	#10;

	// 8 bit, signed
	extendmode_tb = 1'b1;
	accessmode_tb = 2'b00;	
	data_i_tb = 32'hFF;
	#10;
	
	// 16 bit, signed
	extendmode_tb = 1'b1;
	accessmode_tb = 2'b01;	
	data_i_tb = 32'hFFFF;
	#10;
	
	// 16 bit, signed
	extendmode_tb = 1'b1;
	accessmode_tb = 2'b10;	
	data_i_tb = 32'hFFFF;
	#10;

	// 16 bit, unsigned
	extendmode_tb = 1'b0;
	accessmode_tb = 2'b00;	
	data_i_tb = 32'hF;
	#10;
	$finish;
end

extend_dmem tb_extend_dmem(
	.extendmode(extendmode_tb),
	.accessmode(accessmode_tb),
	.in_data(data_i_tb),
	.out_data(data_o_tb)
);

endmodule
