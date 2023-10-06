class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    // VIPs instances - begin
    fft_16_4_in_agent agent_fft_16_4_in;
    fft_16_4_out_agent agent_fft_16_4_out;
    // VIPs instances - end

    uvm_objection obj;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        // Edit to set some agent to passive
        // uvm_config_db#(int)::set(this, "agent_fft_16_4_out", "is_active", UVM_PASSIVE);

        // Edit to disable some agent's coverage
        // uvm_config_db#(int)::set(this, "some_vip", "cov_control", COV_DISABLE);

        // VIPs creation - begin
        agent_fft_16_4_in = fft_16_4_in_agent::type_id::create("agent_fft_16_4_in", this);
        agent_fft_16_4_out = fft_16_4_out_agent::type_id::create("agent_fft_16_4_out", this);
        // VIPs creation - end

        `uvm_info("BASE TEST", "Build phase running", UVM_HIGH)
        uvm_config_db#(int)::set(this, "*", "recording_detail", 1);
    endfunction

    function void end_of_elaboration_phase (uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction

    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        check_config_usage();
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        obj = phase.get_objection();
        obj.set_drain_time(this, 200ns);
    endtask: run_phase

endclass: base_test

//==============================================================//

class random_test extends base_test;

    `uvm_component_utils(random_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        // Override packet types, eg:
        //      first_type_name::type_id::set_type_override(second_type_name::get_type());
        super.build_phase(phase);

        // Random sequences config - begin
        uvm_config_wrapper::set(this, "agent_fft_16_4_in.sequencer.run_phase", "default_sequence", fft_16_4_in_random_seq::get_type());
        uvm_config_wrapper::set(this, "agent_fft_16_4_out.sequencer.run_phase", "default_sequence", fft_16_4_out_random_seq::get_type());
        // Random sequences config - end
        
    endfunction: build_phase

endclass: random_test

//==============================================================//
