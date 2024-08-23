module alu(input logic [31:0] Src_A,
           input logic [31:0] Src_B,
           input logic [2:0] ALUControl,
           output logic [31:0] ALUResult,
           output logic Zero);

always_comb begin
	case (ALUControl)
		// add	
		3'b000: ALUResult = Src_A + Src_B;
		// subtract
		3'b001: ALUResult = Src_A - Src_B;
		// AND
		3'b010: ALUResult = Src_A & Src_B;
		// OR
		3'b011: ALUResult = Src_A | Src_B;
		// Shift right
		3'b100: ALUResult = Src_A >>> Src_B;
		// Set less than
		3'b101: ALUResult = Src_A < Src_B ? 32'b1 : 32'b0;
		// XOR
		3'b110: ALUResult = Src_A ^ Src_B;
		// Shift left
		3'b111: ALUResult = Src_A << Src_B;
	endcase
end

endmodule
