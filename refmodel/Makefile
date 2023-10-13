RTL = ./test_DPI.sv 

run: all

all:
	g++ -g -fPIC -Wall -std=c++0x cpp_function.cpp -shared -o test.so
	xrun $(RTL) -sv_lib test.so -access +rwc -64bit -sv -timescale 1ns/1ps -dpi -dpiheader \
		dpi_header.txt -dpiimpheader dpi_imp_header.txt 
	
waves: 
	simvision waves.shm	

simulate: all 

clean:
	rm -rf xcelium.d INCA_libs xrun.* *.shm *.dsn *.trn *.ucm ncvlog_*.err imc.key .simvision *.log *.diag *.so
	rm -r  mapped* rc* fv libscore_work script