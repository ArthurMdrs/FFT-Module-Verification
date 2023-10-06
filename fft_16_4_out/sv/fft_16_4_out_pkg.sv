package fft_16_4_out_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    typedef uvm_config_db#(virtual interface fft_16_4_out_if) fft_16_4_out_vif_config;
    typedef virtual interface fft_16_4_out_if fft_16_4_out_vif;

    `include "fft_16_4_out_packet.sv"
    `include "fft_16_4_out_sequence_lib.sv"
    `include "fft_16_4_out_monitor.sv"
    `include "fft_16_4_out_sequencer.sv"
    `include "fft_16_4_out_driver.sv"
    `include "fft_16_4_out_coverage.sv"
    `include "fft_16_4_out_agent.sv"

endpackage: fft_16_4_out_pkg
