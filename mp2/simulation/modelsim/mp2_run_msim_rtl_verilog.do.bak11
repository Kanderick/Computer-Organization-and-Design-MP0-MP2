transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/array.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/rv32i_types.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/register.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/regfile.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/pc_reg.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/mux2.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/mux4.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/add4.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/mux8.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/ldconcat.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/cache_control.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/cache_address_decoder.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/tag_comparator.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/tag_load_logic.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/dirty_load_logic.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/valid_load_logic.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/data_load_logic.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/pmem_address_logic.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/data_logic.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/cpu_control.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/ir.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/alu.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/cmp.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/cache_datapath.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/cpu_datapath.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/cache.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/cpu.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/mp2.sv}

vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/mp2_tb.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/mp2 {/home/hxu52/ece411/mp2/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp2_tb

add wave *
view structure
view signals
run 200 ns
