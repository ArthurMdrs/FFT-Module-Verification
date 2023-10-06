// xrun options
    -timescale 1ns/1ns
    -access +rwc
    //-gui
    -coverage all
    -covoverwrite
    //+SVSEED=random

// UVM options
    -uvmhome $UVMHOME
    +UVM_VERBOSITY=UVM_LOW
    +UVM_NO_RELNOTES
    +UVM_TESTNAME=random_test

// FFT_16_4_IN UVC
    -incdir ../fft_16_4_in/sv
    ../fft_16_4_in/sv/fft_16_4_in_pkg.sv
    ../fft_16_4_in/sv/fft_16_4_in_if.sv

// FFT_16_4_OUT UVC
    -incdir ../fft_16_4_out/sv
    ../fft_16_4_out/sv/fft_16_4_out_pkg.sv
    ../fft_16_4_out/sv/fft_16_4_out_if.sv

// RTL
    //../rtl/stub.sv

// Top level
    top.sv
