onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Xfir_HPF_128t_b16_Z700_opt

do {wave.do}

view wave
view structure
view signals

do {Xfir_HPF_128t_b16_Z700.udo}

run -all

quit -force
