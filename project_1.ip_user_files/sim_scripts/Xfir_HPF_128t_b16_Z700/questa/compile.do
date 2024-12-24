vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/xbip_utils_v3_0_6
vlib msim/axi_utils_v2_0_2
vlib msim/fir_compiler_v7_2_6

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap xbip_utils_v3_0_6 msim/xbip_utils_v3_0_6
vmap axi_utils_v2_0_2 msim/axi_utils_v2_0_2
vmap fir_compiler_v7_2_6 msim/fir_compiler_v7_2_6

vlog -work xil_defaultlib -64 -sv \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_6 -64 \
"../../../ipstatic/xbip_utils_v3_0_6/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work axi_utils_v2_0_2 -64 \
"../../../ipstatic/axi_utils_v2_0_2/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work fir_compiler_v7_2_6 -64 \
"../../../ipstatic/fir_compiler_v7_2_6/hdl/fir_compiler_v7_2_vh_rfs.vhd" \
"../../../ipstatic/fir_compiler_v7_2_6/hdl/fir_compiler_v7_2.vhd" \

vcom -work xil_defaultlib -64 \
"../../../../project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/sim/Xfir_HPF_128t_b16_Z700.vhd" \

vlog -work xil_defaultlib "glbl.v"

