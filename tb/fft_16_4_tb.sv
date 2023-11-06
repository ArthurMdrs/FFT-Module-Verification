import cover_enable_pkg::*;

class fft_16_4_tb extends uvm_env;

    `uvm_component_utils(fft_16_4_tb)

    // VIPs instances - begin
    fft_16_4_in_agent agent_fft_16_4_in;
    fft_16_4_out_agent agent_fft_16_4_out;
    // VIPs instances - end
    
    uvm_tlm_analysis_fifo #(fft_16_4_in_packet) refmod_fifo;
    fft_16_4_refmod refmod;
    fft_16_4_scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        refmod_fifo = new("refmod_fifo", this);
    endfunction : new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        // Edit to set some agent to passive
        uvm_config_db#(int)::set(this, "agent_fft_16_4_out", "is_active", UVM_PASSIVE);

        // Edit to disable some agent's coverage
        // uvm_config_db#(int)::set(this, "agent_fft_16_4_in", "cov_control", COV_DISABLE);

        // VIPs creation - begin
        agent_fft_16_4_in = fft_16_4_in_agent::type_id::create("agent_fft_16_4_in", this);
        agent_fft_16_4_out = fft_16_4_out_agent::type_id::create("agent_fft_16_4_out", this);
        // VIPs creation - end

        // Reference model creation
        refmod = fft_16_4_refmod::type_id::create("refmod", this);

        // Scoreboard creation
        scoreboard = fft_16_4_scoreboard::type_id::create("scoreboard", this);

        `uvm_info("TB", "Build phase running", UVM_HIGH)
    endfunction : build_phase

    function void connect_phase (uvm_phase phase);
        // Connecting monitor Analysis ports to where they are needed
        agent_fft_16_4_in.item_from_monitor_port.connect(refmod_fifo.analysis_export);
        agent_fft_16_4_out.item_from_monitor_port.connect(scoreboard.dut_fifo.analysis_export);

        // Connecting FIFO to reference model
        refmod.data_in.connect(refmod_fifo.get_peek_export);
        
        // Connecting reference model to scoreboard
        refmod.data_out.connect(scoreboard.refmod_out_imp);
    endfunction : connect_phase

endclass : fft_16_4_tb

