// typedef struct {
//     real array [16][2];
// } DpiStructGEN;

class fft_16_4_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(fft_16_4_scoreboard)

    uvm_tlm_analysis_fifo #(fft_16_4_out_packet) dut_fifo;
    
    `uvm_blocking_put_imp_decl(_refmod)
    uvm_blocking_put_imp_refmod #(DpiStructGEN, fft_16_4_scoreboard) refmod_out_imp;

    int no_matches, no_mismatches, no_total;

    real refmod_arr [16][2];
    real dut_arr [16][2];
    real scale = 2.0**-7;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        dut_fifo = new("dut_fifo" , this);
        refmod_out_imp = new("refmod_out_imp" , this);
    endfunction : new

    task put_refmod (DpiStructGEN from_refmod);
        fft_16_4_out_packet dut_pkt;
        int err_idx [];

        dut_fifo.get_peek_export.get(dut_pkt);

        refmod_arr = from_refmod.array;

        dut_arr[0][0] = dut_pkt.o_data_1_real * scale;
        dut_arr[0][1] = dut_pkt.o_data_1_imag * scale;
        dut_arr[1][0] = dut_pkt.o_data_2_real * scale;
        dut_arr[1][1] = dut_pkt.o_data_2_imag * scale;
        dut_arr[2][0] = dut_pkt.o_data_3_real * scale;
        dut_arr[2][1] = dut_pkt.o_data_3_imag * scale;
        dut_arr[3][0] = dut_pkt.o_data_4_real * scale;
        dut_arr[3][1] = dut_pkt.o_data_4_imag * scale;
        dut_arr[4][0] = dut_pkt.o_data_5_real * scale;
        dut_arr[4][1] = dut_pkt.o_data_5_imag * scale;
        dut_arr[5][0] = dut_pkt.o_data_6_real * scale;
        dut_arr[5][1] = dut_pkt.o_data_6_imag * scale;
        dut_arr[6][0] = dut_pkt.o_data_7_real * scale;
        dut_arr[6][1] = dut_pkt.o_data_7_imag * scale;
        dut_arr[7][0] = dut_pkt.o_data_8_real * scale;
        dut_arr[7][1] = dut_pkt.o_data_8_imag * scale;
        dut_arr[8][0] = dut_pkt.o_data_9_real * scale;
        dut_arr[8][1] = dut_pkt.o_data_9_imag * scale;
        dut_arr[9][0] = dut_pkt.o_data_10_real * scale;
        dut_arr[9][1] = dut_pkt.o_data_10_imag * scale;
        dut_arr[10][0] = dut_pkt.o_data_11_real * scale;
        dut_arr[10][1] = dut_pkt.o_data_11_imag * scale;
        dut_arr[11][0] = dut_pkt.o_data_12_real * scale;
        dut_arr[11][1] = dut_pkt.o_data_12_imag * scale;
        dut_arr[12][0] = dut_pkt.o_data_13_real * scale;
        dut_arr[12][1] = dut_pkt.o_data_13_imag * scale;
        dut_arr[13][0] = dut_pkt.o_data_14_real * scale;
        dut_arr[13][1] = dut_pkt.o_data_14_imag * scale;
        dut_arr[14][0] = dut_pkt.o_data_15_real * scale;
        dut_arr[14][1] = dut_pkt.o_data_15_imag * scale;
        dut_arr[15][0] = dut_pkt.o_data_16_real * scale;
        dut_arr[15][1] = dut_pkt.o_data_16_imag * scale;
        
        // $display("From refmod");
        // foreach(refmod_arr[i])
        //     $display("idx %0d: %f, %f", i, refmod_arr[i][0], refmod_arr[i][1]);
        // $display("From DUT");
        // foreach(dut_arr[i])
        //     $display("idx %0d: %f, %f", i, dut_arr[i][0], dut_arr[i][1]);

        if(!compare(refmod_arr, dut_arr, err_idx)) begin
            `uvm_info("SCOREBOARD", "A mismatch has occured!", UVM_NONE)
            foreach (err_idx[i]) begin
                `uvm_info("SCOREBOARD", $sformatf("Element %0d from refmod: (%f, %f)", err_idx[i], refmod_arr[err_idx[i]][0], refmod_arr[err_idx[i]][1]), UVM_NONE)
                `uvm_info("SCOREBOARD", $sformatf("Element %0d from DUT: (%f, %f)", err_idx[i], dut_arr[err_idx[i]][0], dut_arr[err_idx[i]][1]), UVM_NONE)
                `uvm_info("SCOREBOARD", "% ===================================================== %", UVM_NONE)
            end
            no_mismatches++;
        end else begin
            no_matches++;
        end

        no_total++;
    endtask : put_refmod

    function bit compare (real refmod_arr [16][2], real dut_arr [16][2], output int err_idx []);

        real tol = 2.0**-3;

        compare = 1;

        foreach (refmod_arr[i])
            foreach (refmod_arr[i][j])
                // if (refmod_arr[i][j] - dut_arr[i][j] > 1 || dut_arr[i][j] - refmod_arr[i][j] > 1) begin
                if (refmod_arr[i][j] - dut_arr[i][j] > tol || dut_arr[i][j] - refmod_arr[i][j] > tol) begin
                    err_idx = new [err_idx.size() + 1] (err_idx);
                    err_idx[err_idx.size() - 1] = i;
                    compare = 0;
                end

    endfunction : compare

    function void report_phase (uvm_phase phase);
        `uvm_info("SCOREBOARD", $sformatf("Number of packets compared: %0d", no_total), UVM_NONE)
        `uvm_info("SCOREBOARD", $sformatf("Number of matches: %0d", no_matches), UVM_NONE)
        `uvm_info("SCOREBOARD", $sformatf("Number of mismatches: %0d", no_mismatches), UVM_NONE)
    endfunction : report_phase

endclass : fft_16_4_scoreboard
