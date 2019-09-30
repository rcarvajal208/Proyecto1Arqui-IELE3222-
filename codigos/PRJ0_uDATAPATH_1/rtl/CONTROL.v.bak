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
module CONTROL #(parameter DATAWIDTH_SELECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATAWIDTH_DECODEROP = 8)(
	//////////// OUTPUTS //////////
	CONTROL_SelectA_OutBus,
	CONTROL_SelectB_OutBus,
	CONTROL_SelectC_OutBus,
	CONTROL_DirA_Out,
	CONTROL_DirB_Out,
	CONTROL_DirC_Out,
	CONTROL_RD_Out,
	CONTROL_WRMain_Out,
	CONTROL_ALUOperation_OutBus
	
	//////////// INPUTS //////////
	CONTROL_CLOCK_50,
	CONTROL_RESET_InHigh,
	CONTROL_ACK_In,
	CONTROL_DecodeOP_InBus,
	CONTROL_IR13_In,
	CONTROL_FlagOverflow_In,
	CONTROL_FlagNegative_In,
	CONTROL_FlagCarry_In,
	CONTROL_FlagZero_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
output 	[DATAWIDTH_SELECTION-1:0]	CONTROL_SelectA_OutBus;
output 	[DATAWIDTH_SELECTION-1:0]  CONTROL_SelectB_OutBus;
output 	[DATAWIDTH_SELECTION-1:0]	CONTROL_SelectC_OutBus;
output 	CONTROL_DirA_Out;
output 	CONTROL_DirB_Out;
output 	CONTROL_DirC_Out;
output 	CONTROL_RD_Out;
output	CONTROL_WRMain_Out;
output	[DATAWIDTH_ALU_SELECTION-1:0] CONTROL_ALUOperation_OutBus;

//////////// INPUTS //////////
input 	uDATAPATH_CLOCK_50;
input 	uDATAPATH_RESET_InHigh;
input		CONTROL_ACK_In;
input		[DATAWIDTH_DECODEROP-1:0]	CONTROL_DecodeOP_InBus;
input		CONTROL_IR13_In;
input		CONTROL_FlagOverflow_In;
input		CONTROL_FlagNegative_In;
input		CONTROL_FlagCarry_In;
input		CONTROL_FlagZero_In;

//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================



endmodule

