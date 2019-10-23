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
module MAIN_MEMORY #(parameter DATAWIDTH_BUS=32)(
	//////////// OUTPUTS //////////
	MAIN_MEMORY_ACK_Out,
	MAIN_MEMORY_Data_OutBus,	
	
	//////////// INPUTS //////////
	MAIN_MEMORY_CLOCK_50,
	MAIN_MEMORY_ResetInHigh_In,
	MAIN_MEMORY_A_InBus,
	MAIN_MEMORY_B_InBus,
	MAIN_MEMORY_RD_In,
	MAIN_MEMORY_WRMain_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
output 	MAIN_MEMORY_ACK_Out;
output 	[DATAWIDTH_BUS-1:0]  MAIN_MEMORY_Data_OutBus;

//////////// INPUTS //////////
input 	MAIN_MEMORY_CLOCK_50;
input 	MAIN_MEMORY_ResetInHigh_In;
input	   [DATAWIDTH_BUS-1:0] MAIN_MEMORY_A_InBus;
input		[DATAWIDTH_BUS-1:0] MAIN_MEMORY_B_InBus;
input		MAIN_MEMORY_RD_In;
input		MAIN_MEMORY_WRMain_In;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [DATAWIDTH_BUS-1:0] MAIN_MEMORY_Case_Register;
reg [DATAWIDTH_BUS-1:0] MAIN_MEMORY_Signal_Register;
reg [DATAWIDTH_BUS-1:0] MAIN_MEMORY_General_Register;

//=======================================================
//  Structural coding
//=======================================================
always@(*)
begin
	// Se asigna las instrucciones en formato ARC a la salida del módulo
	case (MAIN_MEMORY_A_InBus)													//		 1098		7654	  3210	 9876	 	5432	  1098	 7654	   3210
	32'b00000000000000000000000000000000: MAIN_MEMORY_Case_Register = {4'b1001,4'b0000,4'b1000,4'b0000,4'b0010,4'b0000,4'b0000,4'b1010}; // 		addcc %g0,10,%g4
	32'b00000000000000000000000000000001: MAIN_MEMORY_Case_Register = {4'b1000,4'b1010,4'b1000,4'b0000,4'b0010,4'b0000,4'b0000,4'b0001}; // 		addcc %g0,1,%g1
	32'b00000000000000000000000000000010: MAIN_MEMORY_Case_Register = {4'b1000,4'b1110,4'b1000,4'b0001,4'b0100,4'b0000,4'b0000,4'b0110}; //F2: 	addcc %g1,%g2,%g3
	32'b00000000000000000000000000000011: MAIN_MEMORY_Case_Register = {4'b1000,4'b1100,4'b1000,4'b0000,4'b0000,4'b0000,4'b0000,4'b0101}; //		addcc %g0,%g1,%g2
	32'b00000000000000000000000000000100: MAIN_MEMORY_Case_Register = {4'b1000,4'b1010,4'b1000,4'b0000,4'b0000,4'b0000,4'b0000,4'b0111}; //		addcc %g0,%g3,%g1
	32'b00000000000000000000000000000101: MAIN_MEMORY_Case_Register = {4'b1001,4'b0000,4'b1000,4'b0010,4'b0011,4'b1111,4'b1111,4'b1111}; //		addcc %g4,-1,%g4
	32'b00000000000000000000000000000110: MAIN_MEMORY_Case_Register = {4'b0001,4'b0010,4'b1011,4'b1111,4'b1111,4'b1111,4'b1111,4'b1100}; //		bne F2
	32'b00000000000000000000000000000111: MAIN_MEMORY_Case_Register = {4'b1000,4'b1110,4'b1000,4'b0000,4'b0000,4'b0000,4'b0000,4'b0110}; //		addcc %g0,%g2,%g3
	32'b00000000000000000000000000001000: MAIN_MEMORY_Case_Register = {4'b1000,4'b1110,4'b1010,4'b0001,4'b0100,4'b0000,4'b0000,4'b0111}; //F3:	subcc %g1,%g3,%g3
	32'b00000000000000000000000000001001: MAIN_MEMORY_Case_Register = {4'b1000,4'b1010,4'b1000,4'b0000,4'b0000,4'b0000,4'b0000,4'b0110}; //		addcc %g0,%g2,%g1
	32'b00000000000000000000000000001010: MAIN_MEMORY_Case_Register = {4'b1000,4'b1100,4'b1000,4'b0000,4'b0000,4'b0000,4'b0000,4'b0111}; //		addcc %g0,%g3,%g2
	32'b00000000000000000000000000001011: MAIN_MEMORY_Case_Register = {4'b0001,4'b0010,4'b1011,4'b1111,4'b1111,4'b1111,4'b1111,4'b1101}; //		bne F3
	default: MAIN_MEMORY_Case_Register = {4'b0000,4'b0001,4'b0000,4'b0000,4'b0000,4'b0000,4'b0000,4'b0000}; //		nop
	endcase
end

//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL 
assign MAIN_MEMORY_Data_OutBus = MAIN_MEMORY_Case_Register;
assign MAIN_MEMORY_ACK_Out = 1'b1;

endmodule
