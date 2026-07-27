
intro:
	@echo "Refer to supplied documentation for reference implementation"
	@echo
	@echo "Make targets are available for:"
	@echo "synthesis, dft, pt"
	@echo
	@echo "Make targets included combining the above: front, all_sdf"
	@echo
PHONY: clean clean_all dist_clean
#####################################
# CLEAN                             #
#####################################
clean clean_all dist_clean:
	@echo "Cleaning implementation build directory ....."
	@/bin/rm -rf work${WORK}/*
	@/bin/rm -rf logs/*
	@/bin/rm -rf data/*
	@/bin/rm -rf reports/*
clean_work:
	@echo "Cleaning work directory ....."
	@/bin/rm -rf work${WORK}/*
#####################################
# VARIABLES                         #
#####################################
SDF ?= yes
scenario ?= S11_max
CORNER ?= max
STAGE ?=
WORK ?=
#####################################
# Define SDF                        #
#####################################
ifeq ($(SDF),yes)
	SDF_STR = set generate_sdf sdf
	SDF_OP = sdf
	SDF_STR_ATPG = -env generate_sdf sdf
else
	SDF_STR = set generate_sdf no_sdf
	SDF_OP = no_sdf
	SDF_STR_ATPG = -env generate_sdf no_sdf
endif
#####################################
# Define CORNER (pt_px only)        #
#####################################
ifeq ($(CORNER),min)
	CORN_OP = set corner min
else
	CORN_OP = set corner max
endif
#####################################
# Synthesis & DFT                   #
#####################################
init:
	@if [ ! -d work ] ; then \
          mkdir work${WORK}; \
        fi
	@if [ ! -d logs ] ; then \
          mkdir logs; \
        fi
synthesis:
	cd work${WORK}; (time dc_shell -topo -64bit -x "${SDF_STR};" -f ../scripts/Nanochap_imp_syn.tcl | tee ../logs/synthesis_${SDF_OP}${WORK}.log)
dft: #dependency is: synthesis
	cd work${WORK}; (time dc_shell -topo -64bit -x "${SDF_STR};" -f ../scripts/Nanochap_imp_dft.tcl | tee ../logs/dft_${SDF_OP}${WORK}.log)
	@for f in data/synthesis_postscan_${SDF_OP}/Nanochap_BAF4P1.postscan.scre_*.sdc ; do \
		[ -e "$$f" ] || continue ; \
		grep -v set_operating_conditions $$f | grep -v set_wire_load_model > $$f.tmp && mv $$f.tmp $$f ; \
	done
#####################################
# ECO                               #
#####################################
syn_eco: #dependency is: pt_eco_master
	cd work${WORK}; (time dc_shell -x "${SDF_STR};" -f ../scripts/Nanochap_imp_eco.tcl | tee ../logs/syn_eco_${SDF_OP}${WORK}.log)
syn_eco_pg: #dependency is: syn_eco
	cd work${WORK}; (time dc_shell -x "${SDF_STR};" -f ../scripts/Nanochap_imp_pg.tcl | tee ../logs/syn_eco_pg_${SDF_OP}${WORK}.log)
#####################################
# LOGICAL EQUIVALENCE               #
#####################################
lec_synthesis: #dependency is: synthesis
	cd work${WORK}; (time fm_shell -64bit -x "set stage prescan; ${SDF_STR};" -overwrite -name_suffix "Nanochap_BAF4P1.synthesis" -f ../scripts/Nanochap_imp_fm.tcl | tee ../logs/lec_synthesis_${SDF_OP}${WORK}.log)
	cd work${WORK}; mv formality_Nanochap_BAF4P1.synthesis.log ../reports/lec_prescan_${SDF_OP}/formality_Nanochap_BAF4P1.synthesis.log
lec_dft: #dependency is: dft
	cd work${WORK}; (time fm_shell -64bit -x "set stage postscan; ${SDF_STR};" -overwrite -name_suffix "Nanochap_BAF4P1.dft" -f ../scripts/Nanochap_imp_fm.tcl | tee ../logs/lec_dft_${SDF_OP}${WORK}.log)
	cd work${WORK}; mv formality_Nanochap_BAF4P1.dft.log ../reports/lec_postscan_${SDF_OP}/formality_Nanochap_BAF4P1.dft.log
lec_postlayout: #dependency is: dft
	cd work${WORK}; (time fm_shell -64bit -x "set stage postlayout; ${SDF_STR};" -overwrite -name_suffix "Nanochap_BAF4P1.postlayout" -f ../scripts/Nanochap_imp_fm.tcl | tee ../logs/lec_postlayout_${SDF_OP}${WORK}.log)
	cd work${WORK}; mv formality_Nanochap_BAF4P1.postlayout.log ../reports/lec_postscan_${SDF_OP}/formality_Nanochap_BAF4P1.postlayout.log
#####################################
# STA (multi-scenario DMSA)         #
#####################################
#scenario SXY => X: 1=Normal Mode, 2=CP test Mode, 3=Bist Mode, 4=Scan Mode. Y: 1=Internal Clock, 2=External Clock (no CPHA for BAF4)
scenarios = S11_min S12_min S22_min S3_min S11_max S12_max S22_max S3_max S4_min S4_max
pt_dft_eco: #dependency is: dft (SDF=yes). Builds one PT session per scenario (no fix)
	cd work${WORK}; (time pt_shell -x "set stage postscan; set scenario ${scenario};" -f ../scripts/Nanochap_imp_pt_eco.tcl | tee ../logs/pt_dft_eco_${scenario}${WORK}.log)
pt_eco_master: #dependency is: pt_dft_eco (all scenarios). DMSA: fix all scenarios at once
	cd work${WORK}; (time pt_shell -multi -f ../scripts/Nanochap_imp_pt_eco_master.tcl | tee ../logs/pt_eco_master_${SDF_OP}${WORK}.log)
pt_posteco: #dependency is: syn_eco. Per-scenario sign-off on post-ECO netlist
	cd work${WORK}; (time pt_shell -x "set scenario ${scenario};" -f ../scripts/Nanochap_imp_pt.tcl | tee ../logs/pt_posteco_${scenario}${WORK}.log)
pt_px_max: #dependency is: dft
	cd work${WORK}; (time pt_shell -x "set stage postscan; set corner max; set generate_sdf no_sdf; set mode functional;" -f ../scripts/Nanochap_imp_pt_px.tcl | tee ../logs/pt_px_max${WORK}.log)
pt_px_min: #dependency is: dft
	cd work${WORK}; (time pt_shell -x "set stage postscan; set corner min; set generate_sdf no_sdf; set mode functional;" -f ../scripts/Nanochap_imp_pt_px.tcl | tee ../logs/pt_px_min${WORK}.log)
#####################################
# ATPG                              #
#####################################
atpg_gen:
	cd work${WORK}; tmax -shell -64 -env stage postscan ${SDF_STR_ATPG} -tcl ../scripts/Nanochap_imp_tmax.tcl | tee -i ../logs/Nanochap_imp_tmax${WORK}.log;
atpg_gen_sdf:
	cd work${WORK}; tmax -shell -64 -env stage postscan_pteco ${SDF_STR_ATPG} -tcl ../scripts/Nanochap_imp_tmax.tcl | tee -i ../logs/Nanochap_imp_tmax_pteco${WORK}.log;
atpg_internal:
	cd work${WORK}; tmax -shell -64 -env stage postscan -tcl ../scripts/Nanochap_imp_tmax_internal.tcl | tee -i ../logs/Nanochap_imp_tmax${WORK}.log;
#####################################
# COMBINED TARGETS                  #
#####################################
front: synthesis dft
lec: lec_synthesis lec_dft
# Full STA/ECO flow end-to-end (run after: make front SDF=yes)
pt:
	#@for scen in $(scenarios); do \
	#	make pt_dft_eco scenario=$$scen; \
	#done
	#make pt_eco_master
	#make syn_eco
	@for scen in $(scenarios); do \
		make pt_posteco scenario=$$scen; \
	done
	#make syn_eco_pg
all:
	make front lec atpg_gen SDF=no
all_sdf:
	make front SDF=yes
	make pt SDF=yes
	make lec SDF=yes
