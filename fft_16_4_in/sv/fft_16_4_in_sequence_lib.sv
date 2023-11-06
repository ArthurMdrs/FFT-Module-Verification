class fft_16_4_in_base_sequence extends uvm_sequence#(fft_16_4_in_packet);

    `uvm_object_utils(fft_16_4_in_base_sequence)
    `uvm_declare_p_sequencer(fft_16_4_in_sequencer)

    function new(string name="fft_16_4_in_base_sequence");
        super.new(name);
    endfunction : new

    task pre_body();
        uvm_phase phase = get_starting_phase();
        phase.raise_objection(this, get_type_name());
        `uvm_info("fft_16_4_in Sequence", "phase.raise_objection", UVM_HIGH)
    endtask : pre_body

    task post_body();
        uvm_phase phase = get_starting_phase();
        phase.drop_objection(this, get_type_name());
        `uvm_info("fft_16_4_in Sequence", "phase.drop_objection", UVM_HIGH)
    endtask : post_body

endclass : fft_16_4_in_base_sequence

//==============================================================//

class fft_16_4_in_random_seq extends fft_16_4_in_base_sequence;

    `uvm_object_utils(fft_16_4_in_random_seq)

    function new(string name="fft_16_4_in_random_seq");
        super.new(name);
    endfunction : new
    
    virtual task body();
        repeat(4*100) begin
            `uvm_create(req)
                void'(req.randomize());
                // It is possible to put constraints into randomize, like below.
                // void'(req.randomize() with {field_1==value_1; field_2==value_2;});
            `uvm_send(req)
        end
    endtask : body

endclass : fft_16_4_in_random_seq

//==============================================================//

class fft_16_4_in_full_cov_seq extends fft_16_4_in_base_sequence;
//COVERAGE MUST BE ENABLED!!
    `uvm_object_utils(fft_16_4_in_full_cov_seq)

    function new(string name="fft_16_4_in_full_cov_seq");
        super.new(name);
    endfunction : new
    
    virtual task body();        
        while(p_sequencer.coverage_value < 100) begin
            repeat (4) begin
                `uvm_create(req)
                    void'(req.randomize());
                `uvm_send(req)
            end

            p_sequencer.from_cov_get_port.get(p_sequencer.coverage_value);
        end
    endtask : body

endclass : fft_16_4_in_full_cov_seq

//==============================================================//
