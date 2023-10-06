package fft_16_4_in_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    typedef uvm_config_db#(virtual interface fft_16_4_in_if) fft_16_4_in_vif_config;
    typedef virtual interface fft_16_4_in_if fft_16_4_in_vif;

    `include "fft_16_4_in_packet.sv"
    `include "fft_16_4_in_sequence_lib.sv"
    `include "fft_16_4_in_monitor.sv"
    `include "fft_16_4_in_sequencer.sv"
    `include "fft_16_4_in_driver.sv"
    `include "fft_16_4_in_coverage.sv"
    `include "fft_16_4_in_agent.sv"

endpackage: fft_16_4_in_pkg
