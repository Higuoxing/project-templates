###################################################################
#
#  This TCL script is for setting up axi-huffman-encoder-core
#  Including synthesis, simulation, co-simulation, export-rtl
#  Copyright (c) 2018 Xing GUO
#
###################################################################

# Global settings
set project_name     blank
set device           "your parts"
set clock_period     10
set solution_dir     solution
set top_module       your-top-module

# Open project
open_project $project_name -reset

# add files for synthesis
add_files {
  # your-cpp-file.cpp
}

# set top module
set_top $top_module

# open solution
open_solution $solution_dir -reset

# set device part
set_part $device

# create clock
create_clock -period $clock_period

# C-simulation
# csim_design -compiler clang

# C-synthesis
csynth_design

# export_design 
# [Options]
#  -description  <string> 
#  -flow         <syn|impl> 
#  -format       <sysgen|ip_catalog|syn_dcp>
#  -library      <string>
#  -rtl          <verilog|vhdl>
#  -vendor       <string>
#  -version      <string>
export_design -flow syn -format ip_catalog -rtl verilog -vendor "com.xilinx.hls" -version "0.0.1"

# exit
exit

