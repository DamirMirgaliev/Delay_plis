vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/axis_infrastructure_v1_1_0
vlib msim/fifo_generator_v13_1_1
vlib msim/axis_data_fifo_v1_1_10

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap axis_infrastructure_v1_1_0 msim/axis_infrastructure_v1_1_0
vmap fifo_generator_v13_1_1 msim/fifo_generator_v13_1_1
vmap axis_data_fifo_v1_1_10 msim/axis_data_fifo_v1_1_10

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axis_infrastructure_v1_1_0 -64 -incr "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_mux_enc.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_aclken_converter.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_aclken_converter_wrapper.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_axis2vector.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_vector2axis.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_clock_synchronizer.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_cdc_handshake.v" \

vlog -work fifo_generator_v13_1_1 -64 -incr "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../ipstatic/fifo_generator_v13_1_1/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_1 -64 -93 \
"../../../ipstatic/fifo_generator_v13_1_1/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_1 -64 -incr "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../ipstatic/fifo_generator_v13_1_1/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work axis_data_fifo_v1_1_10 -64 -incr "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../ipstatic/axis_data_fifo_v1_1_10/hdl/verilog/axis_data_fifo_v1_1_axis_data_fifo.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../../project_1.srcs/sources_1/ip/axis_data_fifo_0/sim/axis_data_fifo_0.v" \

vlog -work xil_defaultlib "glbl.v"

