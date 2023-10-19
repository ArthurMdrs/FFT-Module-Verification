class fft_16_4_refmod extends uvm_component;

    `uvm_component_utils(fft_16_4_refmod)

    uvm_get_port #(fft_16_4_in_packet) data_in;

    uvm_blocking_put_port #(fft_16_4_out_packet) data_out;

    int no_received;

    function new(string name, uvm_component parent=null);
        super.new(name, parent);
        data_in  = new("data_in" , this);
        data_out = new("data_out", this);
    endfunction : new
    
    virtual task run_phase (uvm_phase phase);
        fft_16_4_in_packet pkt_in;
        fft_16_4_out_packet pkt_out = fft_16_4_out_packet::type_id::create("pkt_out", this);
        bit [1:0] k;
        forever begin
            data_in.get(pkt_in);
            // `uvm_info("REFERENCE MODEL", $sformatf("Packet collected:\n%s", pkt_in.convert2string()), UVM_NONE)
            case (k)
                0: begin
                    pkt_out.o_data_1_real = pkt_in.i_data_1_real;
                    pkt_out.o_data_1_imag = pkt_in.i_data_1_imag;
                    pkt_out.o_data_2_real = pkt_in.i_data_2_real;
                    pkt_out.o_data_2_imag = pkt_in.i_data_2_imag;
                    pkt_out.o_data_3_real = pkt_in.i_data_3_real;
                    pkt_out.o_data_3_imag = pkt_in.i_data_3_imag;
                    pkt_out.o_data_4_real = pkt_in.i_data_4_real;
                    pkt_out.o_data_4_imag = pkt_in.i_data_4_imag;
                end
                1: begin
                    pkt_out.o_data_5_real = pkt_in.i_data_1_real;
                    pkt_out.o_data_5_imag = pkt_in.i_data_1_imag;
                    pkt_out.o_data_6_real = pkt_in.i_data_2_real;
                    pkt_out.o_data_6_imag = pkt_in.i_data_2_imag;
                    pkt_out.o_data_7_real = pkt_in.i_data_3_real;
                    pkt_out.o_data_7_imag = pkt_in.i_data_3_imag;
                    pkt_out.o_data_8_real = pkt_in.i_data_4_real;
                    pkt_out.o_data_8_imag = pkt_in.i_data_4_imag;
                end
                2: begin
                    pkt_out.o_data_9_real = pkt_in.i_data_1_real;
                    pkt_out.o_data_9_imag = pkt_in.i_data_1_imag;
                    pkt_out.o_data_10_real = pkt_in.i_data_2_real;
                    pkt_out.o_data_10_imag = pkt_in.i_data_2_imag;
                    pkt_out.o_data_11_real = pkt_in.i_data_3_real;
                    pkt_out.o_data_11_imag = pkt_in.i_data_3_imag;
                    pkt_out.o_data_12_real = pkt_in.i_data_4_real;
                    pkt_out.o_data_12_imag = pkt_in.i_data_4_imag;
                end
                3: begin
                    pkt_out.o_data_13_real = pkt_in.i_data_1_real;
                    pkt_out.o_data_13_imag = pkt_in.i_data_1_imag;
                    pkt_out.o_data_14_real = pkt_in.i_data_2_real;
                    pkt_out.o_data_14_imag = pkt_in.i_data_2_imag;
                    pkt_out.o_data_15_real = pkt_in.i_data_3_real;
                    pkt_out.o_data_15_imag = pkt_in.i_data_3_imag;
                    pkt_out.o_data_16_real = pkt_in.i_data_4_real;
                    pkt_out.o_data_16_imag = pkt_in.i_data_4_imag;
                    `uvm_info("REFERENCE MODEL", $sformatf("Packet to send:\n%s", pkt_out.convert2string()), UVM_NONE)
                    data_out.put(pkt_out);
                end
            endcase
            k++;
            no_received++;
        end
    endtask : run_phase

    function void report_phase (uvm_phase phase);
        `uvm_info("REFERENCE MODEL", $sformatf("Number of packets received: %0d", no_received), UVM_NONE)
    endfunction : report_phase

endclass : fft_16_4_refmod