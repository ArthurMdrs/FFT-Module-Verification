class fft_16_4_out_monitor extends uvm_monitor;

    `uvm_component_utils(fft_16_4_out_monitor)

    fft_16_4_out_vif vif;
    fft_16_4_out_packet pkt;
    int num_pkt_col;

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
                    vif.collect_packet(pkt);
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
