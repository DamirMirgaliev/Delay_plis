onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Xfir_HPF_128t_b16_Z700 -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L xbip_utils_v3_0_6 -L axi_utils_v2_0_2 -L fir_compiler_v7_2_6 -O5 xil_defaultlib.Xfir_HPF_128t_b16_Z700 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {Xfir_HPF_128t_b16_Z700.udo}

run -all

endsim

quit -force