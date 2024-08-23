 module flopr #(parameter WIDTH = 8)
               (input logic clk,
                input logic reset,
                input logic [WIDTH-1:0] d,
                output logic [WIDTH-1:0] q);

	always_ff @(posedge clk, posedge reset)
		if (reset) begin
			q <= 32'b0;
		end else begin
			q <= d;
		end
 endmodule
