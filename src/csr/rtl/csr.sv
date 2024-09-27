module csr(input logic clk,
	   input logic [3:0] CSRControl,
           input logic [31:0] instr,
           input logic [31:0] wd,
           output logic [31:0] rd);

// CSRControl[3] is write enable
// CSRControl[2:0] is funct3 from instruction

logic [31:0] CSR_rf[4095:0];
logic [11:0] csr_address;
logic [31:0] zimm;
logic we;
logic [2:0] csr_ctrl_l3b;
logic [4:0] instr_rd;
logic [31:0] csr_val;

// helper values
assign csr_address = instr[31:20];
assign we = CSRControl[3];
assign csr_ctrl_l3b = CSRControl[2:0];
assign zimm = {27'b0, instr[19:15]};
assign csr_val = CSR_rf[csr_address];

// TODO?
// if instr_rd == 5'b0 then do not read and don't cause any side effects from read
assign instr_rd = instr[11:7];

// output
assign rd = csr_val; 

always_ff @(posedge clk) begin
	if (we) begin
		case(csr_ctrl_l3b)
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
