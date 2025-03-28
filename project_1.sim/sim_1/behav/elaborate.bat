@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto bd2aa3789f9e40d3bbcb1e6e3598d820 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L xpm -L xbip_utils_v3_0_6 -L axi_utils_v2_0_2 -L fir_compiler_v7_2_6 -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_EQ_HPF_behav xil_defaultlib.tb_EQ_HPF xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
