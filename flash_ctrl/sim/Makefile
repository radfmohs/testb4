clear:
	rm -rf csrc
	rm -rf DVEfiles/*
	rm -f inter.vpd
	rm -f ucli.key
	rm -f *.fsdb
	rm -f novas.conf
	rm -f novas.rc
	rm -f *.simv
	rm -rf *simv
	rm -rf verdiLog
	rm -rf *.log
	rm -rf DVEfiles/ simv.daidir/ AN.DB/
	rm -rf *.simv.daidir

compile:
	vlogan -f filelist.f -sverilog -full64
	vcs tb_flash_ctrl_top -debug_all +lint=all -full64 -P /eda/digital/verdi/S-2021.09-SP2/share/PLI/VCS/LINUX64/verdi.tab /eda/digital/verdi/S-2021.09-SP2/share/PLI/VCS/LINUX64/pli.a	
dbg:
	./simv -gui
run:
	./simv

cp:
	vcs -f filelist.f -sverilog +lint=all -l 2.log -o flash_ctrl.simv -R -debug_all +v2k +fsdb+sequential +fsdb+glitch=0 +fsdb+region -full64 -l 1.log -P /home/eda/digital/verdi_vM201703/share/PLI/VCS/LINUX64/verdi.tab /home/eda/digital/verdi_vM201703/share/PLI/VCS/LINUX64/pli.a

verdi:
	@verdi -sv -nologo -f filelist.f -ssf flash_ctrl.fsdb
