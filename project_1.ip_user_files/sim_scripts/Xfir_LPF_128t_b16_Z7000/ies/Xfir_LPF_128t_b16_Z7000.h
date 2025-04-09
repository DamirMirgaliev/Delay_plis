
//------------------------------------------------------------------------------
// (c) Copyright 2014 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------ 
//
// C Model configuration for the "Xfir_LPF_128t_b16_Z7000" instance.
//
//------------------------------------------------------------------------------
//
// coefficients: 0,0,0,0,0,0,0,0,0,0,1,1,2,3,4,6,7,9,9,9,7,1,-8,-21,-40,-62,-87,-111,-130,-139,-130,-98,-37,56,182,333,499,659,790,861,842,705,428,3,-559,-1229,-1950,-2645,-3218,-3560,-3558,-3110,-2136,-587,1539,4195,7282,10653,14120,17472,20489,22964,24722,25635,25635,24722,22964,20489,17472,14120,10653,7282,4195,1539,-587,-2136,-3110,-3558,-3560,-3218,-2645,-1950,-1229,-559,3,428,705,842,861,790,659,499,333,182,56,-37,-98,-130,-139,-130,-111,-87,-62,-40,-21,-8,1,7,9,9,9,7,6,4,3,2,1,1,0,0,0,0,0,0,0,0,0,0
// chanpats: 173
// name: Xfir_LPF_128t_b16_Z7000
// filter_type: 0
// rate_change: 0
// interp_rate: 1
// decim_rate: 1
// zero_pack_factor: 1
// coeff_padding: 0
// num_coeffs: 128
// coeff_sets: 1
// reloadable: 0
// is_halfband: 0
// quantization: 0
// coeff_width: 24
// coeff_fract_width: 0
// chan_seq: 0
// num_channels: 1
// num_paths: 1
// data_width: 24
// data_fract_width: 0
// output_rounding_mode: 0
// output_width: 43
// output_fract_width: 0
// config_method: 0

const double Xfir_LPF_128t_b16_Z7000_coefficients[128] = {0,0,0,0,0,0,0,0,0,0,1,1,2,3,4,6,7,9,9,9,7,1,-8,-21,-40,-62,-87,-111,-130,-139,-130,-98,-37,56,182,333,499,659,790,861,842,705,428,3,-559,-1229,-1950,-2645,-3218,-3560,-3558,-3110,-2136,-587,1539,4195,7282,10653,14120,17472,20489,22964,24722,25635,25635,24722,22964,20489,17472,14120,10653,7282,4195,1539,-587,-2136,-3110,-3558,-3560,-3218,-2645,-1950,-1229,-559,3,428,705,842,861,790,659,499,333,182,56,-37,-98,-130,-139,-130,-111,-87,-62,-40,-21,-8,1,7,9,9,9,7,6,4,3,2,1,1,0,0,0,0,0,0,0,0,0,0};

const xip_fir_v7_2_pattern Xfir_LPF_128t_b16_Z7000_chanpats[1] = {P_BASIC};

static xip_fir_v7_2_config gen_Xfir_LPF_128t_b16_Z7000_config() {
  xip_fir_v7_2_config config;
  config.name                = "Xfir_LPF_128t_b16_Z7000";
  config.filter_type         = 0;
  config.rate_change         = XIP_FIR_INTEGER_RATE;
  config.interp_rate         = 1;
  config.decim_rate          = 1;
  config.zero_pack_factor    = 1;
  config.coeff               = &Xfir_LPF_128t_b16_Z7000_coefficients[0];
  config.coeff_padding       = 0;
  config.num_coeffs          = 128;
  config.coeff_sets          = 1;
  config.reloadable          = 0;
  config.is_halfband         = 0;
  config.quantization        = XIP_FIR_INTEGER_COEFF;
  config.coeff_width         = 24;
  config.coeff_fract_width   = 0;
  config.chan_seq            = XIP_FIR_BASIC_CHAN_SEQ;
  config.num_channels        = 1;
  config.init_pattern        = Xfir_LPF_128t_b16_Z7000_chanpats[0];
  config.num_paths           = 1;
  config.data_width          = 24;
  config.data_fract_width    = 0;
  config.output_rounding_mode= XIP_FIR_FULL_PRECISION;
  config.output_width        = 43;
  config.output_fract_width  = 0,
  config.config_method       = XIP_FIR_CONFIG_SINGLE;
  return config;
}

const xip_fir_v7_2_config Xfir_LPF_128t_b16_Z7000_config = gen_Xfir_LPF_128t_b16_Z7000_config();

