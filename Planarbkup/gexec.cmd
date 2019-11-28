# project name
name Planar
# execution graph
job 56   -post { extract_vars "$wdir" n56_dvs.out 56 }  -o n56_dvs "sde -l n56_dvs.cmd"
job 57 -d "56" -pre { snmesh_prologue $wdir 57 n56_msh.cmd n56_msh.tdr n56_bnd.tdr pp57_msh.bnd } -post { extract_vars "$wdir" n57_msh.out 57 }  -o n57_msh "snmesh  "
job 62 -d "57"  -post { extract_vars "$wdir" n62_des.out 62 }  -o n62_des "sdevice pp62_des.cmd"
check sde_dvs.cmd 1574926429
check sdevice_des.cmd 1574792069
check sdevice.par 1574926496
check global_tooldb 1398175261
check gtree.dat 1574926511
check ./sdevice_HfO2.par 1398175272
check ./sdevice_Si3N4.par 1574792071
check ./sdevice_Silicon.par 1398175276
# included files
file sdevice.par included ./sdevice_HfO2.par
file sdevice.par included ./sdevice_Si3N4.par
file sdevice.par included ./sdevice_Silicon.par
