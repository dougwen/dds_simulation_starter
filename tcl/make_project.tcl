 
set project_name "lab3a"
create_project ${project_name} ./${project_name} -part xc7z020clg400-1 -force

set proj_dir [get_property directory [current_project]]
set obj [current_project]
 
add_files -fileset sim_1 -norecurse ./src/tb.vhd

# setup IP repository path and a couple other project options 
set_property target_language VHDL [current_project]


########################################################
# Add IP to project, there are a few we want to use here
########################################################


create_ip -name dds_compiler -vendor xilinx.com -library ip -version 6.0 -module_name fakeadc_dds
set_property -dict [ list \
   CONFIG.Amplitude_Mode {Unit_Circle} \
   CONFIG.DATA_Has_TLAST {Not_Required} \
   CONFIG.DDS_Clock_Rate {125} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_Phase_Out {false} \
   CONFIG.Latency {8} \
   CONFIG.M_DATA_Has_TUSER {Not_Required} \
   CONFIG.Noise_Shaping {None} \
   CONFIG.Output_Frequency1 {0} \
   CONFIG.Output_Selection {Sine} \
   CONFIG.Output_Width {16} \
   CONFIG.PINC1 {0} \
   CONFIG.Parameter_Entry {Hardware_Parameters} \
   CONFIG.Phase_Increment {Streaming} \
   CONFIG.Phase_Width {16} \
   CONFIG.S_PHASE_Has_TUSER {Not_Required} \
 ] [get_ips fakeadc_dds]



update_compile_order -fileset sources_1
 
generate_target all [get_files $proj_dir/$project_name.srcs/sources_1/ip/fakeadc_dds/fakeadc_dds.xci]

 
close_project

 
