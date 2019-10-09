/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
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


//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL


//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL


endmodule
