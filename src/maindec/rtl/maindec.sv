module maindec(
	input logic [6:0] op,
	input logic [2:0] funct3,
	output logic [1:0] ResultSrc,
	output logic MemWrite,
	output logic CSRWrite,
	output logic [1:0] RegWriteSrc,
	output logic Branch, ALUSrc,
	output logic RegWrite, Jump,
	output logic [2:0] ImmSrc,
	output logic [1:0] ALUOp,
	output logic [1:0] AccessMode,
	output logic DataExtendMode
);

logic [17:0] controls;
assign {RegWrite, ImmSrc, ALUSrc, MemWrite, CSRWrite, AccessMode, DataExtendMode, RegWriteSrc,
        ResultSrc, Branch, ALUOp, Jump} = controls;

always_comb
	case(op)
		// RegWrite_ImmSrc_ALUSrc_MemWrite_CSRWrite_AccessMode_DataExtendMode_RegWriteSrc_ResultSrc_Branch_ALUOp_Jump
		7'b0000011: // lw 
			begin
				case(funct3)
					3'b000: controls = 18'b1_000_1_0_0_00_1_00_01_0_00_0; // byte - lb
					3'b001: controls = 18'b1_000_1_0_0_01_1_00_01_0_00_0; // hex - lh
					3'b010: controls = 18'b1_000_1_0_0_10_1_00_01_0_00_0; // 32 bit - lw
					3'b100: controls = 18'b1_000_1_0_0_10_0_00_01_0_00_0; // byte unsigned - lbu
					3'b101: controls = 18'b1_000_1_0_0_10_0_00_01_0_00_0; // hex unsigned -lhu 
					default; 
				endcase	
			end
		7'b0100011: // sw 
			begin
				case(funct3)
					3'b000: controls = 18'b0_001_1_1_0_00_0_00_00_0_00_0; // byte - sb
					3'b001: controls = 18'b0_001_1_1_0_01_0_00_00_0_00_0; // hex - sh
					3'b010: controls = 18'b0_001_1_1_0_10_0_00_00_0_00_0; // 32 bit - sw
					default; 
				endcase	
			end
		7'b0110011: controls = 18'b1_xxx_0_0_0_00_0_00_00_0_10_0; // R–type
		7'b1100011: controls = 18'b0_010_0_0_0_00_0_00_00_1_01_0; // beq
		7'b0010011: controls = 18'b1_000_1_0_0_00_0_00_00_0_10_0; // I–type ALU
		7'b1101111: controls = 18'b1_011_0_0_0_00_0_00_10_0_00_1; // jal
		7'b0110111: controls = 18'b1_100_0_0_0_00_0_01_00_0_00_0; // lui
		7'b0010111: controls = 18'b1_100_0_0_0_00_0_10_00_0_00_0; // aupic
		7'b1110011: controls = 18'b1_100_0_0_1_00_0_11_00_0_00_0; // csr
		
	        default: controls = 18'bx_xxx_x_x_xx_x_xx_xx_x_xx_x; // ??? 
	endcase
endmodule
