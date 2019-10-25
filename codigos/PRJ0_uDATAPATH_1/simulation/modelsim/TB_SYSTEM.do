onerror {resume}
quietly WaveActivateNextPane {} 0
delete wave *
add wave -noupdate /TB_SYSTEM/eachvec

add wave  -divider DATAPATH
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_CLOCK_50

add wave  -divider REGISTERS
add wave  -noupdate -radix decimal /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/SC_RegGENERAL_PC/SC_RegGENERAL_data_OutBus
add wave  -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/SC_RegGENERAL_IR_u0/SC_RegGENERAL_IR_data_OutBus
add wave  -noupdate -radix decimal /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/SC_RegGENERAL_R5/SC_RegGENERAL_data_OutBus 
add wave  -noupdate -radix decimal /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/SC_RegGENERAL_R6/SC_RegGENERAL_data_OutBus 
add wave  -noupdate -radix decimal /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/SC_RegGENERAL_Out/SC_RegGENERAL_data_OutBus 
add wave  -noupdate -radix decimal	 /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/SC_RegGENERAL_R8/SC_RegGENERAL_data_OutBus 
add wave  -noupdate -radix decimal /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/SC_RegGENERAL_R9/SC_RegGENERAL_data_OutBus 
add wave  -noupdate -radix decimal /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/SC_RegGENERAL_R10/SC_RegGENERAL_data_OutBus 

add wave  -divider CSADDRESS
add wave -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/CONTROL_u0/CSADDRESS_u0/CSADDRESS_CSAddress_OutBus
add wave -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/CONTROL_u0/CSADDRESS_u0/CSADDRESS_DecodeOp_InBus

add wave  -divider ALU
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/CC_ALU_u0/CC_ALU_dataA_InBus
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/CC_ALU_u0/CC_ALU_dataB_InBus
add wave -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/CC_ALU_u0/CC_ALU_data_OutBus
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/CC_ALU_u0/CC_ALU_selection_InBus

add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/CC_ALU_u0/CC_ALU_zero_OutLow

add wave  -divider CONTROL
add wave -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/CONTROL_u0/CONTROL_ALUOperation_OutBus
 
add wave  -divider BRANCH_LOGIC
add wave -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/CONTROL_u0/BRANCH_LOGIC_u0/BRANCH_LOGIC_Tipo_OutBus

add wave  -divider MAIN_MEMORY
add wave -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/MAIN_MEMORY_u0/MAIN_MEMORY_Data_OutBus

add wave  -divider MICROCODE_STORE
add wave -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/CONTROL_u0/MICROCODE_STORE_u0/MICROCODE_STORE_Condition_OutBus
add wave -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/CONTROL_u0/MICROCODE_STORE_u0/MICROCODE_STORE_RD_Out
add wave -noupdate -radix binary /TB_SYSTEM/BB_SYSTEM_u0/CONTROL_u0/MICROCODE_STORE_u0/MICROCODE_STORE_CSAddress_InBus

add wave  -divider DATAPATH
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_RESET_InHigh
add wave  -radix binary /TB_SYSTEM/TB_SYSTEM_Data_OutBus

add wave  -divider MUX
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/CC_MUXX_EXTERNO_CMUX/CC_MUXX_EXTERNO_data_OutBus
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/DATAPATH_u0/CC_MUXX_LOAD_CBUSMUX/CC_MUXX_LOAD_data_OutBus

restart
run 1ms

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {319999492 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 445
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {59829352 ps} {60892417 ps}
