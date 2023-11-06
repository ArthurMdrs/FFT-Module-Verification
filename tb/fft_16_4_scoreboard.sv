class fft_16_4_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(fft_16_4_scoreboard)

    uvm_tlm_analysis_fifo #(fft_16_4_out_packet) dut_fifo;
    
    `uvm_blocking_put_imp_decl(_refmod)
    uvm_blocking_put_imp_refmod #(fft_16_4_out_packet, fft_16_4_scoreboard) refmod_out_imp;

    int no_matches, no_mismatches, no_total;

    int refmod_arr [16][2];
    int dut_arr [16][2];

    function new(string name, uvm_component parent);
        super.new(name, parent);
        dut_fifo = new("dut_fifo" , this);
        refmod_out_imp = new("refmod_out_imp" , this);
    endfunction : new

    task put_refmod (fft_16_4_out_packet refmod_pkt);
        fft_16_4_out_packet dut_pkt;
        int err_idx [];

        dut_fifo.get_peek_export.get(dut_pkt);

        refmod_arr[0][0] = refmod_pkt.o_data_1_real;
        refmod_arr[0][1] = refmod_pkt.o_data_1_imag;
        refmod_arr[1][0] = refmod_pkt.o_data_2_real;
        refmod_arr[1][1] = refmod_pkt.o_data_2_imag;
        refmod_arr[2][0] = refmod_pkt.o_data_3_real;
        refmod_arr[2][1] = refmod_pkt.o_data_3_imag;
        refmod_arr[3][0] = refmod_pkt.o_data_4_real;
        refmod_arr[3][1] = refmod_pkt.o_data_4_imag;
        refmod_arr[4][0] = refmod_pkt.o_data_5_real;
        refmod_arr[4][1] = refmod_pkt.o_data_5_imag;
        refmod_arr[5][0] = refmod_pkt.o_data_6_real;
        refmod_arr[5][1] = refmod_pkt.o_data_6_imag;
        refmod_arr[6][0] = refmod_pkt.o_data_7_real;
        refmod_arr[6][1] = refmod_pkt.o_data_7_imag;
        refmod_arr[7][0] = refmod_pkt.o_data_8_real;
        refmod_arr[7][1] = refmod_pkt.o_data_8_imag;
        refmod_arr[8][0] = refmod_pkt.o_data_9_real;
        refmod_arr[8][1] = refmod_pkt.o_data_9_imag;
        refmod_arr[9][0] = refmod_pkt.o_data_10_real;
        refmod_arr[9][1] = refmod_pkt.o_data_10_imag;
        refmod_arr[10][0] = refmod_pkt.o_data_11_real;
        refmod_arr[10][1] = refmod_pkt.o_data_11_imag;
        refmod_arr[11][0] = refmod_pkt.o_data_12_real;
        refmod_arr[11][1] = refmod_pkt.o_data_12_imag;
        refmod_arr[12][0] = refmod_pkt.o_data_13_real;
        refmod_arr[12][1] = refmod_pkt.o_data_13_imag;
        refmod_arr[13][0] = refmod_pkt.o_data_14_real;
        refmod_arr[13][1] = refmod_pkt.o_data_14_imag;
        refmod_arr[14][0] = refmod_pkt.o_data_15_real;
        refmod_arr[14][1] = refmod_pkt.o_data_15_imag;
        refmod_arr[15][0] = refmod_pkt.o_data_16_real;
        refmod_arr[15][1] = refmod_pkt.o_data_16_imag;

        dut_arr[0][0] = dut_pkt.o_data_1_real;
        dut_arr[0][1] = dut_pkt.o_data_1_imag;
        dut_arr[1][0] = dut_pkt.o_data_2_real;
        dut_arr[1][1] = dut_pkt.o_data_2_imag;
        dut_arr[2][0] = dut_pkt.o_data_3_real;
        dut_arr[2][1] = dut_pkt.o_data_3_imag;
        dut_arr[3][0] = dut_pkt.o_data_4_real;
        dut_arr[3][1] = dut_pkt.o_data_4_imag;
        dut_arr[4][0] = dut_pkt.o_data_5_real;
        dut_arr[4][1] = dut_pkt.o_data_5_imag;
        dut_arr[5][0] = dut_pkt.o_data_6_real;
        dut_arr[5][1] = dut_pkt.o_data_6_imag;
        dut_arr[6][0] = dut_pkt.o_data_7_real;
        dut_arr[6][1] = dut_pkt.o_data_7_imag;
        dut_arr[7][0] = dut_pkt.o_data_8_real;
        dut_arr[7][1] = dut_pkt.o_data_8_imag;
        dut_arr[8][0] = dut_pkt.o_data_9_real;
        dut_arr[8][1] = dut_pkt.o_data_9_imag;
        dut_arr[9][0] = dut_pkt.o_data_10_real;
        dut_arr[9][1] = dut_pkt.o_data_10_imag;
        dut_arr[10][0] = dut_pkt.o_data_11_real;
        dut_arr[10][1] = dut_pkt.o_data_11_imag;
        dut_arr[11][0] = dut_pkt.o_data_12_real;
        dut_arr[11][1] = dut_pkt.o_data_12_imag;
        dut_arr[12][0] = dut_pkt.o_data_13_real;
        dut_arr[12][1] = dut_pkt.o_data_13_imag;
        dut_arr[13][0] = dut_pkt.o_data_14_real;
        dut_arr[13][1] = dut_pkt.o_data_14_imag;
        dut_arr[14][0] = dut_pkt.o_data_15_real;
        dut_arr[14][1] = dut_pkt.o_data_15_imag;
        dut_arr[15][0] = dut_pkt.o_data_16_real;
        dut_arr[15][1] = dut_pkt.o_data_16_imag;

        // `uvm_info("SCOREBOARD", $sformatf("Packet from refmod:\n%s", refmod_pkt.convert2string()), UVM_NONE)
        // `uvm_info("SCOREBOARD", $sformatf("Packet from DUT:\n%s", dut_pkt.convert2string()), UVM_NONE)
        // if(!compare(refmod_pkt, dut_pkt)) begin
        //     `uvm_info("SCOREBOARD", "A mismatch has occured!", UVM_NONE)
        //     no_mismatches++;
        // end else begin
        //     no_matches++;
        // end

        if(!compare(refmod_arr, dut_arr, err_idx)) begin
            `uvm_info("SCOREBOARD", "A mismatch has occured!", UVM_NONE)
            foreach (err_idx[i]) begin
                `uvm_info("SCOREBOARD", $sformatf("Element %0d from refmod: (%h, %h)", err_idx[i], refmod_arr[err_idx[i]][0], refmod_arr[err_idx[i]][1]), UVM_NONE)
                `uvm_info("SCOREBOARD", $sformatf("Element %0d from DUT: (%h, %h)", err_idx[i], dut_arr[err_idx[i]][0], dut_arr[err_idx[i]][1]), UVM_NONE)
                `uvm_info("SCOREBOARD", "% ===================================================== %", UVM_NONE)
            end
            no_mismatches++;
        end else begin
            no_matches++;
        end

        no_total++;
    endtask : put_refmod

    function bit compare (int refmod_arr [16][2], int dut_arr [16][2], output int err_idx []);

        compare = 1;

        foreach (refmod_arr[i])
            foreach (refmod_arr[i][j])
                // if (refmod_arr[i][j] != dut_arr[i][j]) begin
                if (refmod_arr[i][j] - dut_arr[i][j] > 1 || dut_arr[i][j] - refmod_arr[i][j] > 1) begin
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


    // function bit compare (fft_16_4_out_packet refmod_pkt, fft_16_4_out_packet dut_pkt, uvm_comparer comparer = null);
    //     bit res = 1;
    //     if (refmod_pkt.o_data_1_real != dut_pkt.o_data_1_real || refmod_pkt.o_data_1_imag != dut_pkt.o_data_1_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 1 from refmod: (%h, %h)", refmod_pkt.o_data_1_real, refmod_pkt.o_data_1_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 1 from dut: (%h, %h)", dut_pkt.o_data_1_real, dut_pkt.o_data_1_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_2_real != dut_pkt.o_data_2_real || refmod_pkt.o_data_2_imag != dut_pkt.o_data_2_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 2 from refmod: (%h, %h)", refmod_pkt.o_data_2_real, refmod_pkt.o_data_2_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 2 from dut: (%h, %h)", dut_pkt.o_data_2_real, dut_pkt.o_data_2_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_3_real != dut_pkt.o_data_3_real || refmod_pkt.o_data_3_imag != dut_pkt.o_data_3_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 3 from refmod: (%h, %h)", refmod_pkt.o_data_3_real, refmod_pkt.o_data_3_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 3 from dut: (%h, %h)", dut_pkt.o_data_3_real, dut_pkt.o_data_3_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_4_real != dut_pkt.o_data_4_real || refmod_pkt.o_data_4_imag != dut_pkt.o_data_4_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 4 from refmod: (%h, %h)", refmod_pkt.o_data_4_real, refmod_pkt.o_data_4_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 4 from dut: (%h, %h)", dut_pkt.o_data_4_real, dut_pkt.o_data_4_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_5_real != dut_pkt.o_data_5_real || refmod_pkt.o_data_5_imag != dut_pkt.o_data_5_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 5 from refmod: (%h, %h)", refmod_pkt.o_data_5_real, refmod_pkt.o_data_5_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 5 from dut: (%h, %h)", dut_pkt.o_data_5_real, dut_pkt.o_data_5_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_6_real != dut_pkt.o_data_6_real || refmod_pkt.o_data_6_imag != dut_pkt.o_data_6_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 6 from refmod: (%h, %h)", refmod_pkt.o_data_6_real, refmod_pkt.o_data_6_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 6 from dut: (%h, %h)", dut_pkt.o_data_6_real, dut_pkt.o_data_6_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_7_real != dut_pkt.o_data_7_real || refmod_pkt.o_data_7_imag != dut_pkt.o_data_7_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 7 from refmod: (%h, %h)", refmod_pkt.o_data_7_real, refmod_pkt.o_data_7_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 7 from dut: (%h, %h)", dut_pkt.o_data_7_real, dut_pkt.o_data_7_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_8_real != dut_pkt.o_data_8_real || refmod_pkt.o_data_8_imag != dut_pkt.o_data_8_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 8 from refmod: (%h, %h)", refmod_pkt.o_data_8_real, refmod_pkt.o_data_8_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 8 from dut: (%h, %h)", dut_pkt.o_data_8_real, dut_pkt.o_data_8_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_9_real != dut_pkt.o_data_9_real || refmod_pkt.o_data_9_imag != dut_pkt.o_data_9_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 9 from refmod: (%h, %h)", refmod_pkt.o_data_9_real, refmod_pkt.o_data_9_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 9 from dut: (%h, %h)", dut_pkt.o_data_9_real, dut_pkt.o_data_9_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_10_real != dut_pkt.o_data_10_real || refmod_pkt.o_data_10_imag != dut_pkt.o_data_10_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 10 from refmod: (%h, %h)", refmod_pkt.o_data_10_real, refmod_pkt.o_data_10_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 10 from dut: (%h, %h)", dut_pkt.o_data_10_real, dut_pkt.o_data_10_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_11_real != dut_pkt.o_data_11_real || refmod_pkt.o_data_11_imag != dut_pkt.o_data_11_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 11 from refmod: (%h, %h)", refmod_pkt.o_data_11_real, refmod_pkt.o_data_11_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 11 from dut: (%h, %h)", dut_pkt.o_data_11_real, dut_pkt.o_data_11_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_12_real != dut_pkt.o_data_12_real || refmod_pkt.o_data_12_imag != dut_pkt.o_data_12_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 12 from refmod: (%h, %h)", refmod_pkt.o_data_12_real, refmod_pkt.o_data_12_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 12 from dut: (%h, %h)", dut_pkt.o_data_12_real, dut_pkt.o_data_12_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_13_real != dut_pkt.o_data_13_real || refmod_pkt.o_data_13_imag != dut_pkt.o_data_13_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 13 from refmod: (%h, %h)", refmod_pkt.o_data_13_real, refmod_pkt.o_data_13_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 13 from dut: (%h, %h)", dut_pkt.o_data_13_real, dut_pkt.o_data_13_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_14_real != dut_pkt.o_data_14_real || refmod_pkt.o_data_14_imag != dut_pkt.o_data_14_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 14 from refmod: (%h, %h)", refmod_pkt.o_data_14_real, refmod_pkt.o_data_14_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 14 from dut: (%h, %h)", dut_pkt.o_data_14_real, dut_pkt.o_data_14_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_15_real != dut_pkt.o_data_15_real || refmod_pkt.o_data_15_imag != dut_pkt.o_data_15_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 15 from refmod: (%h, %h)", refmod_pkt.o_data_15_real, refmod_pkt.o_data_15_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 15 from dut: (%h, %h)", dut_pkt.o_data_15_real, dut_pkt.o_data_15_imag), UVM_NONE)
    //     end
    //     if (refmod_pkt.o_data_16_real != dut_pkt.o_data_16_real || refmod_pkt.o_data_16_imag != dut_pkt.o_data_16_imag) begin
    //         res = 0;
    //         `uvm_info("SCOREBOARD", $sformatf("Element 16 from refmod: (%h, %h)", refmod_pkt.o_data_16_real, refmod_pkt.o_data_16_imag), UVM_NONE)
    //         `uvm_info("SCOREBOARD", $sformatf("Element 16 from dut: (%h, %h)", dut_pkt.o_data_16_real, dut_pkt.o_data_16_imag), UVM_NONE)
    //     end

    //     return res;
    // endfunction : compare