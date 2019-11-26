# project name
name Planar2
# execution graph
job 1   -post { extract_vars "$wdir" n1_dvs.out 1 }  -o n1_dvs "sde -l n1_dvs.cmd"
job 3 -d "15"  -post { extract_vars "$wdir" n3_des.out 3 }  -o n3_des "sdevice pp3_des.cmd"
job 15 -d "1" -pre { snmesh_prologue $wdir 15 n1_msh.cmd n1_msh.tdr n1_bnd.tdr pp15_msh.bnd } -post { extract_vars "$wdir" n15_msh.out 15 }  -o n15_msh "snmesh  "
job 20   -post { extract_vars "$wdir" n20_dvs.out 20 }  -o n20_dvs "sde -l n20_dvs.cmd"
job 21 -d "20" -pre { snmesh_prologue $wdir 21 n20_msh.cmd n20_msh.tdr n20_bnd.tdr pp21_msh.bnd } -post { extract_vars "$wdir" n21_msh.out 21 }  -o n21_msh "snmesh  "
job 26 -d "21"  -post { extract_vars "$wdir" n26_des.out 26 }  -o n26_des "sdevice pp26_des.cmd"
job 27   -post { extract_vars "$wdir" n27_dvs.out 27 }  -o n27_dvs "sde -l n27_dvs.cmd"
job 28 -d "27" -pre { snmesh_prologue $wdir 28 n27_msh.cmd n27_msh.tdr n27_bnd.tdr pp28_msh.bnd } -post { extract_vars "$wdir" n28_msh.out 28 }  -o n28_msh "snmesh  "
job 33 -d "28"  -post { extract_vars "$wdir" n33_des.out 33 }  -o n33_des "sdevice pp33_des.cmd"
job 56   -post { extract_vars "$wdir" n56_dvs.out 56 }  -o n56_dvs "sde -l n56_dvs.cmd"
job 57 -d "56" -pre { snmesh_prologue $wdir 57 n56_msh.cmd n56_msh.tdr n56_bnd.tdr pp57_msh.bnd } -post { extract_vars "$wdir" n57_msh.out 57 }  -o n57_msh "snmesh  "
job 62 -d "57"  -post { extract_vars "$wdir" n62_des.out 62 }  -o n62_des "sdevice pp62_des.cmd"
check sde_dvs.cmd 1574658070
check sdevice_des.cmd 1574631564
check sdevice.par 1574657871
check global_tooldb 1398175261
check gtree.dat 1574658402
check ./sdevice_Si3N4.par 1398175273
check ./sdevice_Silicon.par 1398175276
# included files
file sdevice.par included ./sdevice_Si3N4.par
file sdevice.par included ./sdevice_Silicon.par
