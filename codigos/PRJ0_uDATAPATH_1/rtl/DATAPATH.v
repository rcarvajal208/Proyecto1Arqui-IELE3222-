/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
//# Copyright (C) 2018. F.E.Segura-Quijano (FES) fsegura@uniandes.edu.co
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
module DATAPATH #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DIRECTION=6, parameter DATAWIDTH_DECODEROP = 8, parameter DATAWIDTH_ALU_SELECTION=4)(
	//////////// OUTPUTS //////////
	DATAPATH_A_OutBus,
	DATAPATH_B_OutBus,
	DATAPATH_ConditionCode_Out,
	DATAPATH_DecodeOP_OutBus,
	DATAPATH_IR13_Out,
	DATAPATH_FlagOverflow_Out,
	DATAPATH_FlagNegative_Out,
	DATAPATH_FlagCarry_Out,
	DATAPATH_FlagZero_Out,
	DATAPATH_DataOut_OutBus,
	
	//////////// INPUTS //////////
	DATAPATH_CLOCK_50,
	DATAPATH_ResetInHigh_In,
	DATAPATH_MemoryData_InBUS,
	DATAPATH_RD_In,
	DATAPATH_DirA_InBus,
	DATAPATH_DirB_InBus,
	DATAPATH_DirC_InBus,
	DATAPATH_SelectA_In,
	DATAPATH_SelectB_In,
	DATAPATH_SelectC_In,
	DATAPATH_ALUOperation_InBus
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
	output [DATAWIDTH_BUS-1:0] DATAPATH_A_OutBus;
	output [DATAWIDTH_BUS-1:0] DATAPATH_B_OutBus;
	output DATAPATH_ConditionCode_Out;
	output [DATAWIDTH_DECODEROP-1:0] DATAPATH_DecodeOP_OutBus;
	output DATAPATH_IR13_Out;
	output DATAPATH_FlagOverflow_Out;
	output DATAPATH_FlagNegative_Out;
	output DATAPATH_FlagCarry_Out;
	output DATAPATH_FlagZero_Out;
	output [DATAWIDTH_BUS-1:0] DATAPATH_DataOut_OutBus;
	
	//////////// INPUTS //////////
	input DATAPATH_CLOCK_50;
	input DATAPATH_ResetInHigh_In;
	input [DATAWIDTH_BUS-1:0] DATAPATH_MemoryData_InBUS;
	input DATAPATH_RD_In;
	input [DATAWIDTH_DIRECTION-1:0] DATAPATH_DirA_InBus;
	input [DATAWIDTH_DIRECTION-1:0] DATAPATH_DirB_InBus;
	input [DATAWIDTH_DIRECTION-1:0] DATAPATH_DirC_InBus;
	input DATAPATH_SelectA_In;
	input DATAPATH_SelectB_In;
	input DATAPATH_SelectC_In;
	input [DATAWIDTH_ALU_SELECTION-1:0] DATAPATH_ALUOperation_InBus;
//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================

//-------------------------------------------------------
//GENERAL_REGISTERS

endmodule

