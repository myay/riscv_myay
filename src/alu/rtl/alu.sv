module alu(input logic [31:0] Src_A,
           input logic [31:0] Src_B,
           input logic [3:0] ALUControl,
           output logic [31:0] ALUResult,
           output logic Zero);

always_comb begin
	case (ALUControl)
		// add	
		4'b0000: ALUResult = Src_A + Src_B;
		// subtract
		4'b0001: ALUResult = Src_A - Src_B;
		// AND
		4'b0010: ALUResult = Src_A & Src_B;
		// OR
		4'b0011: ALUResult = Src_A | Src_B;
		// Shift right
		4'b0100: ALUResult = Src_A >>> Src_B;
		// Set less than (signed)
		4'b0101: if ((Src_A[31] == 1'b0) && (Src_B[31] == 1'b0)) begin 
				// both values are positive
				ALUResult = Src_A < Src_B ? 32'b1 : 32'b0;
			end else if ((Src_A[31] == 1'b1) && (Src_B[31] == 1'b1)) begin
				// both values negative	
				ALUResult = Src_A > Src_B ? 32'b1 : 32'b0;
			end else if ((Src_A[31] == 1'b1) && (Src_B[31] == 1'b0)) begin
				// Src_A is negative, Src_B is positive
				ALUResult = 32'b1;
			end else begin
				// Src_A is positive, Src_B is negative
				ALUResult = 32'b0;
			end
		// XOR
		4'b0110: ALUResult = Src_A ^ Src_B;
		// Shift left
		4'b0111: ALUResult = Src_A << Src_B;
		// Set less than unsigned
		4'b1000: ALUResult = Src_A < Src_B ? 32'b1 : 32'b0;
		// default
		default: ALUResult = 32'b0;
	endcase
	
	if (ALUResult == 32'b0) begin
		Zero = 1'b1;
	end else begin
		Zero = 1'b0;
	end
end
endmodule
