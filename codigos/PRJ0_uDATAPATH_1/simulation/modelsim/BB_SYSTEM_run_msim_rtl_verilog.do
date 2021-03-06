transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/SC_RegGENERAL.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/SC_RegFIXED.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/CC_MUXX.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/CC_ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1 {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/BB_SYSTEM.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/CONTROL.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/MAIN_MEMORY.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/DATAPATH.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/MICROCODE_STORE.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/BRANCH_LOGIC.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/ADDRESS_INCREMENTER.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/CSADDRESS.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/PSR.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/CC_MUXX_LOAD.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/CC_MUXX_EXTERNO.v}
vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/rtl/SC_RegGENERAL_IR.v}

vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/simulation/modelsim {C:/Users/INTEL/Desktop/Proyecto1Arqui-IELE3222-/codigos/PRJ0_uDATAPATH_1/simulation/modelsim/TB_SYSTEM.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_SYSTEM

add wave *
view structure
view signals
run -all
