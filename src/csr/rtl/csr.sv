module csr(input logic clk,
	   input logic [3:0] CSRControl,
           input logic [31:0] instr,
           input logic [31:0] wd,
           output logic [31:0] rd);

// CSRControl[3] is write enable
// CSRControl[2:0] is funct3 from instruction

// 4096 CSRs
logic [31:0] CSR_rf[4095:0];
// address of csr to change
logic [11:0] csr_address;
logic [4:0] zimm;
// write enable
logic we;
logic [2:0] csr_ctrl_l3b;

assign csr_address = instr[31:20];
assign zimm = instr[19:15];
assign rd = CSR_rf[csr_address]; 
assign we = CSRControl[3];
assign csr_ctrl_l3b = CSRControl[2:0];

always_ff @(posedge clk) begin
	if (we) begin
		case(csr_ctrl_l3b)
			3'b001: // csrrw
				CSR_rf[csr_address] <= wd;
			3'b010: // csrrs
				CSR_rf[csr_address] <= wd;
			3'b011: // csrrc
				CSR_rf[csr_address] <= wd;
			3'b101: // csrrwi
				CSR_rf[csr_address] <= wd;
			3'b110: // csrrsi
				CSR_rf[csr_address] <= wd;
			3'b111: // csrrci
				CSR_rf[csr_address] <= wd;
			default: ;
		endcase
	end
end

endmodule
