#!/bin/bash

source ./flists.sh

rm -r obj_dir

printf "Testing component -> $1 <-\n\n"

case $1 in
	"adder")
		sources=("${adder_sources[@]}")
		tb_file_path=${adder_tb_path}
		tb_top_name=$(basename "${adder_tb_path}" .sv)
		;;
	"extend")
		sources=("${extend_sources[@]}")
		tb_file_path=${extend_tb_path}
		tb_top_name=$(basename "${extend_tb_path}" .sv)
		;;
	"flopr")
		sources=("${flopr_sources[@]}")
		tb_file_path=${flopr_tb_path}
		tb_top_name=$(basename "${flopr_tb_path}" .sv)
		;;
	"flopenr")
		sources=("${flopenr_sources[@]}")
		tb_file_path=${flopenr_tb_path}
		tb_top_name=$(basename "${flopenr_tb_path}" .sv)
		;;
	"mux2")
		sources=("${mux2_sources[@]}")
		tb_file_path=${mux2_tb_path}
		tb_top_name=$(basename "${mux2_tb_path}" .sv)
		;;
	"mux3")
		sources=("${mux3_sources[@]}")
		tb_file_path=${mux3_tb_path}
		tb_top_name=$(basename "${mux3_tb_path}" .sv)
		;;
	"regfile")
		sources=("${regfile_sources[@]}")
		tb_file_path=${regfile_tb_path}
		tb_top_name=$(basename "${regfile_tb_path}" .sv)
		;;
	"alu")
		sources=("${alu_sources[@]}")
		tb_file_path=${alu_tb_path}
		tb_top_name=$(basename "${alu_tb_path}" .sv)
		;;
	"datapath")
		sources=("${datapath_sources[@]}")
		tb_file_path=${datapath_tb_path}
		tb_top_name=$(basename "${datapath_tb_path}" .sv)
		;;
	"aludec")
		sources=("${aludec_sources[@]}")
		tb_file_path=${aludec_tb_path}
		tb_top_name=$(basename "${aludec_tb_path}" .sv)
		;;
	"maindec")
		sources=("${maindec_sources[@]}")
		tb_file_path=${maindec_tb_path}
		tb_top_name=$(basename "${maindec_tb_path}" .sv)
		;;
	"controller")
		sources=("${controller_sources[@]}")
		tb_file_path=${controller_tb_path}
		tb_top_name=$(basename "${controller_tb_path}" .sv)
		;;
	"riscvsc")
		sources=("${riscvsc_sources[@]}")
		tb_file_path=${riscvsc_tb_path}
		tb_top_name=$(basename "${riscvsc_tb_path}" .sv)
		;;
	"imem")
		sources=("${imem_sources[@]}")
		tb_file_path=${imem_tb_path}
		tb_top_name=$(basename "${imem_tb_path}" .sv)
		;;
	"dmem")
		sources=("${dmem_sources[@]}")
		tb_file_path=${dmem_tb_path}
		tb_top_name=$(basename "${dmem_tb_path}" .sv)
		;;
	"riscvsc_top")
		sources=("${riscvsc_top_sources[@]}")
		tb_file_path=${riscvsc_top_tb_path}
		tb_top_name=$(basename "${riscvsc_top_tb_path}" .sv)
		;;
	"csr")
		sources=("${csr_sources[@]}")
		tb_file_path=${csr_tb_path}
		tb_top_name=$(basename "${csr_tb_path}" .sv)
		;;
	*)
		echo "Unknown component."
		;;
esac

printf "Sources:"
for source in "${sources[@]}"; do
	printf "\n${source}"
	sources_list+="${source} "
done
printf "\n\n"
printf "Testbench:"
printf "\n${tb_file_path}"
printf "\n\n"

verilator --binary --trace --timescale 1ns/1ps --assert --top-module ${tb_top_name} -I ${sources_list} ${tb_file_path}

cd obj_dir

./V${tb_top_name}

if [ "$2" = "wf" ]; then
	gtkwave dump.vcd &
fi
