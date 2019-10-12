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
module BRANCH_LOGIC #(parameter BRANCH_LOGIC_PSR=4, parameter BRANCH_LOGIC_CONDITION=3, parameter BRANCH_LOGIC_TIPO=2)(
	//////////// OUTPUTS //////////
	BRANCH_LOGIC_Tipo_OutBus,
	
	//////////// INPUTS //////////
	BRANCH_LOGIC_CLOCK_50,
	BRANCH_LOGIC_ResetInHigh_In,
	BRANCH_LOGIC_IR13_In,
	BRANCH_LOGIC_Condition_InBus,
	BRANCH_LOGIC_Psr_InBus
	
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
output 	[BRANCH_LOGIC_TIPO-1:0]	BRANCH_LOGIC_Tipo_OutBus;

//////////// INPUTS //////////
input		BRANCH_LOGIC_CLOCK_50;
input 	BRANCH_LOGIC_ResetInHigh_In;
input	   BRANCH_LOGIC_IR13_In;
input		[BRANCH_LOGIC_CONDITION-1:0]	BRANCH_LOGIC_Condition_InBus;
input		[BRANCH_LOGIC_PSR-1:0]	BRANCH_LOGIC_Psr_InBus;
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg 		[BRANCH_LOGIC_CONDITION-1:0]	Condition_Signal;
reg 		[BRANCH_LOGIC_PSR-1:0] PSR_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	case (BRANCH_LOGIC_Condition_InBus)	 
		3'b000: Condition_Signal = 2'b00;
		3'b001: Condition_Signal = 2'b00;
		
		3'b010: Condition_Signal = 2'b00;
		3'b011: Condition_Signal = 2'b00;
		3'b100: Condition_Signal = 2'b00;
		3'b101: Condition_Signal = 2'b00;
		3'b110: Condition_Signal = 2'b00;
		3'b111: Condition_Signal = 2'b10;
	endcase
end


endmodule

