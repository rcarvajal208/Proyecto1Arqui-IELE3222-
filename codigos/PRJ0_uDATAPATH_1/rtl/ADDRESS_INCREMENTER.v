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
module ADDRESS_INCREMENTER #(parameter CSAI_DATAWIDTH=11)(
	//////////// OUTPUTS //////////
	ADDRESS_INCREMENTER_CSAI_OutBus,
	//////////// INPUTS //////////
	ADDRESS_INCREMENTER_CLOCK_50,
	ADDRESS_INCREMENTER_RESET_InHigh,
	ADDRESS_INCREMENTER_ACK,
	ADDRESS_INCREMENTER_CSAddress_InBus
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output		[CSAI_DATAWIDTH-1:0]	ADDRESS_INCREMENTER_CSAI_OutBus;
input		ADDRESS_INCREMENTER_CLOCK_50;
input		ADDRESS_INCREMENTER_RESET_InHigh;
input		ADDRESS_INCREMENTER_ACK;
input		[CSAI_DATAWIDTH-1:0]	ADDRESS_INCREMENTER_CSAddress_InBus;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [CSAI_DATAWIDTH-1:0] CSAI_ADDRESS = ADDRESS_INCREMENTER_CSAddress_InBus;
reg [CSAI_DATAWIDTH-1:0] CSAI_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	if (ADDRESS_INCREMENTER_ACK == 1'b0)
		CSAI_Signal = CSAI_ADDRESS + 1;
	else
		CSAI_Signal = CSAI_ADDRESS;
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge ADDRESS_INCREMENTER_CLOCK_50, posedge ADDRESS_INCREMENTER_RESET_InHigh)
begin
	if (ADDRESS_INCREMENTER_RESET_InHigh == 1'b1)
		CSAI_ADDRESS <= 0;
	else
		CSAI_ADDRESS <= CSAI_Signal;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign ADDRESS_INCREMENTER_CSAI_OutBus = CSAI_ADDRESS;

endmodule