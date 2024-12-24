-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xbip_utils_v3_0_6 \
  "../../../ipstatic/xbip_utils_v3_0_6/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/axi_utils_v2_0_2 \
  "../../../ipstatic/axi_utils_v2_0_2/hdl/axi_utils_v2_0_vh_rfs.vhd" \
-endlib
-makelib ies/fir_compiler_v7_2_6 \
  "../../../ipstatic/fir_compiler_v7_2_6/hdl/fir_compiler_v7_2_vh_rfs.vhd" \
  "../../../ipstatic/fir_compiler_v7_2_6/hdl/fir_compiler_v7_2.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/sim/Xfir_HPF_128t_b16_Z700.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

