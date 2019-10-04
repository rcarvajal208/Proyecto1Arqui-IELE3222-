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
module DATAPATH #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_SCRATCHPAD_SELECTION=5, parameter DATAWIDTH_MIR_DIRECTION=6, parameter DATAWIDTH_DECODEROP = 8, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATAWIDTH_DECODER_SELECTION=4, parameter DATAWIDTH_DECODER_OUT=14)(
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
	input [DATAWIDTH_MIR_DIRECTION-1:0] DATAPATH_DirA_InBus;
	input [DATAWIDTH_MIR_DIRECTION-1:0] DATAPATH_DirB_InBus;
	input [DATAWIDTH_MIR_DIRECTION-1:0] DATAPATH_DirC_InBus;
	input DATAPATH_SelectA_In;
	input DATAPATH_SelectB_In;
	input DATAPATH_SelectC_In;
	input [DATAWIDTH_ALU_SELECTION-1:0] DATAPATH_ALUOperation_InBus;
//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [DATAWIDTH_DECODER_OUT-1:0] DECODER_A;
wire [DATAWIDTH_DECODER_OUT-1:0] DECODER_B;
wire [DATAWIDTH_DECODER_OUT-1:0] DECODER_C;
wire [DATAWIDTH_MIR_DIRECTION-1:0] MUXA_ADRESS;
wire [DATAWIDTH_MIR_DIRECTION-1:0] MUXB_ADRESS;
wire [DATAWIDTH_MIR_DIRECTION-1:0] MUXC_ADRESS;  
// REGISTROS 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data0; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data1;
wire [DATAWIDTH_BUS-1:0] REGISTRO_data2; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data3; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data4; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data5;
wire [DATAWIDTH_BUS-1:0] REGISTRO_data6; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data7; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data8; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data9;
wire [DATAWIDTH_BUS-1:0] REGISTRO_data10; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data11; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data12; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data13;
wire [DATAWIDTH_BUS-1:0] REGISTRO_data14; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_data15; 

//=======================================================
//  Structural coding
//=======================================================
// FIXED_REGISTERS
SC_RegFIXED #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGFIXED_INIT(DATA_REGFIXED_INIT_0)) SC_RegFIXED_u0 (
// port map - connection between master ports and signals/registers   
	.SC_RegFIXED_data_OutBUS(REGISTRO_data0),
	.SC_RegFIXED_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegFIXED_RESET_InHigh(DATAPATH_ResetInHigh_In)
);
SC_RegFIXED #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGFIXED_INIT(DATA_REGFIXED_INIT_1)) SC_RegFIXED_u1 (
// port map - connection between master ports and signals/registers   
	.SC_RegFIXED_data_OutBUS(REGISTRO_data1),
	.SC_RegFIXED_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegFIXED_RESET_InHigh(DATAPATH_ResetInHigh_In)
); 
//GENERAL_REGISTERS


//DECODER
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_u0
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_datadecoder_OutBUS(DECODER_A),
	.CC_DECODER_selection_InBUS(MUXA_ADRESS)
);
// 
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_u1
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_datadecoder_OutBUS(DECODER_B),
	.CC_DECODER_selection_InBUS(MUXB_ADRESS)
);
// 
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_u1
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_datadecoder_OutBUS(DECODER_C),
	.CC_DECODER_selection_InBUS(MUXC_ADRESS)
);
//-------------------------------------------------------
//-------------------------------------------------------
//MUX
CC_MUXX #(.DATAWIDTH_SCRATCHPAD_SELECTION(DATAWIDTH_SCRATCHPAD_SELECTION), .DATAWIDTH_MIR_SELECTION(DATAWIDTH_MIR_SELECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS) ) CC_MUXX_u0
(
// port map - connection between master ports and signals/registers   
	//////////// OUTPUTS //////////
	.CC_MUX_data_OutBus(),
	.CC_MUX_Address_OutBus(MUXA_ADRESS),
	.CC_MUX_data0_InBus(REGISTRO_data0),
	.CC_MUX_data1_InBus(REGISTRO_data1),
	.CC_MUX_data2_InBus(REGISTRO_data2),
	.CC_MUX_data3_InBus(REGISTRO_data3),	
	.CC_MUX_data4_InBus(REGISTRO_data4),	
	.CC_MUX_data5_InBus(REGISTRO_data5),	
	.CC_MUX_data6_InBus(REGISTRO_data6),	
	.CC_MUX_data7_InBus(REGISTRO_data7),	
	.CC_MUX_data8_InBus(REGISTRO_data8),
	.CC_MUX_data9_InBus(REGISTRO_data9),
	.CC_MUX_data10_InBus(REGISTRO_data10),
	.CC_MUX_data11_InBus(REGISTRO_data11),	
	.CC_MUX_data12_InBus(REGISTRO_data12),
	.CC_MUX_data13_InBus(REGISTRO_data13),
	.CC_MUX_data14_InBus(REGISTRO_data14),
	.CC_MUX_data15_InBus(REGISTRO_data15), 
	.CC_MUX_Select_In(DATAPATH_SelectA_In),
	.CC_MUX_MIRSelection_InBus(DATAPATH_DirA_InBus),
	.CC_MUX_ScratchpadSelection_InBus()

);
//
CC_MUXX #(.DATAWIDTH_SCRATCHPAD_SELECTION(DATAWIDTH_SCRATCHPAD_SELECTION), .DATAWIDTH_MIR_SELECTION(DATAWIDTH_MIR_SELECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS) ) CC_MUXX_u1
(
// port map - connection between master ports and signals/registers   
	//////////// OUTPUTS //////////
	.CC_MUX_data_OutBus(),
	.CC_MUX_Address_OutBus(MUXB_ADRESS),
	.CC_MUX_data0_InBus(REGISTRO_data0),
	.CC_MUX_data1_InBus(REGISTRO_data1),
	.CC_MUX_data2_InBus(REGISTRO_data2),
	.CC_MUX_data3_InBus(REGISTRO_data3),	
	.CC_MUX_data4_InBus(REGISTRO_data4),	
	.CC_MUX_data5_InBus(REGISTRO_data5),	
	.CC_MUX_data6_InBus(REGISTRO_data6),	
	.CC_MUX_data7_InBus(REGISTRO_data7),	
	.CC_MUX_data8_InBus(REGISTRO_data8),
	.CC_MUX_data9_InBus(REGISTRO_data9),
	.CC_MUX_data10_InBus(REGISTRO_data10),
	.CC_MUX_data11_InBus(REGISTRO_data11),	
	.CC_MUX_data12_InBus(REGISTRO_data12),
	.CC_MUX_data13_InBus(REGISTRO_data13),
	.CC_MUX_data14_InBus(REGISTRO_data14),
	.CC_MUX_data15_InBus(REGISTRO_data15), 
	.CC_MUX_Select_In(DATAPATH_SelectB_In),
	.CC_MUX_MIRSelection_InBus(DATAPATH_DirB_InBus),
	.CC_MUX_ScratchpadSelection_InBus()

); 
//
CC_MUXX #(.DATAWIDTH_SCRATCHPAD_SELECTION(DATAWIDTH_SCRATCHPAD_SELECTION), .DATAWIDTH_MIR_SELECTION(DATAWIDTH_MIR_SELECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS) ) CC_MUXX_u2
(
// port map - connection between master ports and signals/registers   
	//////////// OUTPUTS //////////
	.CC_MUX_data_OutBus(),
	.CC_MUX_Address_OutBus(MUXC_ADRESS),
	.CC_MUX_data0_InBus(REGISTRO_data0),
	.CC_MUX_data1_InBus(REGISTRO_data1),
	.CC_MUX_data2_InBus(REGISTRO_data2),
	.CC_MUX_data3_InBus(REGISTRO_data3),	
	.CC_MUX_data4_InBus(REGISTRO_data4),	
	.CC_MUX_data5_InBus(REGISTRO_data5),	
	.CC_MUX_data6_InBus(REGISTRO_data6),	
	.CC_MUX_data7_InBus(REGISTRO_data7),	
	.CC_MUX_data8_InBus(REGISTRO_data8),
	.CC_MUX_data9_InBus(REGISTRO_data9),
	.CC_MUX_data10_InBus(REGISTRO_data10),
	.CC_MUX_data11_InBus(REGISTRO_data11),	
	.CC_MUX_data12_InBus(REGISTRO_data12),
	.CC_MUX_data13_InBus(REGISTRO_data13),
	.CC_MUX_data14_InBus(REGISTRO_data14),
	.CC_MUX_data15_InBus(REGISTRO_data15), 
	.CC_MUX_Select_In(DATAPATH_SelectC_In),
	.CC_MUX_MIRSelection_InBus(DATAPATH_DirC_InBus),
	.CC_MUX_ScratchpadSelection_InBus()

); 
endmodule

