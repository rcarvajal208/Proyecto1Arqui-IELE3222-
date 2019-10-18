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
module PSR #(parameter PSR_PSR=4)(
	//////////// OUTPUTS //////////
	PSR_Psr_OutBus,
	
	//////////// INPUTS //////////
	PSR_CLOCK_50,
	PSR_ResetInHigh_In,
	PSR_FlagOverflow_In,
	PSR_FlagNegative_In,
	PSR_FlagCarry_In,
	PSR_FlagZero_In,
	PSR_SetCodes_In 

);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
//////////// OUTPUTS //////////
output 	[PSR_PSR-1:0]	PSR_Psr_OutBus;

//////////// INPUTS //////////
input 	PSR_CLOCK_50;
input		PSR_ResetInHigh_In;
input		PSR_FlagOverflow_In;
input		PSR_FlagNegative_In;
input		PSR_FlagCarry_In;
input		PSR_FlagZero_In;
input		PSR_SetCodes_In;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg		[PSR_PSR-1:0]	Psr_Signal;	
reg		[PSR_PSR-1:0]	Psr_Register;

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	// A partir de la señal Set_Codes proveniente de la ALU, se actualiza la salida de banderas o se mantiene en 0
	if (PSR_SetCodes_In == 1'b1)
		Psr_Signal = {PSR_FlagCarry_In, PSR_FlagOverflow_In, PSR_FlagZero_In, PSR_FlagNegative_In}; //Se concatena el bus de banderas cvzn
	else
		Psr_Signal = Psr_Register;
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge PSR_CLOCK_50, posedge PSR_ResetInHigh_In)
begin
	if (PSR_ResetInHigh_In == 1'b1)
		Psr_Register <= 0;
	else
		Psr_Register <= Psr_Signal;
end

//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign PSR_Psr_OutBus = Psr_Register;

endmodule

