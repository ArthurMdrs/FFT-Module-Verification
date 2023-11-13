CPP_FILE = fft_cpp

UVMHOME = /Tools/cadence/XCELIUM2303/tools/methodology/UVM/CDNS-1.2
TEST = exhaustive_test
VERBOSITY = UVM_NONE

INCDIRS = -incdir ../fft_16_4_in/sv -incdir ../fft_16_4_out/sv
PKGS = cover_enable_pkg.sv ../fft_16_4_in/sv/fft_16_4_in_pkg.sv ../fft_16_4_out/sv/fft_16_4_out_pkg.sv
IFS = ../fft_16_4_in/sv/fft_16_4_in_if.sv ../fft_16_4_out/sv/fft_16_4_out_if.sv
RTL = ../rtl/*.sv
TOP = top.sv

SEED = random

run: all

all:
	g++ -g -fPIC -Wall -std=c++0x $(CPP_FILE).cpp -shared -o $(CPP_FILE).so
	xrun -sv_lib $(CPP_FILE).so -64bit -sv \
		-timescale 1ns/1ns -access +rwc +SVSEED=$(SEED) \
		-coverage all -covoverwrite -covtest $(TEST) \
		-uvmhome $(UVMHOME) +UVM_VERBOSITY=$(VERBOSITY) +UVM_NO_RELNOTES +UVM_TESTNAME=$(TEST) \
		$(INCDIRS) $(PKGS) $(IFS) $(RTL) $(TOP) \
		-dpi -dpiheader dpi_header.txt -dpiimpheader dpi_imp_header.txt 
	
waves: 
	simvision waves.shm	

simulate: all 

clean:
	rm -rf xcelium.d INCA_libs xrun.* *.shm *.dsn *.trn *.ucm ncvlog_*.err imc.key .simvision *.log *.diag *.so
	rm -r  mapped* rc* fv libscore_work script