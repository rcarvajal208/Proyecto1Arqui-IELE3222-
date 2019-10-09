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
module CONTROL #(parameter DATAWIDTH_MIR_DIRECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATAWIDTH_DECODEROP = 8)(
	//////////// OUTPUTS //////////
	CONTROL_SelectA_OutBus,
	CONTROL_SelectB_OutBus,
	CONTROL_SelectC_OutBus,
	CONTROL_DirA_Out,
	CONTROL_DirB_Out,
	CONTROL_DirC_Out,
	CONTROL_RD_Out,
	CONTROL_WRMain_Out,
	CONTROL_ALUOperation_OutBus,
	
	//////////// INPUTS //////////
	CONTROL_CLOCK_50,
	CONTROL_ResetInHigh_In,
	CONTROL_ACK_In,
	CONTROL_DecodeOP_InBus,
	CONTROL_IR13_In,
	CONTROL_FlagOverflow_In,
	CONTROL_FlagNegative_In,
	CONTROL_FlagCarry_In,
	CONTROL_FlagZero_In,
	CONTROL_SetCodes_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter DATAWIDTH_PSR = 4;
parameter DATAWIDTH_ADDRESS = 11;
parameter DATAWIDTH_TIPO = 2;
parameter DATAWIDTH_COND = 3;

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
output 	[DATAWIDTH_MIR_DIRECTION-1:0]	CONTROL_SelectA_OutBus;
output 	[DATAWIDTH_MIR_DIRECTION-1:0]  CONTROL_SelectB_OutBus;
output 	[DATAWIDTH_MIR_DIRECTION-1:0]	CONTROL_SelectC_OutBus;
output 	CONTROL_DirA_Out;
output 	CONTROL_DirB_Out;
output 	CONTROL_DirC_Out;
output 	CONTROL_RD_Out;
output	CONTROL_WRMain_Out;
output	[DATAWIDTH_ALU_SELECTION-1:0] CONTROL_ALUOperation_OutBus;

//////////// INPUTS //////////
input 	CONTROL_CLOCK_50;
input 	CONTROL_ResetInHigh_In;
input		CONTROL_ACK_In;
input		[DATAWIDTH_DECODEROP-1:0]	CONTROL_DecodeOP_InBus;
input		CONTROL_IR13_In;
input		CONTROL_FlagOverflow_In;
input		CONTROL_FlagNegative_In;
input		CONTROL_FlagCarry_In;
input		CONTROL_FlagZero_In;
input		CONTROL_SetCodes_In;
//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [DATAWIDTH_PSR-1:0] PSR;
wire [DATAWIDTH_ADDRESS-1:0] JUMP;
wire [DATAWIDTH_ADDRESS-1:0] NEXT;
wire [DATAWIDTH_ADDRESS-1:0] CS;
wire [DATAWIDTH_TIPO-1:0] TIPO;
wire [DATAWIDTH_COND-1:0] COND;

//=======================================================
//  Structural coding
//=======================================================
MICROCODE_STORE #( .DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATAWIDTH_DECODEROP(DATAWIDTH_DECODEROP), .DATAWIDTH_CONDITION(DATAWIDTH_COND), .DATAWIDTH_JUMPADDRESS(DATAWIDTH_ADDRESS)) MICROCODE_STORE_u0 (
// port map - connection between master ports and signals/registers   
	.MICROCODE_STORE_SelectA_OutBus(CONTROL_SelectA_OutBus),
	.MICROCODE_STORE_SelectB_OutBus(CONTROL_SelectB_OutBus),
	.MICROCODE_STORE_SelectC_OutBus(CONTROL_SelectC_OutBus),
	.MICROCODE_STORE_DirA_Out(CONTROL_DirA_Out),
	.MICROCODE_STORE_DirB_Out(CONTROL_DirB_Out),
	.MICROCODE_STORE_DirC_Out(CONTROL_DirC_Out),
	.MICROCODE_STORE_RD_Out(CONTROL_RD_Out),
	.MICROCODE_STORE_WRMain_Out(CONTROL_WRMain_Out),
	.MICROCODE_STORE_ALUOperation_OutBus(CONTROL_ALUOperation_OutBus),
	.MICROCODE_STORE_Condition_OutBus(COND),
	.MICROCODE_STORE_JumpAddress_OutBus(JUMP),
	.MICROCODE_STORE_CLOCK_50(CONTROL_CLOCK_50),
	.MICROCODE_STORE_ResetInHigh_In(CONTROL_ResetInHigh_In),
	.MICROCODE_STORE_CSAddress_InBus(CS)
);

BRANCH_LOGIC #( .BRANCH_LOGIC_PSR(DATAWIDTH_PSR), .BRANCH_LOGIC_CONDITION(DATAWIDTH_COND), .BRANCH_LOGIC_TIPO(DATAWIDTH_TIPO)) BRANCH_LOGIC_u0 (
// port map - connection between master ports and signals/registers   
	.BRANCH_LOGIC_Tipo_OutBus(TIPO),
	.BRANCH_LOGIC_CLOCK_50(CONTROL_CLOCK_50),
	.BRANCH_LOGIC_ResetInHigh_In(CONTROL_ResetInHigh_In),
	.BRANCH_LOGIC_IR13_In(CONTROL_IR13_In),
	.BRANCH_LOGIC_Condition_InBus(COND),
	.BRANCH_LOGIC_Psr_InBus(PSR)
);


ADDRESS_INCREMENTER #( .CSAI_DATAWIDTH(DATAWIDTH_ADDRESS)) ADDRESS_INCREMENTER_u0 (
// port map - connection between master ports and signals/registers   
	.ADDRESS_INCREMENTER_CSAI_OutBus(NEXT),
	.ADDRESS_INCREMENTER_CLOCK_50(CONTROL_CLOCK_50),
	.ADDRESS_INCREMENTER_RESET_InHigh(CONTROL_ResetInHigh_In),
	.ADDRESS_INCREMENTER_ACK(CONTROL_ACK_In),
	.ADDRESS_INCREMENTER_CSAddress_InBus(CS)
);
CSADDRESS #( .DATAWIDTH_CSADDRESS(DATAWIDTH_ADDRESS), .DATAWIDTH_OPS(DATAWIDTH_DECODEROP), .DATAWIDTH_CBL(DATAWIDTH_TIPO)) CSADDRESS_u0 (
// port map - connection between master ports and signals/registers   
	.CSADDRESS_CSAddress_OutBus(CS),
	.CSADDRESS_CSAI_InBus(NEXT),
	.CSADDRESS_CLOCK_50(CONTROL_CLOCK_50),
	.CSADDRESS_ResetInHigh_In(CONTROL_ResetInHigh_In),
	.CSADDRESS_DecodeOp_InBus(CONTROL_DecodeOP_InBus),
	.CSADDRESS_Tipo_InBus(TIPO),
	.CSADDRESS_JumpAddress_InBus(JUMP)
);
PSR #( .PSR_PSR(DATAWIDTH_PSR)) PSR_u0 (
// port map - connection between master ports and signals/registers   
	.PSR_Psr_OutBus(PSR),
	.PSR_CLOCK_50(CONTROL_CLOCK_50),
	.PSR_ResetInHigh_In(CONTROL_ResetInHigh_In),
	.PSR_FlagOverflow_In(CONTROL_FlagOverflow_In),
	.PSR_FlagNegative_In(CONTROL_FlagNegative_In),
	.PSR_FlagCarry_In(CONTROL_FlagCarry_In),
	.PSR_FlagZero_In(CONTROL_FlagZero_In),
	.PSR_SetCodes_In(CONTROL_SetCodes_In)
);

endmodule

