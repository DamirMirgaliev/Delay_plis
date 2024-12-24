onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Xfir_LPF_128t_b16_Z7000_opt

do {wave.do}

view wave
view structure
view signals

do {Xfir_LPF_128t_b16_Z7000.udo}

run -all

quit -force
