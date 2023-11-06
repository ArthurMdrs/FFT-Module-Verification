import cover_enable_pkg::*;

class fft_16_4_in_sequencer extends uvm_sequencer#(fft_16_4_in_packet);
    
    cover_e cov_control = COV_ENABLE;
    real coverage_value;

    `uvm_component_utils_begin(fft_16_4_in_sequencer)
        `uvm_field_enum(cover_e, cov_control, UVM_ALL_ON)
        `uvm_field_real(coverage_value, UVM_ALL_ON)
    `uvm_component_utils_end

    uvm_blocking_get_port #(real) from_cov_get_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        
        if (cov_control == COV_ENABLE) begin
            from_cov_get_port = new ("from_cov_get_port", this);
        end
    endfunction : build_phase

endclass : fft_16_4_in_sequencer
