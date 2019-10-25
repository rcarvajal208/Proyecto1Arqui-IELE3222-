/*######################################################################
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
reg [DATAWIDTH_MICROINSTRUCTION-1:0] OUT_Signal;
reg [DATAWIDTH_MICROINSTRUCTION-1:0] OUT_Register;

//=======================================================
//  Structural coding
//=======================================================

always@(*)
begin
	// Se asigna las instrucciones en formato ARC a la salida del módulo
	case (MICROCODE_STORE_CSAddress_InBus)	
		//READ 									 AAAAAAMBBBBBBMCCCCCCMRWALUUCONJUMPADDRESS
		11'b00000000000: OUT_Signal = 41'b00001000000100000011010010100000000000000; //0 (R[IR] ← AND(R[PC],R[PC]); READ;)
		//DECODE																							  //temp0 = R[9]
		11'b00000000001: OUT_Signal = 41'b00000000000000000000000010111100000000000; //1 (DECODE)
		//BNE(Salta si no es igual a cero)AAAAAAMBBBBBBMCCCCCCMRWALUUCONJUMPADDRESS
		11'b10001000000: OUT_Signal = 41'b00001100000001001001000101000000000000000; //1088  R[temp0] ← LSHIFT10(R[ir])
		11'b10001000001: OUT_Signal = 41'b00100100000001001001000111100000000000000; //1089  R[temp0] ← RSHIFT5(R[temp0])
		11'b10001000010: OUT_Signal = 41'b00100100000001001001000111100000000000000; //1090  R[temp0] ← RSHIFT5(R[temp0])
		11'b10001000011: OUT_Signal = 41'b00001100000001000011000111100000000000000; //1091  R[ir] ← RSHIFT5(R[ir])
		11'b10001000100: OUT_Signal = 41'b00001100000001000011000111100000000000000; //1092  R[ir] ← RSHIFT5(R[ir])
		11'b10001000101: OUT_Signal = 41'b00001100000001000011000111100000000000000; //1093  R[ir] ← RSHIFT5(R[ir])
//		11'b10001000110: OUT_Signal = 41'b00001100000110000011000100000000000000000; //1094  R[ir] ← ADD(R[ir],R[ir])
//		11'b10001000111: OUT_Signal = 41'b00000000000000000000000000010110001001000; //1095	 IF R[IR[13]] THEN GOTO 1096
		11'b10001000110: OUT_Signal = 41'b00000000000000000000000000001011001000100; //1094  IF Z THEN GOTO 1604
		11'b10001000111: OUT_Signal = 41'b00001000010100000010000100011000000000000; //1095  R[pc] ← ADD(R[pc],R[10]) 
		//ADDCC (Suma con acarreo)        AAAAAAMBBBBBBMCCCCCCMRWALUUCONJUMPADDRESS
		11'b11001000000: OUT_Signal = 41'b00000000000000000000000010110111001000010; //1600 (IF R[IR[13]] THEN GOTO 1602;)
		11'b11001000001: OUT_Signal = 41'b00000010000001000000100001111011001000100; //1601 (R[rd] ← ADDCC(R[rs1],[rs2]);)
		11'b11001000010: OUT_Signal = 41'b00001100000110001001000110000000000000000; //1602 (SEXT13(R[IR]);)												    														  
		11'b11001000011: OUT_Signal = 41'b00000010010010000000100001100000000000000; //1603 (R[rd] ← ADDCC(R[rs1],[temp0]);)
		11'b11001000100: OUT_Signal = 41'b00001000000010000010000110111000000000000; //1604 Increment (REgistro_PC)
		//SUBCC (Resta con acarreo)	    AAAAAAMBBBBBBMCCCCCCMRWALUUCONJUMPADDRESS
		11'b11000110000: OUT_Signal = 41'b00001100000110001001000110010111000110010; //1584 (R[temp0] ← SEXT13(R[IR]); IF IR[13] THEN GOTO 1586;) Extract rs2 operand, is second source immediate?
		11'b11000110001: OUT_Signal = 41'b00000000000001001001000100000000000000000; //1585 (R[temp0] ← R[rs2];) Extract sign extended immediate operand
		11'b11000110010: OUT_Signal = 41'b00100100000000001001000011100000000000000; //1586 (R[temp0] ← NOR(R[temp0], R[0]);) Form one's complement of subtrahend
		11'b11000110011: OUT_Signal = 41'b00100100010010001001000110111011001000011; //1587 (R[temp0] ← INC(R[temp0]); GOTO 1603) Form two's complement of subtrahend, add terms for original substraction
		
		default:	OUT_Signal = 41'b10000001000000100101010010100000000000000; //Vuelve a READ			 
	endcase
end 
//STATE REGISTER: SEQUENTIAL
always @(posedge MICROCODE_STORE_CLOCK_50, posedge MICROCODE_STORE_ResetInHigh_In)
begin
	// Se carga 0 en el registro si se oprime Reset, de lo contrario se mantiene el mismo dato
	if (MICROCODE_STORE_ResetInHigh_In == 1'b1)
		OUT_Register <= 11'b00000000000;
	else
		OUT_Register <= OUT_Signal;
end

//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL 
assign	MICROCODE_STORE_SelectA_OutBus = OUT_Register[34];
assign	MICROCODE_STORE_SelectB_OutBus = OUT_Register[27];
assign	MICROCODE_STORE_SelectC_OutBus = OUT_Register[20];
assign	MICROCODE_STORE_DirA_Out = OUT_Register[40:35];
assign	MICROCODE_STORE_DirB_Out = OUT_Register[33:28];
assign	MICROCODE_STORE_DirC_Out = OUT_Register[26:21];
assign	MICROCODE_STORE_RD_Out = OUT_Register[19];
assign	MICROCODE_STORE_WRMain_Out = OUT_Register[18];
assign	MICROCODE_STORE_ALUOperation_OutBus = OUT_Register[17:14];
assign	MICROCODE_STORE_Condition_OutBus = OUT_Register[13:11];
assign	MICROCODE_STORE_JumpAddress_OutBus = OUT_Register[10:0];

endmodule
