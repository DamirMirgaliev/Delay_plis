-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/axis_infrastructure_v1_1_0 \
  "../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_mux_enc.v" \
  "../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_aclken_converter.v" \
  "../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_aclken_converter_wrapper.v" \
  "../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_axis2vector.v" \
  "../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_util_vector2axis.v" \
  "../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_clock_synchronizer.v" \
  "../../../ipstatic/axis_infrastructure_v1_1_0/hdl/verilog/axis_infrastructure_v1_1_cdc_handshake.v" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1_1/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1_1/hdl/fifo_generator_v13_1_rfs.vhd" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1_1/hdl/fifo_generator_v13_1_rfs.v" \
-endlib
-makelib ies/axis_data_fifo_v1_1_10 \
  "../../../ipstatic/axis_data_fifo_v1_1_10/hdl/verilog/axis_data_fifo_v1_1_axis_data_fifo.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/axis_data_fifo_0/sim/axis_data_fifo_0.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

