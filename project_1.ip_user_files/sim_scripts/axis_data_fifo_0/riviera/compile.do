vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/axis_infrastructure_v1_1_0
vlib riviera/fifo_generator_v13_1_1
vlib riviera/axis_data_fifo_v1_1_10

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap axis_infrastructure_v1_1_0 riviera/axis_infrastructure_v1_1_0
vmap fifo_generator_v13_1_1 riviera/fifo_generator_v13_1_1
vmap axis_data_fifo_v1_1_10 riviera/axis_data_fifo_v1_1_10

vlog -work xil_defaultlib -v2k5 -sv "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axis_infrastructure_v1_1_0 -v2k5 "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_mux_enc.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_aclken_converter.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_aclken_converter_wrapper.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_axis2vector.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_vector2axis.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_clock_synchronizer.v" \
"../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_cdc_handshake.v" \

vlog -work fifo_generator_v13_1_1 -v2k5 "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../ipstatic/fifo_generator_v13_1_1/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_1 -93 \
"../../../ipstatic/fifo_generator_v13_1_1/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_1 -v2k5 "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../ipstatic/fifo_generator_v13_1_1/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work axis_data_fifo_v1_1_10 -v2k5 "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../ipstatic/axis_data_fifo_v1_1_10/hdl/verilog/axis_data_fifo_v1_1_axis_data_fifo.v" \

vlog -work xil_defaultlib -v2k5 "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" "+incdir+../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog" \
"../../../../project_1.srcs/sources_1/ip/axis_data_fifo_0/sim/axis_data_fifo_0.v" \

vlog -work xil_defaultlib "glbl.v"

