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
module BB_SYSTEM (
//////////// OUTPUTS //////////
	BB_SYSTEM_data_OutBUS,			//Salida del Registro general 3 (Rout)
//////////// INPUTS //////////
	CLOCK,								
	RESET
);
//=======================================================
//  PARAMETER declarations
//=======================================================

parameter DATAWIDTH_BUS = 32; 					// DATAPATH WIDTH BUS.
parameter DATAWIDTH_MIR_DIRECTION=6; 			// DATAPATH MIR DIRECTION BUS.
parameter DATAWIDTH_SCRATCHPAD_DIRECTION=5; 	// DATAPATH SCRATCHPAD DIRECTION BUS.
parameter DATAWIDTH_ALU_SELECTION = 4; 		// ALU CONTROL BUS.
parameter DATAWIDTH_DECODEROP = 8;				// DECODE OP BUS.
parameter DATAWIDTH_DECODER_SELECTION=4; 		// DECODER SELECTION BUS.
parameter DATAWIDTH_DECODER_OUT=14; 			// DECODER OUT BUS.


//=======================================================
//  PORT declarations
//=======================================================
output	[DATAWIDTH_BUS-1:0] BB_SYSTEM_data_OutBUS;
input 	CLOCK;
input 	RESET;

//=======================================================
//  REG/WIRE declarations
//=======================================================
	
// MAIN MEMORY
	wire ACK;
	wire [DATAWIDTH_BUS-1:0]	DATA;	
	wire [DATAWIDTH_BUS-1:0]	ABUS;
	wire [DATAWIDTH_BUS-1:0]	BBUS;
	wire RD;
	wire WRMAIN;
// CONTROL
	wire SELECTA;
	wire SELECTB;
	wire SELECTC;
	wire [DATAWIDTH_MIR_DIRECTION-1:0] DIRA;
	wire [DATAWIDTH_MIR_DIRECTION-1:0] DIRB;
	wire [DATAWIDTH_MIR_DIRECTION-1:0] DIRC;
	wire [DATAWIDTH_ALU_SELECTION-1:0] ALUOPERATION;
	wire FLAGOVERFLOW;
	wire FLAGNEGATIVE;
	wire FLAGCARRY;
	wire FLAGZERO;
	wire SETCODES;
	wire BIT13;
	wire [DATAWIDTH_DECODEROP-1:0] OPS;

//=======================================================
//  Structural coding
//=======================================================
DATAPATH #( .DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION), .DATAWIDTH_SCRATCHPAD_DIRECTION(DATAWIDTH_SCRATCHPAD_DIRECTION),  .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT), .DATAWIDTH_DECODEROP(DATAWIDTH_DECODEROP)) DATAPATH_u0 (

	//////////// OUTPUTS //////////  
	.DATAPATH_A_OutBus(ABUS),
	.DATAPATH_B_OutBus(BBUS),
	.DATAPATH_SetCode_Out(SETCODES), 
	.DATAPATH_FlagOverflow_Out(FLAGOVERFLOW),
	.DATAPATH_FlagNegative_Out(FLAGNEGATIVE),
	.DATAPATH_FlagCarry_Out(FLAGCARRY),
	.DATAPATH_FlagZero_Out(FLAGZERO),
	.DATAPATH_DataOut_OutBus(BB_SYSTEM_data_OutBUS),
	.DATAPATH_Bit13_Out(BIT13), 				
	.DATAPATH_OPS_OutBus(OPS),
	//////////// INPUTS //////////
	.DATAPATH_CLOCK_50(CLOCK),
	.DATAPATH_ResetInHigh_In(RESET),
	.DATAPATH_MemoryData_InBus(DATA),
	.DATAPATH_RD_In(RD),
	.DATAPATH_DirA_InBus(DIRA),
	.DATAPATH_DirB_InBus(DIRB),
	.DATAPATH_DirC_InBus(DIRC),
	.DATAPATH_SelectA_In(SELECTA),
	.DATAPATH_SelectB_In(SELECTB),
	.DATAPATH_SelectC_In(SELECTC),  
	.DATAPATH_ALUOperation_InBus(ALUOPERATION)
);
CONTROL #( .DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATAWIDTH_DECODEROP(DATAWIDTH_DECODEROP) ) CONTROL_u0 (
	//////////// OUTPUTS //////////
	.CONTROL_SelectA_OutBus(SELECTA),
	.CONTROL_SelectB_OutBus(SELECTB),
	.CONTROL_SelectC_OutBus(SELECTC),
	.CONTROL_DirA_Out(DIRA),
	.CONTROL_DirB_Out(DIRB),
	.CONTROL_DirC_Out(DIRC),
	.CONTROL_RD_Out(RD),
	.CONTROL_WRMain_Out(WRMAIN),
	.CONTROL_ALUOperation_OutBus(ALUOPERATION),
	//////////// INPUTS //////////
	.CONTROL_CLOCK_50(CLOCK),
	.CONTROL_ResetInHigh_In(RESET),
	.CONTROL_ACK_In(ACK),
	.CONTROL_DecodeOP_InBus(OPS),
	.CONTROL_IR13_In(BIT13),
	.CONTROL_FlagOverflow_In(FLAGOVERFLOW),
	.CONTROL_FlagNegative_In(FLAGNEGATIVE),
	.CONTROL_FlagCarry_In(FLAGCARRY),
	.CONTROL_FlagZero_In(FLAGZERO),
	.CONTROL_SetCodes_In(SETCODES)
);
MAIN_MEMORY #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) MAIN_MEMORY_u0 (
	//////////// OUTPUTS //////////
	.MAIN_MEMORY_ACK_Out(ACK),
	.MAIN_MEMORY_Data_OutBus(DATA),
	//////////// INPUTS //////////	
	.MAIN_MEMORY_CLOCK_50(CLOCK),
	.MAIN_MEMORY_ResetInHigh_In(RESET),
	.MAIN_MEMORY_A_InBus(ABUS),
	.MAIN_MEMORY_B_InBus(BBUS),
	.MAIN_MEMORY_RD_In(RD),
	.MAIN_MEMORY_WRMain_In(WRMAIN)
);
endmodule
