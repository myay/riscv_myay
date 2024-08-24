module dmem(input logic clk, 
	    input logic we,
            input logic [31:0] a,
            input logic [31:0] wd,
            output logic [31:0] rd);

logic [31:0] RAM[63:0];

assign rd = RAM[a[7:2]]; // word aligned

always_ff @(posedge clk) begin
	if (we) begin
		RAM[a[7:2]] <= wd;
	end
end

endmodule
