module extend_dmem
(
	input logic extendmode,
	input logic [1:0] accessmode,
	input logic [31:0] in_data,
	output logic [31:0] out_data
);

// extendmode 1 -> signed
// extendmode 0 -> unsigned (do nothing, just pass data through)
// accessmode 00 -> 8 bit
// accessmode 01 -> 16 bit
// accessmode 10 -> 32 bit (no extension, just pass data through)

always_comb
	if (extendmode) begin 
		case(accessmode)
			2'b00: out_data = {{24{in_data[7]}}, in_data[7:0]};
			2'b01: out_data = {{16{in_data[15]}}, in_data[15:0]};
			2'b10: out_data = in_data;
			default: ;
		endcase
	end else begin
		out_data = in_data;
	end
endmodule
