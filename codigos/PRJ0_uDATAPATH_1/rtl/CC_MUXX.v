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
module CC_MUXX #(parameter DATAWIDTH_MIR_DIRECTION=6, parameter DATAWIDTH_BUS=32)(
	//////////// OUTPUTS //////////
	CC_MUX_data_OutBus, 
	//////////// INPUTS //////////
	CC_MUX_data0_InBus,
	CC_MUX_data1_InBus,
	CC_MUX_data2_InBus,	
	CC_MUX_data3_InBus,	
	CC_MUX_data4_InBus,	
	CC_MUX_data5_InBus,	
	CC_MUX_data6_InBus,	
	CC_MUX_data7_InBus,	
	CC_MUX_data8_InBus,
	CC_MUX_data9_InBus,
	CC_MUX_data10_InBus,
	CC_MUX_data11_InBus,	
	CC_MUX_data12_InBus,
	CC_MUX_data13_InBus,
	CC_MUX_data14_InBus,
	CC_MUX_data15_InBus, 
	CC_MUX_Address_InBus
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output 		[DATAWIDTH_BUS-1:0] CC_MUX_data_OutBus; 
input			[DATAWIDTH_BUS-1:0] CC_MUX_data0_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data1_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data2_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data3_InBus;	
input			[DATAWIDTH_BUS-1:0] CC_MUX_data4_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data5_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data6_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data7_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data8_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data9_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data10_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data11_InBus;	
input			[DATAWIDTH_BUS-1:0] CC_MUX_data12_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data13_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data14_InBus;
input			[DATAWIDTH_BUS-1:0] CC_MUX_data15_InBus;
input			[DATAWIDTH_MIR_DIRECTION-1:0] CC_MUX_Address_InBus; 

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [DATAWIDTH_BUS-1:0] CC_MUX_Signal_Register; 

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL

always@(*)
begin
	case (CC_MUX_Address_InBus)	
	//De acuerdo a la señal de dirección proveniente del registro externo, se elige el registro respectivo del cual se lee los datos
		6'b000000: CC_MUX_Signal_Register = CC_MUX_data0_InBus;
		6'b000001: CC_MUX_Signal_Register = CC_MUX_data1_InBus;
		6'b000010: CC_MUX_Signal_Register = CC_MUX_data2_InBus;
		6'b000011: CC_MUX_Signal_Register = CC_MUX_data3_InBus;
		6'b000100: CC_MUX_Signal_Register = CC_MUX_data4_InBus;
		6'b000101: CC_MUX_Signal_Register = CC_MUX_data5_InBus;
		6'b000110: CC_MUX_Signal_Register = CC_MUX_data6_InBus;
		6'b000111: CC_MUX_Signal_Register = CC_MUX_data7_InBus;
		6'b001000: CC_MUX_Signal_Register = CC_MUX_data8_InBus;
		6'b001001: CC_MUX_Signal_Register = CC_MUX_data9_InBus;
		6'b001010: CC_MUX_Signal_Register = CC_MUX_data10_InBus;
		6'b001011: CC_MUX_Signal_Register = CC_MUX_data11_InBus;
		6'b001100: CC_MUX_Signal_Register = CC_MUX_data12_InBus;
		6'b001101: CC_MUX_Signal_Register = CC_MUX_data13_InBus;
		6'b001110: CC_MUX_Signal_Register = CC_MUX_data14_InBus;
		6'b001111: CC_MUX_Signal_Register = CC_MUX_data15_InBus;
		default:   CC_MUX_Signal_Register = CC_MUX_data0_InBus; // Por defecto se selecciona el registro fijo 0 con valor 0
	endcase
end
 
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
assign CC_MUX_data_OutBus = CC_MUX_Signal_Register;
	
endmodule

