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
module CC_MUXX_EXTERNO #(parameter DATAWIDTH_SCRATCHPAD_DIRECTION=5,parameter DATAWIDTH_MIR_DIRECTION=6)(
	//////////// OUTPUTS //////////
	CC_MUXX_EXTERNO_data_OutBus,  
	//////////// INPUTS //////////
	CC_MUXX_EXTERNO_Select_In,
	CC_MUXX_EXTERNO_MIRSelection_InBus,
	CC_MUXX_EXTERNO_ScratchpadSelection_InBus
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output 		[DATAWIDTH_MIR_DIRECTION-1:0] CC_MUXX_EXTERNO_data_OutBus;  
input 		CC_MUXX_EXTERNO_Select_In;
input			[DATAWIDTH_MIR_DIRECTION-1:0] CC_MUXX_EXTERNO_MIRSelection_InBus;
input			[DATAWIDTH_SCRATCHPAD_DIRECTION-1:0] CC_MUXX_EXTERNO_ScratchpadSelection_InBus;
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [DATAWIDTH_MIR_DIRECTION-1:0] CC_MUXX_EXTERNO_Signal_Register;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	// Elige si la dirección del registro viene desde el Scratchpad o Control de acuerdo al bus de Select
	if (CC_MUXX_EXTERNO_Select_In == 1'b0)
		CC_MUXX_EXTERNO_Signal_Register = {1'b0 , CC_MUXX_EXTERNO_ScratchpadSelection_InBus};  
	else
		CC_MUXX_EXTERNO_Signal_Register = CC_MUXX_EXTERNO_MIRSelection_InBus; 
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
assign CC_MUXX_EXTERNO_data_OutBus = CC_MUXX_EXTERNO_Signal_Register;
	
endmodule

