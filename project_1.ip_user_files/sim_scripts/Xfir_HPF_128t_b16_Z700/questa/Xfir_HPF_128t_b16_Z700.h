
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
// C Model configuration for the "Xfir_HPF_128t_b16_Z700" instance.
//
//------------------------------------------------------------------------------
//
// coefficients: -840,203,327,327,208,27,-137,-213,-172,-38,122,229,227,107,-82,-258,-335,-264,-57,217,454,558,480,238,-85,-376,-529,-493,-287,9,282,435,420,258,26,-178,-278,-249,-126,12,82,36,-113,-291,-398,-351,-127,215,547,721,627,249,-310,-853,-1152,-1033,-453,452,1380,1919,1619,-18,-4057,-19822,19822,4057,18,-1619,-1919,-1380,-452,453,1033,1152,853,310,-249,-627,-721,-547,-215,127,351,398,291,113,-36,-82,-12,126,249,278,178,-26,-258,-420,-435,-282,-9,287,493,529,376,85,-238,-480,-558,-454,-217,57,264,335,258,82,-107,-227,-229,-122,38,172,213,137,-27,-208,-327,-327,-203,840
// chanpats: 173
// name: Xfir_HPF_128t_b16_Z700
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
// coeff_width: 16
// coeff_fract_width: 0
// chan_seq: 0
// num_channels: 1
// num_paths: 1
// data_width: 16
// data_fract_width: 0
// output_rounding_mode: 0
// output_width: 33
// output_fract_width: 0
// config_method: 0

const double Xfir_HPF_128t_b16_Z700_coefficients[128] = {-840,203,327,327,208,27,-137,-213,-172,-38,122,229,227,107,-82,-258,-335,-264,-57,217,454,558,480,238,-85,-376,-529,-493,-287,9,282,435,420,258,26,-178,-278,-249,-126,12,82,36,-113,-291,-398,-351,-127,215,547,721,627,249,-310,-853,-1152,-1033,-453,452,1380,1919,1619,-18,-4057,-19822,19822,4057,18,-1619,-1919,-1380,-452,453,1033,1152,853,310,-249,-627,-721,-547,-215,127,351,398,291,113,-36,-82,-12,126,249,278,178,-26,-258,-420,-435,-282,-9,287,493,529,376,85,-238,-480,-558,-454,-217,57,264,335,258,82,-107,-227,-229,-122,38,172,213,137,-27,-208,-327,-327,-203,840};

const xip_fir_v7_2_pattern Xfir_HPF_128t_b16_Z700_chanpats[1] = {P_BASIC};

static xip_fir_v7_2_config gen_Xfir_HPF_128t_b16_Z700_config() {
  xip_fir_v7_2_config config;
  config.name                = "Xfir_HPF_128t_b16_Z700";
  config.filter_type         = 0;
  config.rate_change         = XIP_FIR_INTEGER_RATE;
  config.interp_rate         = 1;
  config.decim_rate          = 1;
  config.zero_pack_factor    = 1;
  config.coeff               = &Xfir_HPF_128t_b16_Z700_coefficients[0];
  config.coeff_padding       = 0;
  config.num_coeffs          = 128;
  config.coeff_sets          = 1;
  config.reloadable          = 0;
  config.is_halfband         = 0;
  config.quantization        = XIP_FIR_INTEGER_COEFF;
  config.coeff_width         = 16;
  config.coeff_fract_width   = 0;
  config.chan_seq            = XIP_FIR_BASIC_CHAN_SEQ;
  config.num_channels        = 1;
  config.init_pattern        = Xfir_HPF_128t_b16_Z700_chanpats[0];
  config.num_paths           = 1;
  config.data_width          = 16;
  config.data_fract_width    = 0;
  config.output_rounding_mode= XIP_FIR_FULL_PRECISION;
  config.output_width        = 33;
  config.output_fract_width  = 0,
  config.config_method       = XIP_FIR_CONFIG_SINGLE;
  return config;
}

const xip_fir_v7_2_config Xfir_HPF_128t_b16_Z700_config = gen_Xfir_HPF_128t_b16_Z700_config();

