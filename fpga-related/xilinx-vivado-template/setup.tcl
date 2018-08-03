# set properties {
    
    set output_dir ./build
    file mkdir $output_dir
    
    set_part xc7z020clg400-1
# }

# read constraints and source files {
    read_verilog [ glob ./src/rtl/*.v ] # read all the verilog files
    # read_verilog ./src/rtl/top.v      # read single verilog file
    # read_verilog ./src/rtl/top.vhdl   # read single VHDL file

    read_xdc ./src/contrs/project.xdc
# }

# run synthesis {
    synth_design -top top    # Tell vivado your top module name

    # optional commands: checkpoints and reports
    # write_checkpoint -force $output_dir/post_synth
    # report_utilization -file $output_dir/post_synth_util.report
    # report_timing -sort_by group -max_paths 5 -path_type summary \
      -file $output_dir/post_synth/post_synth_timing_report
# }

# run placement and optimization {
    opt_design
    power_opt_design
    place_design
    phys_opt_design

    # optional commands: checkpoints and reports
    # write_checkpoint -force $output_dir/post_place
    # report_clock_utilization -file $output_dir/clock_util.report
    # report_utilization -file $output_dir/post_place_util.report
    # report_timing -sort_by group -max_paths 5 -path_type summary \
    #   -file $output_dir/post_place_timing.report
# }

# run routing {
    route_design

    # optional commands: checkpoints and reports
    # write_checkpoint -force $output_dir/post_route
    # report_timing_summary -file $output_dir/post_route_timing_summary.report
    # report_utilization -file $output_dir/post_route_util.report
    # report_power -file $output_dir/post_route_power.report
    # report_methodology -file $output_dir/post_impl_checks.report
    # report_drc -file $output_dir/post_imp_drc.report

    # optional commands: write optimized, primitive based netlist
    # write_verilog -force $output_dir/netlist.v
# }

# write bit stream {
    write_bitstream $output_dir/top.bit
# }
