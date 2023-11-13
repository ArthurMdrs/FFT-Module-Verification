// DPI stuff
typedef struct {
    real array [16][2];
} DpiStructGEN;

import "DPI-C" context fft_cpp = function void fft (inout DpiStructGEN dpiStruct);

// UVM class
class fft_16_4_refmod extends uvm_component;

    `uvm_component_utils(fft_16_4_refmod)

    uvm_get_port #(fft_16_4_in_packet) data_in;

    uvm_blocking_put_port #(DpiStructGEN) data_out;

    int no_received;

    function new(string name, uvm_component parent=null);
        super.new(name, parent);
        data_in  = new("data_in" , this);
        data_out = new("data_out", this);
    endfunction : new
    
    virtual task run_phase (uvm_phase phase);
        fft_16_4_in_packet  pkt_in;
        DpiStructGEN arr_out;
        bit [1:0] k;
        real scale = 2.0**-7;
        DpiStructGEN dpiStruct;
        
        forever begin
            data_in.get(pkt_in);
            // `uvm_info("REFERENCE MODEL", $sformatf("Packet collected:\n%s", pkt_in.convert2string()), UVM_NONE)
            case (k)
                0: begin
                    dpiStruct.array[0][0] = pkt_in.i_data_1_real * scale;
                    dpiStruct.array[0][1] = pkt_in.i_data_1_imag * scale;
                    dpiStruct.array[1][0] = pkt_in.i_data_2_real * scale;
                    dpiStruct.array[1][1] = pkt_in.i_data_2_imag * scale;
                    dpiStruct.array[2][0] = pkt_in.i_data_3_real * scale;
                    dpiStruct.array[2][1] = pkt_in.i_data_3_imag * scale;
                    dpiStruct.array[3][0] = pkt_in.i_data_4_real * scale;
                    dpiStruct.array[3][1] = pkt_in.i_data_4_imag * scale;
                end
                1: begin
                    dpiStruct.array[4][0] = pkt_in.i_data_1_real * scale;
                    dpiStruct.array[4][1] = pkt_in.i_data_1_imag * scale;
                    dpiStruct.array[5][0] = pkt_in.i_data_2_real * scale;
                    dpiStruct.array[5][1] = pkt_in.i_data_2_imag * scale;
                    dpiStruct.array[6][0] = pkt_in.i_data_3_real * scale;
                    dpiStruct.array[6][1] = pkt_in.i_data_3_imag * scale;
                    dpiStruct.array[7][0] = pkt_in.i_data_4_real * scale;
                    dpiStruct.array[7][1] = pkt_in.i_data_4_imag * scale;
                end
                2: begin
                    dpiStruct.array[8][0] = pkt_in.i_data_1_real * scale;
                    dpiStruct.array[8][1] = pkt_in.i_data_1_imag * scale;
                    dpiStruct.array[9][0] = pkt_in.i_data_2_real * scale;
                    dpiStruct.array[9][1] = pkt_in.i_data_2_imag * scale;
                    dpiStruct.array[10][0] = pkt_in.i_data_3_real * scale;
                    dpiStruct.array[10][1] = pkt_in.i_data_3_imag * scale;
                    dpiStruct.array[11][0] = pkt_in.i_data_4_real * scale;
                    dpiStruct.array[11][1] = pkt_in.i_data_4_imag * scale;
                end
                3: begin
                    dpiStruct.array[12][0] = pkt_in.i_data_1_real * scale;
                    dpiStruct.array[12][1] = pkt_in.i_data_1_imag * scale;
                    dpiStruct.array[13][0] = pkt_in.i_data_2_real * scale;
                    dpiStruct.array[13][1] = pkt_in.i_data_2_imag * scale;
                    dpiStruct.array[14][0] = pkt_in.i_data_3_real * scale;
                    dpiStruct.array[14][1] = pkt_in.i_data_3_imag * scale;
                    dpiStruct.array[15][0] = pkt_in.i_data_4_real * scale;
                    dpiStruct.array[15][1] = pkt_in.i_data_4_imag * scale;

                    // foreach(dpiStruct.array[i])
                    //     $display("idx %0d: %f, %f", i, dpiStruct.array[i][0], dpiStruct.array[i][1]);
                    fft (dpiStruct);
                    // foreach(dpiStruct.array[i])
                    //     $display("idx %0d: %f, %f", i, dpiStruct.array[i][0], dpiStruct.array[i][1]);

                    arr_out = dpiStruct;
                    data_out.put(arr_out);
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