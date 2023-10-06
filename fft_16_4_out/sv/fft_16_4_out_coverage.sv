class fft_16_4_out_coverage extends uvm_subscriber #(fft_16_4_out_packet);

    real coverage_value;
    fft_16_4_out_packet cov_transaction;

    `uvm_component_utils_begin(fft_16_4_out_coverage)
        `uvm_field_real(coverage_value, UVM_ALL_ON)
    `uvm_component_utils_end

    covergroup fft_16_4_out_covergroup;
        option.per_instance = 1;
        option.name = {get_full_name(), ".", "covergroup"};
        // option.at_least = 3;
        // option.auto_bin_max = 256;
        // option.cross_auto_bin_max = 256;
        cp_o_valid: coverpoint cov_transaction.o_valid;
        cp_o_data_1_real: coverpoint cov_transaction.o_data_1_real;
        cp_o_data_1_imag: coverpoint cov_transaction.o_data_1_imag;
        cp_o_data_2_real: coverpoint cov_transaction.o_data_2_real;
        cp_o_data_2_imag: coverpoint cov_transaction.o_data_2_imag;
        cp_o_data_3_real: coverpoint cov_transaction.o_data_3_real;
        cp_o_data_3_imag: coverpoint cov_transaction.o_data_3_imag;
        cp_o_data_4_real: coverpoint cov_transaction.o_data_4_real;
        cp_o_data_4_imag: coverpoint cov_transaction.o_data_4_imag;
        cp_o_data_5_real: coverpoint cov_transaction.o_data_5_real;
        cp_o_data_5_imag: coverpoint cov_transaction.o_data_5_imag;
        cp_o_data_6_real: coverpoint cov_transaction.o_data_6_real;
        cp_o_data_6_imag: coverpoint cov_transaction.o_data_6_imag;
        cp_o_data_7_real: coverpoint cov_transaction.o_data_7_real;
        cp_o_data_7_imag: coverpoint cov_transaction.o_data_7_imag;
        cp_o_data_8_real: coverpoint cov_transaction.o_data_8_real;
        cp_o_data_8_imag: coverpoint cov_transaction.o_data_8_imag;
        cp_o_data_9_real: coverpoint cov_transaction.o_data_9_real;
        cp_o_data_9_imag: coverpoint cov_transaction.o_data_9_imag;
        cp_o_data_10_real: coverpoint cov_transaction.o_data_10_real;
        cp_o_data_10_imag: coverpoint cov_transaction.o_data_10_imag;
        cp_o_data_11_real: coverpoint cov_transaction.o_data_11_real;
        cp_o_data_11_imag: coverpoint cov_transaction.o_data_11_imag;
        cp_o_data_12_real: coverpoint cov_transaction.o_data_12_real;
        cp_o_data_12_imag: coverpoint cov_transaction.o_data_12_imag;
        cp_o_data_13_real: coverpoint cov_transaction.o_data_13_real;
        cp_o_data_13_imag: coverpoint cov_transaction.o_data_13_imag;
        cp_o_data_14_real: coverpoint cov_transaction.o_data_14_real;
        cp_o_data_14_imag: coverpoint cov_transaction.o_data_14_imag;
        cp_o_data_15_real: coverpoint cov_transaction.o_data_15_real;
        cp_o_data_15_imag: coverpoint cov_transaction.o_data_15_imag;
        cp_o_data_16_real: coverpoint cov_transaction.o_data_16_real;
        cp_o_data_16_imag: coverpoint cov_transaction.o_data_16_imag;
    endgroup : fft_16_4_out_covergroup

    function new (string name, uvm_component parent);
        super.new(name, parent);
        fft_16_4_out_covergroup = new();
    endfunction: new

    function void report_phase (uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("FFT_16_4_OUT COVERAGE", $sformatf("Coverage: %2.2f%%", get_coverage()), UVM_NONE)
    endfunction : report_phase

    function void sample (fft_16_4_out_packet t);
        cov_transaction = t;
        fft_16_4_out_covergroup.sample();
    endfunction : sample

    function real get_coverage ();
        return fft_16_4_out_covergroup.get_inst_coverage();
    endfunction : get_coverage

    function void write(fft_16_4_out_packet t);      
        sample(t); // sample coverage with this transaction
        coverage_value = get_coverage();
    endfunction : write

endclass : fft_16_4_out_coverage
