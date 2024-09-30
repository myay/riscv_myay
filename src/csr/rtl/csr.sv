module csr(input logic clk,
	   input logic we,
           input logic [19:0] instr_31_12,
           input logic [31:0] wd,
           output logic [31:0] rd);

// CSRControl[3] is write enable
// CSRControl[2:0] is funct3 from instruction

logic [31:0] CSR_rf[4095:0];
logic [11:0] csr_address;
logic [31:0] zimm;
logic [2:0] func3;
logic [31:0] csr_val;

// helper values
assign csr_address = instr_31_12[19:8];
assign zimm = {27'b0, instr_31_12[7:3]};
assign func3 = instr_31_12[2:0];
assign csr_val = CSR_rf[csr_address];

// output
assign rd = csr_val; 

always_ff @(posedge clk) begin
	if (we) begin
		case(func3)
			3'b001: // csrrw
				CSR_rf[csr_address] <= wd;
			3'b010: // csrrs
				CSR_rf[csr_address] <= csr_val | wd;
			3'b011: // csrrc
				CSR_rf[csr_address] <= csr_val & (~wd);
			3'b101: // csrrwi
				CSR_rf[csr_address] <= zimm;
			3'b110: // csrrsi
				CSR_rf[csr_address] <= csr_val | zimm;
			3'b111: // csrrci
				CSR_rf[csr_address] <= csr_val & (~zimm);
			default: ;
		endcase
	end
end

endmodule
