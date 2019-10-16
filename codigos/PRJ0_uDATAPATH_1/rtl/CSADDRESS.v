/*######################################################################
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be eful,
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
module CSADDRESS #(parameter DATAWIDTH_CSADDRESS=11, parameter DATAWIDTH_OPS=8, parameter DATAWIDTH_CBL=2)(
	//////////// OUTPUTS //////////
	CSADDRESS_CSAddress_OutBus,
	
	//////////// INPUTS //////////
	CSADDRESS_CSAI_InBus,
	CSADDRESS_CLOCK_50,
	CSADDRESS_ResetInHigh_In,
	CSADDRESS_DecodeOp_InBus,
	CSADDRESS_Tipo_InBus,
	CSADDRESS_JumpAddress_InBus

);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
output	[DATAWIDTH_CSADDRESS-1:0]	CSADDRESS_CSAddress_OutBus;

/////////// INPUTS //////////
input		CSADDRESS_CLOCK_50;
input		CSADDRESS_ResetInHigh_In;
input		[DATAWIDTH_CBL-1:0] CSADDRESS_Tipo_InBus;	
input		[DATAWIDTH_OPS-1:0] CSADDRESS_DecodeOp_InBus;
input		[DATAWIDTH_CSADDRESS-1:0] CSADDRESS_CSAI_InBus;
input		[DATAWIDTH_CSADDRESS-1:0] CSADDRESS_JumpAddress_InBus;
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg	[DATAWIDTH_CSADDRESS-1:0]	CSADDRESS_Signal_Address;
reg	[DATAWIDTH_CSADDRESS-1:0]	CSADDRESS_Signal_Decode;
reg	[DATAWIDTH_CSADDRESS-1:0]	CSADDRESS_General_Address;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	//Proceso de decodificación según OP
	if (CSADDRESS_DecodeOp_InBus[7:6] == 2'b00)
		CSADDRESS_Signal_Decode = {1'b1 + CSADDRESS_DecodeOp_InBus[7:3] + 5'b00000};
	else
		CSADDRESS_Signal_Decode = {1'b1 + CSADDRESS_DecodeOp_InBus + 2'b00};
end
begin
	// A partir de la señal de Cargar proveniente del Multiplexor, se carga el dato proveniente del bus de datos o se mantiene el dato existente es este
	case (CSADDRESS_Tipo_InBus)	 
		2'b00: CSADDRESS_Signal_Address = CSADDRESS_CSAI_InBus;		//Next (Señal recibidad de incrementer)
		2'b01: CSADDRESS_Signal_Address = CSADDRESS_JumpAddress_InBus;		//Jump (Señal recibida de Microcode_Store)
		2'b10: CSADDRESS_Signal_Address = CSADDRESS_Signal_Decode;	//Decodificación de registro de instrucciones OPS
		default : CSADDRESS_Signal_Address = CSADDRESS_CSAI_InBus;		//Next (Señal recibidad de incrementer)
	endcase
end
//STATE REGISTER: SEQUENTIAL
always @(posedge CSADDRESS_CLOCK_50, posedge CSADDRESS_ResetInHigh_In)
begin
	// Se carga 0 en el registro si se oprime Reset, de lo contrario se mantiene el mismo dato
	if (CSADDRESS_ResetInHigh_In == 1'b1)
		CSADDRESS_General_Address <= 11'b00000000000;
	else
		CSADDRESS_General_Address <= CSADDRESS_Signal_Address;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign CSADDRESS_CSAddress_OutBus = CSADDRESS_General_Address;

endmodule
