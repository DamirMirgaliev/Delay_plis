proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/User/Documents/project_1/project_1.cache/wt [current_project]
  set_property parent.project_path C:/Users/User/Documents/project_1/project_1.xpr [current_project]
  set_property ip_repo_paths c:/Users/User/Documents/project_1/project_1.cache/ip [current_project]
  set_property ip_output_repo c:/Users/User/Documents/project_1/project_1.cache/ip [current_project]
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  add_files -quiet C:/Users/User/Documents/project_1/project_1.runs/synth_1/action.dcp
  add_files -quiet c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/axis_data_fifo_0/axis_data_fifo_0.dcp
  set_property netlist_only true [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/axis_data_fifo_0/axis_data_fifo_0.dcp]
  add_files -quiet c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_LPF_128t_b16_Z7000/Xfir_LPF_128t_b16_Z7000.dcp
  set_property netlist_only true [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_LPF_128t_b16_Z7000/Xfir_LPF_128t_b16_Z7000.dcp]
  add_files -quiet c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/Xfir_HPF_128t_b16_Z700.dcp
  set_property netlist_only true [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/Xfir_HPF_128t_b16_Z700.dcp]
  read_xdc -mode out_of_context -ref axis_data_fifo_0 -cells inst c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/axis_data_fifo_0/axis_data_fifo_0_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/axis_data_fifo_0/axis_data_fifo_0_ooc.xdc]
  read_xdc -ref axis_data_fifo_0 -cells inst c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/axis_data_fifo_0/axis_data_fifo_0/axis_data_fifo_0.xdc
  set_property processing_order EARLY [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/axis_data_fifo_0/axis_data_fifo_0/axis_data_fifo_0.xdc]
  read_xdc -mode out_of_context -ref Xfir_LPF_128t_b16_Z7000 -cells U0 c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_LPF_128t_b16_Z7000/Xfir_LPF_128t_b16_Z7000_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_LPF_128t_b16_Z7000/Xfir_LPF_128t_b16_Z7000_ooc.xdc]
  read_xdc -ref Xfir_LPF_128t_b16_Z7000 -cells U0 c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_LPF_128t_b16_Z7000/fir_compiler_v7_2_6/constraints/fir_compiler_v7_2.xdc
  set_property processing_order EARLY [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_LPF_128t_b16_Z7000/fir_compiler_v7_2_6/constraints/fir_compiler_v7_2.xdc]
  read_xdc -mode out_of_context -ref Xfir_HPF_128t_b16_Z700 -cells U0 c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/Xfir_HPF_128t_b16_Z700_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/Xfir_HPF_128t_b16_Z700_ooc.xdc]
  read_xdc -ref Xfir_HPF_128t_b16_Z700 -cells U0 c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/fir_compiler_v7_2_6/constraints/fir_compiler_v7_2.xdc
  set_property processing_order EARLY [get_files c:/Users/User/Documents/project_1/project_1.srcs/sources_1/ip/Xfir_HPF_128t_b16_Z700/fir_compiler_v7_2_6/constraints/fir_compiler_v7_2.xdc]
  read_xdc C:/Users/User/Documents/project_1/project_1.srcs/constrs_1/zed_audio.xdc
  read_xdc C:/Users/User/Documents/project_1/project_1.srcs/constrs_1/new/dbg.xdc
  link_design -top action -part xc7z020clg484-1
  write_hwdef -file action.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force action_opt.dcp
  report_drc -file action_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force action_placed.dcp
  report_io -file action_io_placed.rpt
  report_utilization -file action_utilization_placed.rpt -pb action_utilization_placed.pb
  report_control_sets -verbose -file action_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force action_routed.dcp
  report_drc -file action_drc_routed.rpt -pb action_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file action_timing_summary_routed.rpt -rpx action_timing_summary_routed.rpx
  report_power -file action_power_routed.rpt -pb action_power_summary_routed.pb -rpx action_power_routed.rpx
  report_route_status -file action_route_status.rpt -pb action_route_status.pb
  report_clock_utilization -file action_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

