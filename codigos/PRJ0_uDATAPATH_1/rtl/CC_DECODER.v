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
module CC_DECODER #(parameter DATAWIDTH_DECODER_SELECTION=4, parameter DATAWIDTH_DECODER_OUT=14)(
	//////////// OUTPUTS //////////
	CC_DECODER_datadecoder_OutBUS,
	//////////// INPUTS //////////
	CC_DECODER_selection_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output reg	[DATAWIDTH_DECODER_OUT-1:0] CC_DECODER_datadecoder_OutBUS;
input		[DATAWIDTH_DECODER_SELECTION-1:0] CC_DECODER_selection_InBUS;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
	case (CC_DECODER_selection_InBUS)	 
		4'b0010: CC_DECODER_datadecoder_OutBUS = 14'b11111111111110;
		4'b0011: CC_DECODER_datadecoder_OutBUS = 14'b11111111111101;
		4'b0100: CC_DECODER_datadecoder_OutBUS = 14'b11111111111011;
		4'b0101: CC_DECODER_datadecoder_OutBUS = 14'b11111111110111;
		4'b0110: CC_DECODER_datadecoder_OutBUS = 14'b11111111101111;
		4'b0111: CC_DECODER_datadecoder_OutBUS = 14'b11111111011111;
		4'b1000: CC_DECODER_datadecoder_OutBUS = 14'b11111110111111;
		4'b1001: CC_DECODER_datadecoder_OutBUS = 14'b11111101111111;
		4'b1010: CC_DECODER_datadecoder_OutBUS = 14'b11111011111111;
		4'b1011: CC_DECODER_datadecoder_OutBUS = 14'b11110111111111;
		4'b1100: CC_DECODER_datadecoder_OutBUS = 14'b11101111111111;
		4'b1101: CC_DECODER_datadecoder_OutBUS = 14'b11011111111111;
		4'b1110: CC_DECODER_datadecoder_OutBUS = 14'b10111111111111;
		4'b1111: CC_DECODER_datadecoder_OutBUS = 14'b01111111111111;
		default : CC_DECODER_datadecoder_OutBUS = 14'b11111111111111; 
	endcase
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule
