// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Mon Mar 31 22:47:40 2025
// Host        : DESKTOP-UIUARBH running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_LPF_128t_b16_Z7000/Xfir_LPF_128t_b16_Z7000_stub.v
// Design      : Xfir_LPF_128t_b16_Z7000
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fir_compiler_v7_2_6,Vivado 2016.2" *)
module Xfir_LPF_128t_b16_Z7000(aclk, s_axis_data_tvalid, s_axis_data_tready, s_axis_data_tdata, m_axis_data_tvalid, m_axis_data_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tdata[23:0],m_axis_data_tvalid,m_axis_data_tdata[47:0]" */;
  input aclk;
  input s_axis_data_tvalid;
  output s_axis_data_tready;
  input [23:0]s_axis_data_tdata;
  output m_axis_data_tvalid;
  output [47:0]m_axis_data_tdata;
endmodule
