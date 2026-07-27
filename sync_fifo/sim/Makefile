SDF=
TESTNAME=
all: clean compile run

clean:
	rm -rf csrc
	rm -rf DVEfiles
	rm -rf simv.daidir
	rm -f inter.vpd
	rm -f ucli.key
	rm -f *.fsdb
	rm -f novas.conf
	rm -f novas.rc
	rm -f *.simv
	rm -rf *simv
	rm -rf verdiLog
	rm -rf AN.DB
	rm -rf *.log
	rm -rf testcase.*
	rm -rf ${TESTNAME}
	rm -rf *_test

compile:
	cp -f ../tc/${TESTNAME}.sv testcase.sv
	vlogan -sverilog -f filelist.f -full64 -override_timescale=1ns/1ps
	vcs fifo_top_tb -debug_all +lint=all +notimingcheck +nospecify -l vcs.log -P /home/eda/digital/verdi_vM201703/share/PLI/VCS/LINUX64/verdi.tab /home/eda/digital/verdi_vM201703/share/PLI/VCS/LINUX64/pli.a -full64 

run:
	mkdir -p ${TESTNAME}
	./simv -l sim.log
	mv -f testcase_000.fsdb fifo_top_tb.fsdb 
	mv sim.log ${TESTNAME}/${TESTNAME}.log
	mv fifo_top_tb.fsdb ${TESTNAME}/${TESTNAME}.fsdb

dbg:
	./simv -l sim.log -gui

verdi: run
	verdi -nologo -ssf ${TESTNAME}/${TESTNAME}.fsdb -f filelist.f

regress:
	./run_regress  
