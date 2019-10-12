/*######################################################################
//######################################################################
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>
//####################################################################*/
//=======================================================
//  MODULE Definition
//=======================================================
module MICROCODE_STORE #(parameter DATAWIDTH_MIR_DIRECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATAWIDTH_DECODEROP = 8, parameter DATAWIDTH_CONDITION=3, parameter DATAWIDTH_JUMPADDRESS=11, parameter DATAWIDTH_MICROINSTRUCTION=41)(
	
	//////////// OUTPUTS //////////
	MICROCODE_STORE_SelectA_OutBus,
	MICROCODE_STORE_SelectB_OutBus,
	MICROCODE_STORE_SelectC_OutBus,
	MICROCODE_STORE_DirA_Out,
	MICROCODE_STORE_DirB_Out,
	MICROCODE_STORE_DirC_Out,
	MICROCODE_STORE_RD_Out,
	MICROCODE_STORE_WRMain_Out,
	MICROCODE_STORE_ALUOperation_OutBus,
	MICROCODE_STORE_Condition_OutBus,
	MICROCODE_STORE_JumpAddress_OutBus,
	//////////// INPUTS //////////
	MICROCODE_STORE_CLOCK_50,
	MICROCODE_STORE_ResetInHigh_In,
	MICROCODE_STORE_CSAddress_InBus
	
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
output 	MICROCODE_STORE_SelectA_OutBus;
output 	MICROCODE_STORE_SelectB_OutBus;
output 	MICROCODE_STORE_SelectC_OutBus;
output 	[DATAWIDTH_MIR_DIRECTION-1:0]	MICROCODE_STORE_DirA_Out;
output 	[DATAWIDTH_MIR_DIRECTION-1:0]	MICROCODE_STORE_DirB_Out;
output 	[DATAWIDTH_MIR_DIRECTION-1:0]	MICROCODE_STORE_DirC_Out;
output 	MICROCODE_STORE_RD_Out;
output	MICROCODE_STORE_WRMain_Out;
output	[DATAWIDTH_ALU_SELECTION-1:0] MICROCODE_STORE_ALUOperation_OutBus;
output	[DATAWIDTH_CONDITION -1:0] MICROCODE_STORE_Condition_OutBus;
output	[DATAWIDTH_JUMPADDRESS -1:0] MICROCODE_STORE_JumpAddress_OutBus;

//////////// INPUTS //////////
input 	MICROCODE_STORE_CLOCK_50;
input 	MICROCODE_STORE_ResetInHigh_In;
input		[DATAWIDTH_JUMPADDRESS-1:0] MICROCODE_STORE_CSAddress_InBus;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [DATAWIDTH_MICROINSTRUCTION-1:0] OUT;

//=======================================================
//  Structural coding
//=======================================================

always@(*)
begin
	// Se asigna las instrucciones en formato ARC a la salida del módulo
	case (MICROCODE_STORE_CSAddress_InBus)	
		//READ 
		11'b00000000000: OUT = 41'b10000001000000100101010010100000000000000; //0 (R[IR] ← AND(R[PC],R[PC]); READ;)
		//DECODE
		11'b00000000001: OUT = 41'b00000000000000000000000010111100000000000; //1 (DECODE)
		//ADDCC 
		11'b11001000000: OUT = 41'b00000000000000000000000010110111001000010; //1600 (IF R[IR[13]] THEN GOTO 1692;)
		11'b11001000001: OUT = 41'b00000010000001000000100001111011111111111; //1601 (R[rd] ← ADDCC(R[rs1],[rs2]);)
		11'b11001000010: OUT = 41'b10010100000000100001000110000000000000000; //1602 (SEXT13(R[IR]);)
		11'b11001000011: OUT = 41'b00000011000010000000100001111011111111111; //1603 (R[rd] ← ADDCC(R[rs1],[temp0]);)
		//SUBCC 
		11'b11000110000: OUT = 41'b10010100000000100001000110010111000110010; //1584 (R[temp0] ← SEXT13(R[IR]); IF IR[13] THEN GOTO 1586;) Extract rs2 operand, is second source immediate?
		11'b11000110001: OUT = 41'b00000000000001100001000100000000000000000; //1585 (R[temp0] ← R[rs2];) Extract sign extended immediate operand
		11'b11000110010: OUT = 41'b10000100000000100001000011100000000000000; //1586 (R[temp0] ← NOR(R[temp0], R[0]);) Form one's complement of subtrahend
		11'b11000110011: OUT = 41'b10000100000000100001000110111011001000011; //1587 (R[temp0] ← INC(R[temp0]); GOTO 1603) Form two's complement of subtrahend, add terms for original substraction
		
		default:		     OUT = 41'b10000001000000100101010010100000000000000; //Vuelve a READ			 
	endcase
end 

endmodule
