# open/reset the project
open_project cpu -reset

# top function of the design is "cpu"
set_top cpu

# add design and testbench files
add_files main.v
add_files -tb tb.v

open_solution solution
set_part xc7a12tcpg238-3
config_rtl -reset state
csim_design
cosim_design
# cysnth_design

report_timing_summary -file reports/timing.txt
report_power -file reports/power.txt
report_utilization -heirarchical -file reports/power.txt

exit
