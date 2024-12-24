vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/xbip_utils_v3_0_6
vlib activehdl/axi_utils_v2_0_2
vlib activehdl/fir_compiler_v7_2_6

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap xbip_utils_v3_0_6 activehdl/xbip_utils_v3_0_6
vmap axi_utils_v2_0_2 activehdl/axi_utils_v2_0_2
vmap fir_compiler_v7_2_6 activehdl/fir_compiler_v7_2_6

vlog -work xil_defaultlib -v2k5 -sv \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_6 -93 \
"../../../ipstatic/xbip_utils_v3_0_6/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work axi_utils_v2_0_2 -93 \
"../../../ipstatic/axi_utils_v2_0_2/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work fir_compiler_v7_2_6 -93 \
"../../../ipstatic/fir_compiler_v7_2_6/hdl/fir_compiler_v7_2_vh_rfs.vhd" \
"../../../ipstatic/fir_compiler_v7_2_6/hdl/fir_compiler_v7_2.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/sim/Xfir_HPF_128t_b16_Z700.vhd" \

vlog -work xil_defaultlib "glbl.v"

