class fft_16_4_in_coverage extends uvm_subscriber #(fft_16_4_in_packet);

    real coverage_value;
    fft_16_4_in_packet cov_transaction;

    `uvm_component_utils_begin(fft_16_4_in_coverage)
        `uvm_field_real(coverage_value, UVM_ALL_ON)
    `uvm_component_utils_end

    covergroup fft_16_4_in_covergroup;
        option.per_instance = 1;
        option.name = {get_full_name(), ".", "covergroup"};
        // option.at_least = 3;
        // option.auto_bin_max = 256;
        // option.cross_auto_bin_max = 256;
        cp_i_data_1_real: coverpoint cov_transaction.i_data_1_real;
        cp_i_data_1_imag: coverpoint cov_transaction.i_data_1_imag;
        cp_i_data_2_real: coverpoint cov_transaction.i_data_2_real;
        cp_i_data_2_imag: coverpoint cov_transaction.i_data_2_imag;
        cp_i_data_3_real: coverpoint cov_transaction.i_data_3_real;
        cp_i_data_3_imag: coverpoint cov_transaction.i_data_3_imag;
        cp_i_data_4_real: coverpoint cov_transaction.i_data_4_real;
        cp_i_data_4_imag: coverpoint cov_transaction.i_data_4_imag;
    endgroup : fft_16_4_in_covergroup

    function new (string name, uvm_component parent);
        super.new(name, parent);
        fft_16_4_in_covergroup = new();
    endfunction: new

    function void report_phase (uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("FFT_16_4_IN COVERAGE", $sformatf("Coverage: %2.2f%%", get_coverage()), UVM_NONE)
    endfunction : report_phase

    function void sample (fft_16_4_in_packet t);
        cov_transaction = t;
        fft_16_4_in_covergroup.sample();
    endfunction : sample

    function real get_coverage ();
        return fft_16_4_in_covergroup.get_inst_coverage();
    endfunction : get_coverage

    function void write(fft_16_4_in_packet t);      
        sample(t); // sample coverage with this transaction
        coverage_value = get_coverage();
    endfunction : write

endclass : fft_16_4_in_coverage
