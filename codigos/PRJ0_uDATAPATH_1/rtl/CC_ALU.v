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
module CC_ALU #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_ALU_SELECTION=4)(
	//////////// OUTPUTS //////////
	CC_ALU_overflow_OutLow,
	CC_ALU_carry_OutLow,
	CC_ALU_negative_OutLow,
	CC_ALU_zero_OutLow,
	CC_ALU_SetCode_Out,
	CC_ALU_data_OutBus,
	//////////// INPUTS //////////
	CC_ALU_dataA_InBus,
	CC_ALU_dataB_InBus,
	CC_ALU_selection_InBus
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output 			CC_ALU_overflow_OutLow;
output 			CC_ALU_carry_OutLow;
output 			CC_ALU_negative_OutLow;
output 			CC_ALU_SetCode_Out;
output 			CC_ALU_zero_OutLow;
output reg		[DATAWIDTH_BUS-1:0] CC_ALU_data_OutBus;
input			[DATAWIDTH_BUS-1:0] CC_ALU_dataA_InBus;
input			[DATAWIDTH_BUS-1:0] CC_ALU_dataB_InBus;
input			[DATAWIDTH_ALU_SELECTION-1:0] CC_ALU_selection_InBus;

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire caover,cout;
wire [DATAWIDTH_BUS-2:0] addition0; // Variable usada para la operación suma y para determinar las flags
wire addition1;							// Variable usada para la operación suma y para determinar las flags
reg CC_ALU_General_SetCode;

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
	case (CC_ALU_selection_InBus)	
		4'b0000:  CC_ALU_data_OutBus = CC_ALU_dataA_InBus; 							//BUSA
		4'b0001:  CC_ALU_data_OutBus = CC_ALU_dataA_InBus | CC_ALU_dataB_InBus;	//OR
		4'b0010:  CC_ALU_data_OutBus = CC_ALU_dataA_InBus & CC_ALU_dataB_InBus;	//AND
		4'b0011:  begin
					 CC_ALU_data_OutBus = CC_ALU_dataA_InBus + CC_ALU_dataB_InBus;	//ADDCC   (***)
					 CC_ALU_General_SetCode = 1'b1;
					 end
		4'b0100:  CC_ALU_data_OutBus = CC_ALU_dataA_InBus ^ CC_ALU_dataB_InBus;	//XOR
		4'b0101:  begin
					 CC_ALU_data_OutBus = CC_ALU_dataA_InBus & CC_ALU_dataB_InBus;	//AND   	 (***)
					 CC_ALU_General_SetCode = 1'b0;
					 end
		4'b0110:  CC_ALU_data_OutBus = CC_ALU_dataA_InBus;								//BUSA Can be other function
		4'b0111:  begin
					 CC_ALU_data_OutBus = ~CC_ALU_dataA_InBus | ~CC_ALU_dataB_InBus;//NOR    (***)
					 CC_ALU_General_SetCode = 1'b0;
					 end
		4'b1000:  begin
					 CC_ALU_data_OutBus = CC_ALU_dataA_InBus + CC_ALU_dataB_InBus;	//ADD	    (***)
					 CC_ALU_General_SetCode = 1'b0;
					 end
		4'b1001:  CC_ALU_data_OutBus = CC_ALU_dataA_InBus - CC_ALU_dataB_InBus;	//SUB
		4'b1010:  begin
					 CC_ALU_data_OutBus = {CC_ALU_dataA_InBus[21:0],10'b0000000000};//LSHIFT10 (***)
					 CC_ALU_General_SetCode = 1'b0;
					 end
		4'b1011:  CC_ALU_data_OutBus = CC_ALU_dataA_InBus - 1'b1;					//DECREMENT A
		4'b1100:  begin
					 CC_ALU_data_OutBus = (CC_ALU_dataA_InBus[12]==1'b1) ? {19'b1111111111111111111,CC_ALU_dataA_InBus[12:0]} : {19'b0000000000000000000,CC_ALU_dataA_InBus[12:0]}; //SEXT13		(***)
					 CC_ALU_General_SetCode = 1'b0;
					 end
		4'b1101:  begin
					 CC_ALU_data_OutBus = CC_ALU_dataA_InBus + 1'b1;					//INCREMENT A   (***)
					 CC_ALU_General_SetCode = 1'b0;
					 end
		4'b1110:  CC_ALU_data_OutBus = CC_ALU_dataA_InBus;								//BUSA Can be other function
		4'b1111:  begin
					 CC_ALU_data_OutBus = {CC_ALU_dataA_InBus[4:0],CC_ALU_dataA_InBus[31:5]};//RSHIFT5 (***)
					 CC_ALU_General_SetCode = 1'b0;
					 end		
		default :  CC_ALU_data_OutBus = CC_ALU_dataA_InBus; 							// channel 0 is selected
	endcase
end

//=======================================================
//  Outputs
//=======================================================
/*Flags*/
assign {caover,addition0[DATAWIDTH_BUS-2:0]}=CC_ALU_dataA_InBus[DATAWIDTH_BUS-2:0] + CC_ALU_dataB_InBus[DATAWIDTH_BUS-2:0]; 	// Determinación de carry del bit número 7
assign {cout,addition1}= CC_ALU_dataA_InBus[DATAWIDTH_BUS-1] + CC_ALU_dataB_InBus[DATAWIDTH_BUS-1] + caover;						// Determinación de la flag Carry y la suma de busA y busB

assign CC_ALU_SetCode_Out = CC_ALU_General_SetCode;
assign CC_ALU_zero_OutLow=(CC_ALU_data_OutBus==8'b00000000) ? 1'b0 : 1'b1;																		// Determinación de la flag Zero
assign CC_ALU_carry_OutLow = ~cout;	
assign CC_ALU_overflow_OutLow = ~ (caover ^ cout);																										// Determinación de la flag Ov a partir de la flag Carry y el carry del bit 7
assign CC_ALU_negative_OutLow = ~ (CC_ALU_data_OutBus[DATAWIDTH_BUS-1]);	

endmodule


