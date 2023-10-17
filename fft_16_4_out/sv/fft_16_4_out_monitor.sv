class fft_16_4_out_monitor extends uvm_monitor;

    `uvm_component_utils(fft_16_4_out_monitor)

    fft_16_4_out_vif vif;
    fft_16_4_out_packet pkt;
    int num_pkt_col;
    logic signed [11:0] data_received[16][2];

    uvm_analysis_port #(fft_16_4_out_packet) item_collected_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        num_pkt_col = 0;
        item_collected_port = new("item_collected_port", this);
    endfunction: new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(fft_16_4_out_vif_config::get(this, "", "vif", vif))
            `uvm_info("FFT_16_4_OUT MONITOR", "Virtual interface was successfully set!", UVM_MEDIUM)
        else
            `uvm_error("FFT_16_4_OUT MONITOR", "No interface was set!")        
    endfunction: build_phase

    virtual task run_phase (uvm_phase phase);
        super.run_phase(phase);
        @(negedge vif.rst_sync_n);
        @(posedge vif.rst_sync_n);

        `uvm_info("FFT_16_4_OUT MONITOR", "Reset dropped", UVM_MEDIUM)

        forever begin
            pkt = fft_16_4_out_packet::type_id::create("pkt", this);

            // concurrent blocks for packet collection and transaction recording
            fork
                // collect packet
                begin
                    // collect packet from interface
                    vif.collect_packet(data_received);
                    
                    pkt.o_data_1_real = data_received[0][0];
                    pkt.o_data_1_imag = data_received[0][1];
                    pkt.o_data_2_real = data_received[1][0];
                    pkt.o_data_2_imag = data_received[1][1];
                    pkt.o_data_3_real = data_received[2][0];
                    pkt.o_data_3_imag = data_received[2][1];
                    pkt.o_data_4_real = data_received[3][0];
                    pkt.o_data_4_imag = data_received[3][1];
                    pkt.o_data_5_real = data_received[4][0];
                    pkt.o_data_5_imag = data_received[4][1];
                    pkt.o_data_6_real = data_received[5][0];
                    pkt.o_data_6_imag = data_received[5][1];
                    pkt.o_data_7_real = data_received[6][0];
                    pkt.o_data_7_imag = data_received[6][1];
                    pkt.o_data_8_real = data_received[7][0];
                    pkt.o_data_8_imag = data_received[7][1];
                    pkt.o_data_9_real = data_received[8][0];
                    pkt.o_data_9_imag = data_received[8][1];
                    pkt.o_data_10_real = data_received[9][0];
                    pkt.o_data_10_imag = data_received[9][1];
                    pkt.o_data_11_real = data_received[10][0];
                    pkt.o_data_11_imag = data_received[10][1];
                    pkt.o_data_12_real = data_received[11][0];
                    pkt.o_data_12_imag = data_received[11][1];
                    pkt.o_data_13_real = data_received[12][0];
                    pkt.o_data_13_imag = data_received[12][1];
                    pkt.o_data_14_real = data_received[13][0];
                    pkt.o_data_14_imag = data_received[13][1];
                    pkt.o_data_15_real = data_received[14][0];
                    pkt.o_data_15_imag = data_received[14][1];
                    pkt.o_data_16_real = data_received[15][0];
                    pkt.o_data_16_imag = data_received[15][1];
                end

                // Start transaction recording at start of packet (vif.monstart triggered from interface.collect_packet())
                begin
                    @(posedge vif.monstart) void'(begin_tr(pkt, "FFT_16_4_OUT_monitor_Packet"));
                end
            join

            end_tr(pkt);
            `uvm_info("FFT_16_4_OUT MONITOR", $sformatf("Packet Collected:\n%s", pkt.convert2string()), UVM_LOW)
            item_collected_port.write(pkt);
            num_pkt_col++;
        end
    endtask : run_phase

    function void start_of_simulation_phase (uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info("FFT_16_4_OUT MONITOR", "Simulation initialized", UVM_HIGH)
    endfunction: start_of_simulation_phase

    function void report_phase(uvm_phase phase);
        `uvm_info("FFT_16_4_OUT MONITOR", $sformatf("Report: FFT_16_4_OUT MONITOR collected %0d packets", num_pkt_col), UVM_LOW)
    endfunction : report_phase

endclass: fft_16_4_out_monitor
