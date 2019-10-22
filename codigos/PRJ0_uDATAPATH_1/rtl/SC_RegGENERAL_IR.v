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
module SC_RegGENERAL_IR #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_SCRATCHPAD_DIRECTION=5, parameter DATAWIDTH_DECODEROP = 8)(
	SC_RegGENERAL_IR_data_OutBus,
	SC_RegGENERAL_IR_RDestino_OutBus,
	SC_RegGENERAL_IR_RS1_OutBus,
	SC_RegGENERAL_IR_RS2_OutBus,
	SC_RegGENERAL_IR_OPS_OutBus,
	SC_RegGENERAL_IR_BIT13_OutBus,
	//////////// INPUTS //////////
	SC_RegGENERAL_IR_CLOCK_50,
	SC_RegGENERAL_IR_RESET_InHigh, 
	SC_RegGENERAL_IR_load_InLow, 
	SC_RegGENERAL_IR_data_InBus
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output	[DATAWIDTH_BUS-1:0]	SC_RegGENERAL_IR_data_OutBus;
output	[DATAWIDTH_SCRATCHPAD_DIRECTION-1:0]	SC_RegGENERAL_IR_RDestino_OutBus;
output	[DATAWIDTH_SCRATCHPAD_DIRECTION-1:0]	SC_RegGENERAL_IR_RS1_OutBus;
output	[DATAWIDTH_SCRATCHPAD_DIRECTION-1:0]	SC_RegGENERAL_IR_RS2_OutBus;
output	[DATAWIDTH_DECODEROP-1:0]	SC_RegGENERAL_IR_OPS_OutBus;
output	SC_RegGENERAL_IR_BIT13_OutBus;

input		SC_RegGENERAL_IR_CLOCK_50;
input		SC_RegGENERAL_IR_RESET_InHigh; 
input		SC_RegGENERAL_IR_load_InLow;	
input		[DATAWIDTH_BUS-1:0]	SC_RegGENERAL_IR_data_InBus;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [DATAWIDTH_BUS-1:0] RegGENERAL_Register;
reg [DATAWIDTH_BUS-1:0] RegGENERAL_Signal;

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	// A partir de la señal de Cargar proveniente del Multiplexor, se carga el dato proveniente del bus de datos o se mantiene el dato existente es este
	if (SC_RegGENERAL_IR_load_InLow == 1'b0)
		RegGENERAL_Signal = SC_RegGENERAL_IR_data_InBus;
	else
		RegGENERAL_Signal = RegGENERAL_Register;
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge SC_RegGENERAL_IR_CLOCK_50, posedge SC_RegGENERAL_IR_RESET_InHigh)
begin
	// Se carga 0 en el registro si se oprime Reset, de lo contrario se mantiene el mismo dato
	if (SC_RegGENERAL_IR_RESET_InHigh == 1'b1)
		RegGENERAL_Register <= 0;
	else
		RegGENERAL_Register <= RegGENERAL_Signal;
end

//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign SC_RegGENERAL_IR_data_OutBus = RegGENERAL_Register;
assign SC_RegGENERAL_IR_RDestino_OutBus = RegGENERAL_Register[29:25];
assign SC_RegGENERAL_IR_RS1_OutBus = RegGENERAL_Register[18:14];
assign SC_RegGENERAL_IR_RS2_OutBus = RegGENERAL_Register[4:0];
assign SC_RegGENERAL_IR_OPS_OutBus = {RegGENERAL_Register[31:30],RegGENERAL_Register[24:19]};
assign SC_RegGENERAL_IR_BIT13_OutBus = RegGENERAL_Register[13];

endmodule
