/*######################################################################
//######################################################################
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
module MAIN_MEMORY #(parameter DATAWIDTH_BUS=32)(
	//////////// OUTPUTS //////////
	MAIN_MEMORY_ACK_Out,
	MAIN_MEMORY_Data_OutBus,	
	
	//////////// INPUTS //////////
	MAIN_MEMORY_CLOCK_50,
	MAIN_MEMORY_ResetInHigh_In,
	MAIN_MEMORY_A_InBus,
	MAIN_MEMORY_B_InBus,
	MAIN_MEMORY_RD_In,
	MAIN_MEMORY_WR_In
	
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
output 	MAIN_MEMORY_ACK_Out;
output 	[DATAWIDTH_BUS-1:0]  MAIN_MEMORY_Data_OutBus;

//////////// INPUTS //////////
input 	MAIN_MEMORY_CLOCK_50;
input 	MAIN_MEMORY_ResetInHigh_In;
input	   [DATAWIDTH_BUS-1:0] MAIN_MEMORY_A_InBus;
input		[DATAWIDTH_BUS-1:0] MAIN_MEMORY_B_InBus;
input		MAIN_MEMORY_RD_In;
input		MAIN_MEMORY_WR_In;

//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================



endmodule