module dmem_vam(
	input logic clk,
	input logic [1:0] accessmode,
	input logic we,
	input logic [31:0] a,
	input logic [31:0] wd,
	output logic [31:0] rd
);

logic [31:0] RAM[63:0];

// access modes
// 00: 8 bit
// 01: 16 bit
// 10: 32 bit

// if access mode is 00
// last two bits of address 
// to shift amount
// to be shifted is 32'hff
// 00: no shift
// 01: shift by 8 bit
// 10: shift by 16 bit
// 11: shift by 24 bit

// if access mode is 01
// last bit of address
// to shift amount
// to be shifted is 32'hffff
// 0: no shift
// 1: shift by 16 bit

logic [31:0] bitmask;
logic [4:0] shift_amount;

always_comb
	case(accessmode)
		2'b00: begin
			shift_amount = (8*a[1:0]);
			bitmask = (32'hff) << shift_amount;
		       end
		2'b01: begin
			shift_amount = (16*a[1]);
			bitmask = (32'hffff) << shift_amount;
		       end
		2'b10: begin
			shift_amount = 5'b0;
			bitmask = 32'hffffffff;
		       end
		default;
	endcase

assign rd = (RAM[a[7:2]] & bitmask) >> shift_amount;

always_ff @(posedge clk) begin
	if (we) begin
		case(accessmode)
			2'b00: RAM[a[7:2]][(8*a[1:0])+:8] <= (wd[(8*a[1:0])+:8]);
			2'b01: RAM[a[7:2]][(16*a[1])+:16] <= (wd[(16*a[1])+:16]);
			2'b10: RAM[a[7:2]] <= wd;
			default: ;
		endcase
	end
end

endmodule
