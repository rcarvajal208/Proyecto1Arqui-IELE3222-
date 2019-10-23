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
module DATAPATH #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_SCRATCHPAD_DIRECTION=5, parameter DATAWIDTH_MIR_DIRECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATAWIDTH_DECODER_SELECTION=4, parameter DATAWIDTH_DECODER_OUT=14, parameter DATAWIDTH_DECODEROP = 8)(
	//////////// OUTPUTS //////////
	DATAPATH_A_OutBus, 				//Bus de salida A
	DATAPATH_B_OutBus, 				//Bus de salida B
	DATAPATH_SetCode_Out, 			//Señal set Condition Codes (a PSR)
	DATAPATH_FlagOverflow_Out, 	//Bandera de overflow
	DATAPATH_FlagNegative_Out, 	//Bandera de negativo
	DATAPATH_FlagCarry_Out, 		//Bandera de carry
	DATAPATH_FlagZero_Out,			//Bandera de ceros
	DATAPATH_DataOut_OutBus, 		//Salida del registro de instrucción
	DATAPATH_Bit13_Out, 				//Salida del registro de instrucción
	DATAPATH_OPS_OutBus, 			//Salida del registro de instrucción
	
	//////////// INPUTS //////////
	DATAPATH_CLOCK_50,				//Clock 
	DATAPATH_ResetInHigh_In,		//Reset
	DATAPATH_MemoryData_InBus,		//Data recibido de Main Memory
	DATAPATH_RD_In,					//Señal RD enviada de bloque CONTROL
	DATAPATH_DirA_InBus,				//Dirección recibida por A MUX
	DATAPATH_DirB_InBus,				//Dirección recibida por B MUX
	DATAPATH_DirC_InBus,				//Dirección recibida por C MUX
	DATAPATH_SelectA_In,				//Selección recibida por A MUX
	DATAPATH_SelectB_In,				//Selección recibida por B MUX
	DATAPATH_SelectC_In, 			//Selección recibida por C MUX
	DATAPATH_ALUOperation_InBus	//Operación a realizar ALU
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter DATA_REGFIXED_INIT_0 = 32'b00000000000000000000000000000000;
parameter DATA_REGFIXED_INIT_1 = 32'b00000000000000000000000000000001; 

//=======================================================
//  PORT declarations
//=======================================================
	//////////// OUTPUTS //////////
	output [DATAWIDTH_BUS-1:0] DATAPATH_A_OutBus;
	output [DATAWIDTH_BUS-1:0] DATAPATH_B_OutBus;
	output DATAPATH_SetCode_Out; 
	output DATAPATH_FlagOverflow_Out;
	output DATAPATH_FlagNegative_Out;
	output DATAPATH_FlagCarry_Out;
	output DATAPATH_FlagZero_Out;
	output [DATAWIDTH_BUS-1:0] DATAPATH_DataOut_OutBus;
	output DATAPATH_Bit13_Out;
	output [DATAWIDTH_DECODEROP-1:0] DATAPATH_OPS_OutBus;
	
	//////////// INPUTS //////////
	input DATAPATH_CLOCK_50;
	input DATAPATH_ResetInHigh_In;
	input [DATAWIDTH_BUS-1:0] DATAPATH_MemoryData_InBus;
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
// ADDRESS MUX 
wire [DATAWIDTH_MIR_DIRECTION-1:0] ADDRESS_A;
wire [DATAWIDTH_MIR_DIRECTION-1:0] ADDRESS_B;
wire [DATAWIDTH_MIR_DIRECTION-1:0] ADDRESS_C; 
wire [DATAWIDTH_DECODER_OUT-1:0] LOAD;
wire [DATAWIDTH_BUS-1:0] MUX_C_BUS; 
wire [DATAWIDTH_BUS-1:0] ALU_DATA; 
wire [DATAWIDTH_BUS-1:0] SCRATCHPAD_RDestino; 
wire [DATAWIDTH_BUS-1:0] SCRATCHPAD_RS1; 
wire [DATAWIDTH_BUS-1:0] SCRATCHPAD_RS2; 
// REGISTROS 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_0; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_1;
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_2; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_3;
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_5;
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_6; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_7; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_8; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_9;
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_10; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_11; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_12; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_13;
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_14; 
wire [DATAWIDTH_BUS-1:0] REGISTRO_DATA_15; 

//=======================================================
//  Structural coding
//=======================================================

//ALU 
CC_ALU #( .DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION)) CC_ALU_u0(
	
	.CC_ALU_overflow_OutLow(DATAPATH_FlagOverflow_Out),
	.CC_ALU_carry_OutLow(DATAPATH_FlagCarry_Out),
	.CC_ALU_negative_OutLow(DATAPATH_FlagNegative_Out),
	.CC_ALU_zero_OutLow(DATAPATH_FlagZero_Out),
	.CC_ALU_SetCode_Out(DATAPATH_SetCode_Out),
	.CC_ALU_data_OutBus(ALU_DATA), 
	.CC_ALU_dataA_InBus(DATAPATH_A_OutBus),
	.CC_ALU_dataB_InBus(DATAPATH_B_OutBus),
	.CC_ALU_selection_InBus(DATAPATH_ALUOperation_InBus)

);

//MUX implementado para bus A, de esta forma no son necesarios registros con alta impedancia
CC_MUXX #(.DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS) ) CC_MUXX_ABUS (
 
	.CC_MUX_data_OutBus(DATAPATH_A_OutBus), 
	.CC_MUX_data0_InBus(REGISTRO_DATA_0),
	.CC_MUX_data1_InBus(REGISTRO_DATA_1),
	.CC_MUX_data2_InBus(REGISTRO_DATA_2),
	.CC_MUX_data3_InBus(REGISTRO_DATA_3),	
	.CC_MUX_data4_InBus(DATAPATH_DataOut_OutBus),	
	.CC_MUX_data5_InBus(REGISTRO_DATA_5),	
	.CC_MUX_data6_InBus(REGISTRO_DATA_6),	
	.CC_MUX_data7_InBus(REGISTRO_DATA_7),	
	.CC_MUX_data8_InBus(REGISTRO_DATA_8),
	.CC_MUX_data9_InBus(REGISTRO_DATA_9),
	.CC_MUX_data10_InBus(REGISTRO_DATA_10),
	.CC_MUX_data11_InBus(REGISTRO_DATA_11),	
	.CC_MUX_data12_InBus(REGISTRO_DATA_12),
	.CC_MUX_data13_InBus(REGISTRO_DATA_13),
	.CC_MUX_data14_InBus(REGISTRO_DATA_14),
	.CC_MUX_data15_InBus(REGISTRO_DATA_15), 
	.CC_MUX_Address_InBus(ADDRESS_A)

);

//MUX implementado para bus B
CC_MUXX #(.DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS) ) CC_MUXX_BBUS (
   
	.CC_MUX_data_OutBus(DATAPATH_B_OutBus), 
	.CC_MUX_data0_InBus(REGISTRO_DATA_0),
	.CC_MUX_data1_InBus(REGISTRO_DATA_1),
	.CC_MUX_data2_InBus(REGISTRO_DATA_2),
	.CC_MUX_data3_InBus(REGISTRO_DATA_3),	
	.CC_MUX_data4_InBus(DATAPATH_DataOut_OutBus),	
	.CC_MUX_data5_InBus(REGISTRO_DATA_5),	
	.CC_MUX_data6_InBus(REGISTRO_DATA_6),	
	.CC_MUX_data7_InBus(REGISTRO_DATA_7),	
	.CC_MUX_data8_InBus(REGISTRO_DATA_8),
	.CC_MUX_data9_InBus(REGISTRO_DATA_9),
	.CC_MUX_data10_InBus(REGISTRO_DATA_10),
	.CC_MUX_data11_InBus(REGISTRO_DATA_11),	
	.CC_MUX_data12_InBus(REGISTRO_DATA_12),
	.CC_MUX_data13_InBus(REGISTRO_DATA_13),
	.CC_MUX_data14_InBus(REGISTRO_DATA_14),
	.CC_MUX_data15_InBus(REGISTRO_DATA_15), 
	.CC_MUX_Address_InBus(ADDRESS_B)

);  

//MUX implementado para bus C
CC_MUXX_LOAD #(.DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT) ) CC_MUXX_LOAD_CBUSMUX (

	.CC_MUXX_LOAD_data_OutBus(MUX_C_BUS),
	.CC_MUXX_LOAD_Load_OutBus(LOAD), 
	.CC_MUXX_LOAD_RD_In(DATAPATH_RD_In),	
	.CC_MUXX_LOAD_ALU_data_InBus(ALU_DATA),	
	.CC_MUXX_LOAD_Memory_data_InBus(DATAPATH_MemoryData_InBus),
	.CC_MUXX_LOAD_Address_InBus(ADDRESS_C)
); 

//MUX de selección de registro A
CC_MUXX_EXTERNO #(.DATAWIDTH_SCRATCHPAD_DIRECTION(DATAWIDTH_SCRATCHPAD_DIRECTION), .DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION) ) CC_MUXX_EXTERNO_AMUX (
   
	.CC_MUXX_EXTERNO_data_OutBus(ADDRESS_A),
	.CC_MUXX_EXTERNO_Select_In(DATAPATH_SelectA_In),
	.CC_MUXX_EXTERNO_MIRSelection_InBus(DATAPATH_DirA_InBus),
	.CC_MUXX_EXTERNO_ScratchpadSelection_InBus(SCRATCHPAD_RS1)

);

//MUX de selección de registro B  
CC_MUXX_EXTERNO #(.DATAWIDTH_SCRATCHPAD_DIRECTION(DATAWIDTH_SCRATCHPAD_DIRECTION), .DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION) ) CC_MUXX_EXTERNO_BMUX (
   
	.CC_MUXX_EXTERNO_data_OutBus(ADDRESS_B),
	.CC_MUXX_EXTERNO_Select_In(DATAPATH_SelectB_In),
	.CC_MUXX_EXTERNO_MIRSelection_InBus(DATAPATH_DirB_InBus),
	.CC_MUXX_EXTERNO_ScratchpadSelection_InBus(SCRATCHPAD_RS2)

);

//MUX de selección de registro C para escritura  
CC_MUXX_EXTERNO #(.DATAWIDTH_SCRATCHPAD_DIRECTION(DATAWIDTH_SCRATCHPAD_DIRECTION), .DATAWIDTH_MIR_DIRECTION(DATAWIDTH_MIR_DIRECTION) ) CC_MUXX_EXTERNO_CMUX (
   
	.CC_MUXX_EXTERNO_data_OutBus(ADDRESS_C),
	.CC_MUXX_EXTERNO_Select_In(DATAPATH_SelectC_In),
	.CC_MUXX_EXTERNO_MIRSelection_InBus(DATAPATH_DirC_InBus),
	.CC_MUXX_EXTERNO_ScratchpadSelection_InBus(SCRATCHPAD_RDestino)

);  

//-------------------------------------------------------
//RESISTROS FIJOS
//-------------------------------------------------------

//Registro de valor fijo 0
SC_RegFIXED #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGFIXED_INIT(DATA_REGFIXED_INIT_0)) SC_RegFIXED_R0 (

	.SC_RegFIXED_data_OutBus(REGISTRO_DATA_0),
	.SC_RegFIXED_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegFIXED_RESET_InHigh(DATAPATH_ResetInHigh_In)
);

//Registro de valor fijo 1
SC_RegFIXED #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGFIXED_INIT(DATA_REGFIXED_INIT_1)) SC_RegFIXED_R1 (
  
	.SC_RegFIXED_data_OutBus(REGISTRO_DATA_1),
	.SC_RegFIXED_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegFIXED_RESET_InHigh(DATAPATH_ResetInHigh_In)
); 

//-------------------------------------------------------
// REGISTRO GENERAL CONTADOR DE PROGRAMA
//-------------------------------------------------------

SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_PC ( 
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_2),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[0]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);

//-------------------------------------------------------
// REGISTRO GENERAL MEMORIA PRINCIPAL
//-------------------------------------------------------

SC_RegGENERAL_IR #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_SCRATCHPAD_DIRECTION(DATAWIDTH_SCRATCHPAD_DIRECTION), .DATAWIDTH_DECODEROP(DATAWIDTH_DECODEROP)) SC_RegGENERAL_IR_u0 (
   
	//////////// OUTPUTS //////////
	.SC_RegGENERAL_IR_data_OutBus(REGISTRO_DATA_3),
	.SC_RegGENERAL_IR_RDestino_OutBus(SCRATCHPAD_RDestino),
	.SC_RegGENERAL_IR_RS1_OutBus(SCRATCHPAD_RS1),
	.SC_RegGENERAL_IR_RS2_OutBus(SCRATCHPAD_RS2),
	.SC_RegGENERAL_IR_OPS_OutBus(DATAPATH_OPS_OutBus),
	.SC_RegGENERAL_IR_BIT13_OutBus(DATAPATH_Bit13_Out),
	//////////// INPUTS //////////
	.SC_RegGENERAL_IR_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_IR_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_IR_load_InLow(LOAD[1]),
	.SC_RegGENERAL_IR_data_InBus(MUX_C_BUS)
);

//-------------------------------------------------------
// REGISTRO GENERAL DE SALIDA DE BBSYSTEM
//-------------------------------------------------------

SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_Out (
   
	.SC_RegGENERAL_data_OutBus(DATAPATH_DataOut_OutBus),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[2]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);

//-------------------------------------------------------
// REGISTROS DE PROPÓSITO GENERAL
//-------------------------------------------------------

SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R1 (
   
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_5),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[3]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R2 (
   
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_6),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[4]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R3 (
   
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_7),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[5]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R4 (
  
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_8),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[6]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R5 (
   
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_9),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[7]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R6 (
  
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_10),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[8]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R7 (
  
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_11),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[9]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R8 (
   
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_12),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[10]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R9 (
   
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_13),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[11]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_R10 (
   
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_14),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[12]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r11 (
   
	.SC_RegGENERAL_data_OutBus(REGISTRO_DATA_15),
	.SC_RegGENERAL_CLOCK_50(DATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(DATAPATH_ResetInHigh_In), 
	.SC_RegGENERAL_load_InLow(LOAD[13]),
	.SC_RegGENERAL_data_InBus(MUX_C_BUS)
);  

endmodule

