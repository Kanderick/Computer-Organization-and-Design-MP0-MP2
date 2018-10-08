onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp2_tb/clk
add wave -noupdate /mp2_tb/dut/cpu/mem_resp
add wave -noupdate /mp2_tb/dut/cpu/mem_rdata
add wave -noupdate /mp2_tb/dut/cpu/mem_read
add wave -noupdate /mp2_tb/dut/cpu/mem_write
add wave -noupdate /mp2_tb/dut/cpu/mem_byte_enable
add wave -noupdate /mp2_tb/dut/cpu/mem_address
add wave -noupdate /mp2_tb/dut/cpu/mem_wdata
add wave -noupdate /mp2_tb/pmem_resp
add wave -noupdate /mp2_tb/pmem_read
add wave -noupdate /mp2_tb/pmem_write
add wave -noupdate /mp2_tb/pmem_address
add wave -noupdate /mp2_tb/pmem_wdata
add wave -noupdate /mp2_tb/pmem_rdata
add wave -noupdate /mp2_tb/write_data
add wave -noupdate /mp2_tb/write_address
add wave -noupdate /mp2_tb/write
add wave -noupdate /mp2_tb/halt
add wave -noupdate /mp2_tb/dut/cpu/control/state
add wave -noupdate /mp2_tb/dut/cache/control/state
add wave -noupdate /mp2_tb/dut/cache/datapath/set
add wave -noupdate /mp2_tb/dut/cache/datapath/hit
add wave -noupdate /mp2_tb/dut/cache/datapath/dirty
add wave -noupdate /mp2_tb/dut/cpu/datapath/regfile/data
add wave -noupdate /mp2_tb/dut/cache/datapath/data_array0/data
add wave -noupdate /mp2_tb/dut/cache/datapath/data_array1/data
add wave -noupdate /mp2_tb/dut/cache/datapath/lru_array/data
add wave -noupdate /mp2_tb/dut/cache/datapath/dirty_array0/data
add wave -noupdate /mp2_tb/dut/cache/datapath/dirty_array1/data
add wave -noupdate /mp2_tb/dut/cache/datapath/valid_array0/data
add wave -noupdate /mp2_tb/dut/cache/datapath/valid_array1/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1388149 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 358
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
WaveRestoreZoom {1313447 ps} {1404090 ps}
