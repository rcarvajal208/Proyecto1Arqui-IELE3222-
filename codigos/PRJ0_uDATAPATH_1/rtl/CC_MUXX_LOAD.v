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
module CC_MUXX_LOAD #(parameter DATAWIDTH_MIR_DIRECTION=6, parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_OUT=14)(
	//////////// OUTPUTS //////////
	CC_MUXX_LOAD_data_OutBus,
	CC_MUXX_LOAD_Load_OutBus,
	//////////// INPUTS //////////  
	CC_MUXX_LOAD_RD_In,	
	CC_MUXX_LOAD_ALU_data_InBus,	
	CC_MUXX_LOAD_Memory_data_InBus,
	CC_MUXX_LOAD_Address_InBus
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output 		[DATAWIDTH_BUS-1:0] CC_MUXX_LOAD_data_OutBus; 
output 		[DATAWIDTH_DECODER_OUT-1:0] CC_MUXX_LOAD_Load_OutBus;
input 		CC_MUXX_LOAD_RD_In;
input			[DATAWIDTH_BUS-1:0] CC_MUXX_LOAD_ALU_data_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUXX_LOAD_Memory_data_InBus;
input			[DATAWIDTH_MIR_DIRECTION-1:0] CC_MUXX_LOAD_Address_InBus;
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [DATAWIDTH_BUS-1:0] CC_MUXX_LOAD_Signal_Register;
reg [DATAWIDTH_DECODER_OUT-1:0] CC_MUXX_LOAD_Decoder_Register;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
	//Se determina si se lee la ALU o MAIN_MEMORY
begin
	if (CC_MUXX_LOAD_RD_In == 1'b1) 
		CC_MUXX_LOAD_Signal_Register = CC_MUXX_LOAD_Memory_data_InBus;
	else
		CC_MUXX_LOAD_Signal_Register = CC_MUXX_LOAD_ALU_data_InBus; 
end

always@(*)
	//Se decodifica la señal de salida para los registros
begin
	case (CC_MUXX_LOAD_Address_InBus)	 
		6'b000010: CC_MUXX_LOAD_Decoder_Register = 14'b11111111111110;
		6'b000011: CC_MUXX_LOAD_Decoder_Register = 14'b11111111111101;
		6'b000100: CC_MUXX_LOAD_Decoder_Register = 14'b11111111111011;
		6'b000101: CC_MUXX_LOAD_Decoder_Register = 14'b11111111110111;
		6'b000110: CC_MUXX_LOAD_Decoder_Register = 14'b11111111101111;
		6'b000111: CC_MUXX_LOAD_Decoder_Register = 14'b11111111011111;
		6'b001000: CC_MUXX_LOAD_Decoder_Register = 14'b11111110111111;
		6'b001001: CC_MUXX_LOAD_Decoder_Register = 14'b11111101111111;
		6'b001010: CC_MUXX_LOAD_Decoder_Register = 14'b11111011111111;
		6'b001011: CC_MUXX_LOAD_Decoder_Register = 14'b11110111111111;
		6'b001100: CC_MUXX_LOAD_Decoder_Register = 14'b11101111111111;
		6'b001101: CC_MUXX_LOAD_Decoder_Register = 14'b11011111111111;
		6'b001110: CC_MUXX_LOAD_Decoder_Register = 14'b10111111111111;
		6'b001111: CC_MUXX_LOAD_Decoder_Register = 14'b01111111111111;
		default : CC_MUXX_LOAD_Decoder_Register = 14'b11111111111111; 
	endcase
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL 
assign CC_MUXX_LOAD_data_OutBus = CC_MUXX_LOAD_Signal_Register;
assign CC_MUXX_LOAD_Load_OutBus = CC_MUXX_LOAD_Decoder_Register;

endmodule

