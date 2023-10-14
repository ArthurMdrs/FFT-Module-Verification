class fft_16_4_in_packet extends uvm_sequence_item;

        //  bit  i_valid;
    rand int  i_data_1_real;
    rand int  i_data_1_imag;
    rand int  i_data_2_real;
    rand int  i_data_2_imag;
    rand int  i_data_3_real;
    rand int  i_data_3_imag;
    rand int  i_data_4_real;
    rand int  i_data_4_imag;

    `uvm_object_utils_begin(fft_16_4_in_packet)
        // `uvm_field_int(i_valid, UVM_ALL_ON)
        `uvm_field_int(i_data_1_real, UVM_ALL_ON)
        `uvm_field_int(i_data_1_imag, UVM_ALL_ON)
        `uvm_field_int(i_data_2_real, UVM_ALL_ON)
        `uvm_field_int(i_data_2_imag, UVM_ALL_ON)
        `uvm_field_int(i_data_3_real, UVM_ALL_ON)
        `uvm_field_int(i_data_3_imag, UVM_ALL_ON)
        `uvm_field_int(i_data_4_real, UVM_ALL_ON)
        `uvm_field_int(i_data_4_imag, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="fft_16_4_in_packet");
        super.new(name);
    endfunction: new

    // Type your constraints!
    constraint i_data_1_real_range {i_data_1_real < 2**8; i_data_1_real >= 0;}
    constraint i_data_1_imag_range {i_data_1_imag < 2**8; i_data_1_imag >= 0;}
    constraint i_data_2_real_range {i_data_2_real < 2**8; i_data_2_real >= 0;}
    constraint i_data_2_imag_range {i_data_2_imag < 2**8; i_data_2_imag >= 0;}
    constraint i_data_3_real_range {i_data_3_real < 2**8; i_data_3_real >= 0;}
    constraint i_data_3_imag_range {i_data_3_imag < 2**8; i_data_3_imag >= 0;}
    constraint i_data_4_real_range {i_data_4_real < 2**8; i_data_4_real >= 0;}
    constraint i_data_4_imag_range {i_data_4_imag < 2**8; i_data_4_imag >= 0;}

    function string convert2string();
        string string_aux;

        string_aux = {string_aux, "\n***************************\n"};
        // string_aux = {string_aux, $sformatf("** i_valid value: %2h\n", i_valid)};
        string_aux = {string_aux, $sformatf("** i_data_1_real value: %2h\n", i_data_1_real)};
        string_aux = {string_aux, $sformatf("** i_data_1_imag value: %2h\n", i_data_1_imag)};
        string_aux = {string_aux, $sformatf("** i_data_2_real value: %2h\n", i_data_2_real)};
        string_aux = {string_aux, $sformatf("** i_data_2_imag value: %2h\n", i_data_2_imag)};
        string_aux = {string_aux, $sformatf("** i_data_3_real value: %2h\n", i_data_3_real)};
        string_aux = {string_aux, $sformatf("** i_data_3_imag value: %2h\n", i_data_3_imag)};
        string_aux = {string_aux, $sformatf("** i_data_4_real value: %2h\n", i_data_4_real)};
        string_aux = {string_aux, $sformatf("** i_data_4_imag value: %2h\n", i_data_4_imag)};
        string_aux = {string_aux, "***************************"};
        return string_aux;
    endfunction: convert2string

    // function void post_randomize();
    // endfunction: post_randomize

endclass: fft_16_4_in_packet
