// DPI stuff
typedef struct {
    int array [16][2];
} DpiStructGEN;

import "DPI-C" context fft_cpp = function void fft (inout DpiStructGEN dpiStruct);

// UVM class
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
        fft_16_4_in_packet  pkt_in;
        fft_16_4_out_packet pkt_out = fft_16_4_out_packet::type_id::create("pkt_out", this);
        bit [1:0] k;
        DpiStructGEN dpiStruct;
        
        forever begin
            data_in.get(pkt_in);
            // `uvm_info("REFERENCE MODEL", $sformatf("Packet collected:\n%s", pkt_in.convert2string()), UVM_NONE)
            case (k)
                0: begin
                    dpiStruct.array[0][0] = pkt_in.i_data_1_real;
                    dpiStruct.array[0][1] = pkt_in.i_data_1_imag;
                    dpiStruct.array[1][0] = pkt_in.i_data_2_real;
                    dpiStruct.array[1][1] = pkt_in.i_data_2_imag;
                    dpiStruct.array[2][0] = pkt_in.i_data_3_real;
                    dpiStruct.array[2][1] = pkt_in.i_data_3_imag;
                    dpiStruct.array[3][0] = pkt_in.i_data_4_real;
                    dpiStruct.array[3][1] = pkt_in.i_data_4_imag;
                end
                1: begin
                    dpiStruct.array[4][0] = pkt_in.i_data_1_real;
                    dpiStruct.array[4][1] = pkt_in.i_data_1_imag;
                    dpiStruct.array[5][0] = pkt_in.i_data_2_real;
                    dpiStruct.array[5][1] = pkt_in.i_data_2_imag;
                    dpiStruct.array[6][0] = pkt_in.i_data_3_real;
                    dpiStruct.array[6][1] = pkt_in.i_data_3_imag;
                    dpiStruct.array[7][0] = pkt_in.i_data_4_real;
                    dpiStruct.array[7][1] = pkt_in.i_data_4_imag;
                end
                2: begin
                    dpiStruct.array[8][0] = pkt_in.i_data_1_real;
                    dpiStruct.array[8][1] = pkt_in.i_data_1_imag;
                    dpiStruct.array[9][0] = pkt_in.i_data_2_real;
                    dpiStruct.array[9][1] = pkt_in.i_data_2_imag;
                    dpiStruct.array[10][0] = pkt_in.i_data_3_real;
                    dpiStruct.array[10][1] = pkt_in.i_data_3_imag;
                    dpiStruct.array[11][0] = pkt_in.i_data_4_real;
                    dpiStruct.array[11][1] = pkt_in.i_data_4_imag;
                end
                3: begin
                    dpiStruct.array[12][0] = pkt_in.i_data_1_real;
                    dpiStruct.array[12][1] = pkt_in.i_data_1_imag;
                    dpiStruct.array[13][0] = pkt_in.i_data_2_real;
                    dpiStruct.array[13][1] = pkt_in.i_data_2_imag;
                    dpiStruct.array[14][0] = pkt_in.i_data_3_real;
                    dpiStruct.array[14][1] = pkt_in.i_data_3_imag;
                    dpiStruct.array[15][0] = pkt_in.i_data_4_real;
                    dpiStruct.array[15][1] = pkt_in.i_data_4_imag;

                    fft (dpiStruct);
                    // foreach(dpiStruct.array[i])
                    //     $display("idx %0d: %h, %h", i, dpiStruct.array[i][0], dpiStruct.array[i][1]);

                    pkt_out.o_data_1_real = dpiStruct.array[0][0];
                    pkt_out.o_data_1_imag = dpiStruct.array[0][1];
                    pkt_out.o_data_2_real = dpiStruct.array[1][0];
                    pkt_out.o_data_2_imag = dpiStruct.array[1][1];
                    pkt_out.o_data_3_real = dpiStruct.array[2][0];
                    pkt_out.o_data_3_imag = dpiStruct.array[2][1];
                    pkt_out.o_data_4_real = dpiStruct.array[3][0];
                    pkt_out.o_data_4_imag = dpiStruct.array[3][1];
                    pkt_out.o_data_5_real = dpiStruct.array[4][0];
                    pkt_out.o_data_5_imag = dpiStruct.array[4][1];
                    pkt_out.o_data_6_real = dpiStruct.array[5][0];
                    pkt_out.o_data_6_imag = dpiStruct.array[5][1];
                    pkt_out.o_data_7_real = dpiStruct.array[6][0];
                    pkt_out.o_data_7_imag = dpiStruct.array[6][1];
                    pkt_out.o_data_8_real = dpiStruct.array[7][0];
                    pkt_out.o_data_8_imag = dpiStruct.array[7][1];
                    pkt_out.o_data_9_real = dpiStruct.array[8][0];
                    pkt_out.o_data_9_imag = dpiStruct.array[8][1];
                    pkt_out.o_data_10_real = dpiStruct.array[9][0];
                    pkt_out.o_data_10_imag = dpiStruct.array[9][1];
                    pkt_out.o_data_11_real = dpiStruct.array[10][0];
                    pkt_out.o_data_11_imag = dpiStruct.array[10][1];
                    pkt_out.o_data_12_real = dpiStruct.array[11][0];
                    pkt_out.o_data_12_imag = dpiStruct.array[11][1];
                    pkt_out.o_data_13_real = dpiStruct.array[12][0];
                    pkt_out.o_data_13_imag = dpiStruct.array[12][1];
                    pkt_out.o_data_14_real = dpiStruct.array[13][0];
                    pkt_out.o_data_14_imag = dpiStruct.array[13][1];
                    pkt_out.o_data_15_real = dpiStruct.array[14][0];
                    pkt_out.o_data_15_imag = dpiStruct.array[14][1];
                    pkt_out.o_data_16_real = dpiStruct.array[15][0];
                    pkt_out.o_data_16_imag = dpiStruct.array[15][1];

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