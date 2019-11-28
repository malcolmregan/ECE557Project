# project name
name FINFET
# execution graph
job 1   -post { extract_vars "$wdir" n1_dvs.out 1 }  -o n1_dvs "sde -l n1_dvs.cmd"
job 3 -d "8"  -post { extract_vars "$wdir" n3_des.out 3 }  -o n3_des "sdevice pp3_des.cmd"
job 8 -d "1" -pre {  os_ln_rel n1_msh.cmd n8_msh.cmd "$wdir";  catch {os_ln_rel n1_msh.tdr n8_msh.tdr "$wdir"};  catch {os_ln_rel n1_bnd.tdr n8_bnd.tdr "$wdir"};  catch {os_ln_rel n1_msh.bnd n8_msh.bnd "$wdir"} } -post { extract_vars "$wdir" n8_msh.out 8 }  -o n8_msh "mesh n8_msh"
check sde_dvs.cmd 1574793945
check sdevice_des.cmd 1574931100
check sdevice.par 1574792072
check global_tooldb 1398175261
check gtree.dat 1574931334
check ./sdevice_Silicon.par 1574792072
# included files
file sdevice.par included ./sdevice_Silicon.par
