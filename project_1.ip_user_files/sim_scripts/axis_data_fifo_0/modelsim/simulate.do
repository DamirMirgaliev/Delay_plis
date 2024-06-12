onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L axis_infrastructure_v1_1_0 -L fifo_generator_v13_1_1 -L axis_data_fifo_v1_1_10 -lib xil_defaultlib xil_defaultlib.axis_data_fifo_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {axis_data_fifo_0.udo}

run -all

quit -force
