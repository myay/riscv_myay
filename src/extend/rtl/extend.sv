module extend(input logic [31:7] instr,
              input logic [2:0] immsrc,
              output logic [31:0] immext);

always_comb
	case(immsrc)
		// I−type: Take 12 highest bits of instr and assign to lowest bits of instr, then fill the rest of the upper bits with the highest significant bit in instr (immediate field)
		3'b000: immext = {{20{instr[31]}}, instr[31:20]};
		// S−type (stores): Take bits of immediate field, put to lowest bits, extend all higher significant bits with instr[31]
		3'b001: immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
		// B−type (branches)
		3'b010: immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
		// J−type (jal)
		3'b011: immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
		// lui
		3'b100: immext = {{instr[31:12]}, 12'b0};
		default: immext = 32'bx; // undefined
	endcase

endmodule
