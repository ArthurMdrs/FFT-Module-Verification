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
        `uvm_info("fft_16_4_in Sequence", "Executing random_seq.", UVM_NONE)
        repeat(4*1000) begin
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
        `uvm_info("fft_16_4_in Sequence", "Executing full_cov_seq.", UVM_NONE)
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

class fft_16_4_around_0_seq extends fft_16_4_in_base_sequence;

    `uvm_object_utils(fft_16_4_around_0_seq)

    function new(string name="fft_16_4_around_0_seq");
        super.new(name);
    endfunction : new
    
    virtual task body();
        `uvm_info("fft_16_4_in Sequence", "Executing around_0_seq.", UVM_NONE)
        repeat(4*500) begin
            `uvm_create(req)
                void'(req.randomize() with {
                    i_data_1_real < 10 && i_data_1_real > -10;
                    i_data_1_imag < 10 && i_data_1_imag > -10;
                    i_data_2_real < 10 && i_data_2_real > -10;
                    i_data_2_imag < 10 && i_data_2_imag > -10;
                    i_data_3_real < 10 && i_data_3_real > -10;
                    i_data_3_imag < 10 && i_data_3_imag > -10;
                    i_data_4_real < 10 && i_data_4_real > -10;
                    i_data_4_imag < 10 && i_data_4_imag > -10;
                });
            `uvm_send(req)
        end
    endtask : body

endclass : fft_16_4_around_0_seq

//==============================================================//

class fft_16_4_around_max_seq extends fft_16_4_in_base_sequence;

    `uvm_object_utils(fft_16_4_around_max_seq)

    function new(string name="fft_16_4_around_max_seq");
        super.new(name);
    endfunction : new
    
    virtual task body();
        `uvm_info("fft_16_4_in Sequence", "Executing around_max_seq.", UVM_NONE)
        repeat(4*500) begin
            `uvm_create(req)
                void'(req.randomize() with {
                    8'h7f - i_data_1_real < 10;
                    8'h7f - i_data_1_imag < 10;
                    8'h7f - i_data_2_real < 10;
                    8'h7f - i_data_2_imag < 10;
                    8'h7f - i_data_3_real < 10;
                    8'h7f - i_data_3_imag < 10;
                    8'h7f - i_data_4_real < 10;
                    8'h7f - i_data_4_imag < 10;
                });
            `uvm_send(req)
        end
    endtask : body

endclass : fft_16_4_around_max_seq

//==============================================================//

class fft_16_4_around_min_seq extends fft_16_4_in_base_sequence;

    `uvm_object_utils(fft_16_4_around_min_seq)

    function new(string name="fft_16_4_around_min_seq");
        super.new(name);
    endfunction : new
    
    virtual task body();
        `uvm_info("fft_16_4_in Sequence", "Executing around_min_seq.", UVM_NONE)
        repeat(4*500) begin
            `uvm_create(req)
                void'(req.randomize() with {
                    i_data_1_real - 8'h10 < 10;
                    i_data_1_imag - 8'h10 < 10;
                    i_data_2_real - 8'h10 < 10;
                    i_data_2_imag - 8'h10 < 10;
                    i_data_3_real - 8'h10 < 10;
                    i_data_3_imag - 8'h10 < 10;
                    i_data_4_real - 8'h10 < 10;
                    i_data_4_imag - 8'h10 < 10;
                });
            `uvm_send(req)
        end
    endtask : body

endclass : fft_16_4_around_min_seq

//==============================================================//

class fft_16_4_corners_seq extends fft_16_4_in_base_sequence;

    fft_16_4_around_0_seq   seq_0;
    fft_16_4_around_max_seq seq_max;
    fft_16_4_around_min_seq seq_min;

    `uvm_object_utils(fft_16_4_corners_seq)

    function new(string name="fft_16_4_corners_seq");
        super.new(name);
    endfunction : new
    
    virtual task body();
        `uvm_info("fft_16_4_in Sequence", "Executing corners_seq.", UVM_NONE)
        `uvm_do(seq_0);
        `uvm_do(seq_max);
        `uvm_do(seq_min);
    endtask : body

endclass : fft_16_4_corners_seq

//==============================================================//

class fft_16_4_exhaustive_seq extends fft_16_4_in_base_sequence;
//COVERAGE MUST BE ENABLED!!
    fft_16_4_in_random_seq   seq_rnd;
    fft_16_4_in_full_cov_seq seq_fullcov;
    fft_16_4_corners_seq     seq_corners;

    `uvm_object_utils(fft_16_4_exhaustive_seq)

    function new(string name="fft_16_4_exhaustive_seq");
        super.new(name);
    endfunction : new
    
    virtual task body();
        `uvm_info("fft_16_4_in Sequence", "Executing exhaustive_seq.", UVM_NONE)
        `uvm_do(seq_rnd);
        `uvm_do(seq_fullcov);
        `uvm_do(seq_corners);
    endtask : body

endclass : fft_16_4_exhaustive_seq

//==============================================================//
