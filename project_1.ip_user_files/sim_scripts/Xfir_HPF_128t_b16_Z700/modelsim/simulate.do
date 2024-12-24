onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L xbip_utils_v3_0_6 -L axi_utils_v2_0_2 -L fir_compiler_v7_2_6 -lib xil_defaultlib xil_defaultlib.Xfir_HPF_128t_b16_Z700 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {Xfir_HPF_128t_b16_Z700.udo}

run -all

quit -force
