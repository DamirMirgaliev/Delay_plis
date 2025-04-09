-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Mon Mar 31 22:47:10 2025
-- Host        : DESKTOP-UIUARBH running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/Xfir_HPF_128t_b16_Z700_stub.vhdl
-- Design      : Xfir_HPF_128t_b16_Z700
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Xfir_HPF_128t_b16_Z700 is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_data_tvalid : in STD_LOGIC;
    s_axis_data_tready : out STD_LOGIC;
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_data_tvalid : out STD_LOGIC;
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 47 downto 0 )
  );

end Xfir_HPF_128t_b16_Z700;

architecture stub of Xfir_HPF_128t_b16_Z700 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tdata[23:0],m_axis_data_tvalid,m_axis_data_tdata[47:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fir_compiler_v7_2_6,Vivado 2016.2";
begin
end;
