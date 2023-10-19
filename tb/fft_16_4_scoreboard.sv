class fft_16_4_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(fft_16_4_scoreboard)

    uvm_tlm_analysis_fifo #(fft_16_4_out_packet) dut_fifo;
    
    // `uvm_analysis_imp_decl(_refmod)
    // uvm_analysis_imp_refmod #(fft_16_4_out_packet, fft_16_4_scoreboard) refmod_out_imp;
    `uvm_blocking_put_imp_decl(_refmod)
    uvm_blocking_put_imp_refmod #(fft_16_4_out_packet, fft_16_4_scoreboard) refmod_out_imp;

    int no_matches, no_mismatches, no_total;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        dut_fifo = new("dut_fifo" , this);
        refmod_out_imp = new("refmod_out_imp" , this);
    endfunction : new

    task put_refmod (fft_16_4_out_packet refmod_pkt);
        fft_16_4_out_packet dut_pkt;
        dut_fifo.get_peek_export.get(dut_pkt);
        `uvm_info("SCOREBOARD", $sformatf("Packet from refmod:\n%s", refmod_pkt.convert2string()), UVM_NONE)
        `uvm_info("SCOREBOARD", $sformatf("Packet from DUT:\n%s", dut_pkt.convert2string()), UVM_NONE)
        no_total++;
    endtask : write_refmod

    function bit compare (fft_16_4_out_packet refmod_pkt, fft_16_4_out_packet dut_pkt, uvm_comparer comparer = null);
    endfunction : compare

    function void report_phase (uvm_phase phase);
        `uvm_info("SCOREBOARD", $sformatf("Number of packets compared: %0d", no_total), UVM_NONE)
    endfunction : report_phase

endclass : fft_16_4_scoreboard