class fft_16_4_out_sequencer extends uvm_sequencer#(fft_16_4_out_packet);

    `uvm_component_utils(fft_16_4_out_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

endclass: fft_16_4_out_sequencer
