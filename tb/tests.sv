class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    fft_16_4_tb tb;

    uvm_objection obj;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        
        tb = fft_16_4_tb::type_id::create("tb",this);

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

        // Sequences config - begin
        uvm_config_wrapper::set(this, "tb.agent_fft_16_4_in.sequencer.run_phase", "default_sequence", fft_16_4_in_random_seq::get_type());
        // uvm_config_wrapper::set(this, "tb.agent_fft_16_4_out.sequencer.run_phase", "default_sequence", fft_16_4_out_random_seq::get_type());
        // Sequences config - end
        
    endfunction: build_phase

endclass: random_test

//==============================================================//

class full_cov_test extends base_test;
//COVERAGE MUST BE ENABLED!!
    `uvm_component_utils(full_cov_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Sequences config - begin
        uvm_config_wrapper::set(this, "tb.agent_fft_16_4_in.sequencer.run_phase", "default_sequence", fft_16_4_in_full_cov_seq::get_type());
        // Sequences config - end
        
    endfunction: build_phase

endclass: full_cov_test

//==============================================================//

class corners_test extends base_test;

    `uvm_component_utils(corners_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Sequences config - begin
        uvm_config_wrapper::set(this, "tb.agent_fft_16_4_in.sequencer.run_phase", "default_sequence", fft_16_4_corners_seq::get_type());
        // Sequences config - end
        
    endfunction: build_phase

endclass: corners_test

//==============================================================//

class exhaustive_test extends base_test;

    `uvm_component_utils(exhaustive_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Sequences config - begin
        uvm_config_wrapper::set(this, "tb.agent_fft_16_4_in.sequencer.run_phase", "default_sequence", fft_16_4_exhaustive_seq::get_type());
        // Sequences config - end
        
    endfunction: build_phase

endclass: exhaustive_test

//==============================================================//
