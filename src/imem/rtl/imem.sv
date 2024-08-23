module imem(input logic [31:0] a,
            output logic [31:0] rd);

logic [31:0] RAM[63:0];

initial begin
	// TODO: Hardcode instructions in here, or fix path
	$readmemh("/home/mikail/digital_design/risc-v/src/imem/rtl/riscvtest.txt", RAM);
end

assign rd = RAM[a[7:2]]; // word aligned

endmodule
