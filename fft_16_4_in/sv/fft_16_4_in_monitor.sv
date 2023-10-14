class fft_16_4_in_monitor extends uvm_monitor;

    `uvm_component_utils(fft_16_4_in_monitor)

    fft_16_4_in_vif vif;
    fft_16_4_in_packet pkt;
    int num_pkt_col;
    logic signed [7:0] data_sent[4][2];

    uvm_analysis_port #(fft_16_4_in_packet) item_collected_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        num_pkt_col = 0;
        item_collected_port = new("item_collected_port", this);
    endfunction: new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(fft_16_4_in_vif_config::get(this, "", "vif", vif))
            `uvm_info("FFT_16_4_IN MONITOR", "Virtual interface was successfully set!", UVM_MEDIUM)
        else
            `uvm_error("FFT_16_4_IN MONITOR", "No interface was set!")        
    endfunction: build_phase

    virtual task run_phase (uvm_phase phase);
        super.run_phase(phase);
        @(negedge vif.rst_sync_n);
        @(posedge vif.rst_sync_n);

        `uvm_info("FFT_16_4_IN MONITOR", "Reset dropped", UVM_MEDIUM)

        forever begin
            pkt = fft_16_4_in_packet::type_id::create("pkt", this);

            // concurrent blocks for packet collection and transaction recording
            fork
                // collect packet
                begin
                    // collect packet from interface
                    vif.collect_packet(data_sent);
                    
                    pkt.i_data_1_real = {'0, data_sent[0][0]};
                    pkt.i_data_1_imag = {'0, data_sent[0][1]};
                    pkt.i_data_2_real = {'0, data_sent[1][0]};
                    pkt.i_data_2_imag = {'0, data_sent[1][1]};
                    pkt.i_data_3_real = {'0, data_sent[2][0]};
                    pkt.i_data_3_imag = {'0, data_sent[2][1]};
                    pkt.i_data_4_real = {'0, data_sent[3][0]};
                    pkt.i_data_4_imag = {'0, data_sent[3][1]};
                end

                // Start transaction recording at start of packet (vif.monstart triggered from interface.collect_packet())
                begin
                    @(posedge vif.monstart) void'(begin_tr(pkt, "FFT_16_4_IN_monitor_Packet"));
                end
            join

            end_tr(pkt);
            `uvm_info("FFT_16_4_IN MONITOR", $sformatf("Packet Collected:\n%s", pkt.convert2string()), UVM_LOW)
            item_collected_port.write(pkt);
            num_pkt_col++;
        end
    endtask : run_phase

    function void start_of_simulation_phase (uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info("FFT_16_4_IN MONITOR", "Simulation initialized", UVM_HIGH)
    endfunction: start_of_simulation_phase

    function void report_phase(uvm_phase phase);
        `uvm_info("FFT_16_4_IN MONITOR", $sformatf("Report: FFT_16_4_IN MONITOR collected %0d packets", num_pkt_col), UVM_LOW)
    endfunction : report_phase

endclass: fft_16_4_in_monitor
