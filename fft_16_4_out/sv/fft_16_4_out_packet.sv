class fft_16_4_out_packet extends uvm_sequence_item;

         bit  o_valid;
    rand int  o_data_1_real;
    rand int  o_data_1_imag;
    rand int  o_data_2_real;
    rand int  o_data_2_imag;
    rand int  o_data_3_real;
    rand int  o_data_3_imag;
    rand int  o_data_4_real;
    rand int  o_data_4_imag;
    rand int  o_data_5_real;
    rand int  o_data_5_imag;
    rand int  o_data_6_real;
    rand int  o_data_6_imag;
    rand int  o_data_7_real;
    rand int  o_data_7_imag;
    rand int  o_data_8_real;
    rand int  o_data_8_imag;
    rand int  o_data_9_real;
    rand int  o_data_9_imag;
    rand int  o_data_10_real;
    rand int  o_data_10_imag;
    rand int  o_data_11_real;
    rand int  o_data_11_imag;
    rand int  o_data_12_real;
    rand int  o_data_12_imag;
    rand int  o_data_13_real;
    rand int  o_data_13_imag;
    rand int  o_data_14_real;
    rand int  o_data_14_imag;
    rand int  o_data_15_real;
    rand int  o_data_15_imag;
    rand int  o_data_16_real;
    rand int  o_data_16_imag;

    `uvm_object_utils_begin(fft_16_4_out_packet)
        `uvm_field_int(o_valid, UVM_ALL_ON)
        `uvm_field_int(o_data_1_real, UVM_ALL_ON)
        `uvm_field_int(o_data_1_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_2_real, UVM_ALL_ON)
        `uvm_field_int(o_data_2_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_3_real, UVM_ALL_ON)
        `uvm_field_int(o_data_3_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_4_real, UVM_ALL_ON)
        `uvm_field_int(o_data_4_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_5_real, UVM_ALL_ON)
        `uvm_field_int(o_data_5_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_6_real, UVM_ALL_ON)
        `uvm_field_int(o_data_6_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_7_real, UVM_ALL_ON)
        `uvm_field_int(o_data_7_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_8_real, UVM_ALL_ON)
        `uvm_field_int(o_data_8_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_9_real, UVM_ALL_ON)
        `uvm_field_int(o_data_9_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_10_real, UVM_ALL_ON)
        `uvm_field_int(o_data_10_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_11_real, UVM_ALL_ON)
        `uvm_field_int(o_data_11_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_12_real, UVM_ALL_ON)
        `uvm_field_int(o_data_12_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_13_real, UVM_ALL_ON)
        `uvm_field_int(o_data_13_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_14_real, UVM_ALL_ON)
        `uvm_field_int(o_data_14_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_15_real, UVM_ALL_ON)
        `uvm_field_int(o_data_15_imag, UVM_ALL_ON)
        `uvm_field_int(o_data_16_real, UVM_ALL_ON)
        `uvm_field_int(o_data_16_imag, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="fft_16_4_out_packet");
        super.new(name);
    endfunction: new

    // Type your constraints!

    function string convert2string();
        string string_aux;

        string_aux = {string_aux, "\n***************************\n"};
        string_aux = {string_aux, $sformatf("** o_valid value: %2h\n", o_valid)};
        string_aux = {string_aux, $sformatf("** o_data_1_real value: %2h\n", o_data_1_real)};
        string_aux = {string_aux, $sformatf("** o_data_1_imag value: %2h\n", o_data_1_imag)};
        string_aux = {string_aux, $sformatf("** o_data_2_real value: %2h\n", o_data_2_real)};
        string_aux = {string_aux, $sformatf("** o_data_2_imag value: %2h\n", o_data_2_imag)};
        string_aux = {string_aux, $sformatf("** o_data_3_real value: %2h\n", o_data_3_real)};
        string_aux = {string_aux, $sformatf("** o_data_3_imag value: %2h\n", o_data_3_imag)};
        string_aux = {string_aux, $sformatf("** o_data_4_real value: %2h\n", o_data_4_real)};
        string_aux = {string_aux, $sformatf("** o_data_4_imag value: %2h\n", o_data_4_imag)};
        string_aux = {string_aux, $sformatf("** o_data_5_real value: %2h\n", o_data_5_real)};
        string_aux = {string_aux, $sformatf("** o_data_5_imag value: %2h\n", o_data_5_imag)};
        string_aux = {string_aux, $sformatf("** o_data_6_real value: %2h\n", o_data_6_real)};
        string_aux = {string_aux, $sformatf("** o_data_6_imag value: %2h\n", o_data_6_imag)};
        string_aux = {string_aux, $sformatf("** o_data_7_real value: %2h\n", o_data_7_real)};
        string_aux = {string_aux, $sformatf("** o_data_7_imag value: %2h\n", o_data_7_imag)};
        string_aux = {string_aux, $sformatf("** o_data_8_real value: %2h\n", o_data_8_real)};
        string_aux = {string_aux, $sformatf("** o_data_8_imag value: %2h\n", o_data_8_imag)};
        string_aux = {string_aux, $sformatf("** o_data_9_real value: %2h\n", o_data_9_real)};
        string_aux = {string_aux, $sformatf("** o_data_9_imag value: %2h\n", o_data_9_imag)};
        string_aux = {string_aux, $sformatf("** o_data_10_real value: %2h\n", o_data_10_real)};
        string_aux = {string_aux, $sformatf("** o_data_10_imag value: %2h\n", o_data_10_imag)};
        string_aux = {string_aux, $sformatf("** o_data_11_real value: %2h\n", o_data_11_real)};
        string_aux = {string_aux, $sformatf("** o_data_11_imag value: %2h\n", o_data_11_imag)};
        string_aux = {string_aux, $sformatf("** o_data_12_real value: %2h\n", o_data_12_real)};
        string_aux = {string_aux, $sformatf("** o_data_12_imag value: %2h\n", o_data_12_imag)};
        string_aux = {string_aux, $sformatf("** o_data_13_real value: %2h\n", o_data_13_real)};
        string_aux = {string_aux, $sformatf("** o_data_13_imag value: %2h\n", o_data_13_imag)};
        string_aux = {string_aux, $sformatf("** o_data_14_real value: %2h\n", o_data_14_real)};
        string_aux = {string_aux, $sformatf("** o_data_14_imag value: %2h\n", o_data_14_imag)};
        string_aux = {string_aux, $sformatf("** o_data_15_real value: %2h\n", o_data_15_real)};
        string_aux = {string_aux, $sformatf("** o_data_15_imag value: %2h\n", o_data_15_imag)};
        string_aux = {string_aux, $sformatf("** o_data_16_real value: %2h\n", o_data_16_real)};
        string_aux = {string_aux, $sformatf("** o_data_16_imag value: %2h\n", o_data_16_imag)};
        string_aux = {string_aux, "***************************"};
        return string_aux;
    endfunction: convert2string

    // function void post_randomize();
    // endfunction: post_randomize

endclass: fft_16_4_out_packet
