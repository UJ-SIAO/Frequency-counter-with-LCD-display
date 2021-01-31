transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/QuartusCode/Lab2 {D:/QuartusCode/Lab2/Lab2.v}
vlog -vlog01compat -work work +incdir+D:/QuartusCode/Lab2 {D:/QuartusCode/Lab2/init.v}
vlog -vlog01compat -work work +incdir+D:/QuartusCode/Lab2 {D:/QuartusCode/Lab2/WR_Oper.v}
vlog -vlog01compat -work work +incdir+D:/QuartusCode/Lab2 {D:/QuartusCode/Lab2/showHz.v}
vlog -vlog01compat -work work +incdir+D:/QuartusCode/Lab2 {D:/QuartusCode/Lab2/edge_detect.v}
vlog -vlog01compat -work work +incdir+D:/QuartusCode/Lab2 {D:/QuartusCode/Lab2/select.v}
vlog -vlog01compat -work work +incdir+D:/QuartusCode/Lab2 {D:/QuartusCode/Lab2/switch.v}

