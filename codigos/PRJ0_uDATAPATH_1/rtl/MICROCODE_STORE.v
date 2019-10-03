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
module MICROCODE_STORE #(parameter DATAWIDTH_DIRECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATAWIDTH_DECODEROP = 8, parameter DATAWIDTH_CONDITION=3, parameter DATAWIDTH_JUMPADDRESS=11)(
	
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
output 	[DATAWIDTH_DIRECTION-1:0]	MICROCODE_STORE_DirA_Out;
output 	[DATAWIDTH_DIRECTION-1:0]	MICROCODE_STORE_DirB_Out;
output 	[DATAWIDTH_DIRECTION-1:0]	MICROCODE_STORE_DirC_Out;
output 	MICROCODE_STORE_RD_Out;
output	MICROCODE_STORE_WRMain_Out;
output	[DATAWIDTH_ALU_SELECTION-1:0] MICROCODE_STORE_ALUOperation_OutBus;
output	[DATAWIDTH_CONDITION -1:0] MICROCODE_STORE_Condition_OutBus;
output	[DATAWIDTH_JUMPADDRESS -1:0] MICROCODE_STORE_JumpAddress_OutBus;

//////////// INPUTS //////////
input 	MICROCODE_STORE_CLOCK_50;
input 	MICROCODE_STORE_ResetInHigh_In;
input		[DATAWIDTH_JUMPADDRESS-1:0]	MICROCODE_STORE_CSAddress_InBus;

//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================



endmodule
