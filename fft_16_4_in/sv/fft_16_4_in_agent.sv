import cover_enable_pkg::*;

class fft_16_4_in_agent extends uvm_agent;

    uvm_active_passive_enum is_active = UVM_ACTIVE;
    cover_e cov_control = COV_ENABLE;

    `uvm_component_utils_begin(fft_16_4_in_agent)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
        `uvm_field_enum(cover_e, cov_control, UVM_ALL_ON)
    `uvm_component_utils_end

    fft_16_4_in_monitor     monitor;
    fft_16_4_in_driver      driver;
    fft_16_4_in_sequencer   sequencer;
    fft_16_4_in_coverage    coverage;

    uvm_analysis_port #(fft_16_4_in_packet) item_from_monitor_port;

    function new (string name, uvm_component parent);
        super.new(name, parent);
        item_from_monitor_port = new("item_from_monitor_port", this);
    endfunction : new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        monitor       = fft_16_4_in_monitor::type_id::create("monitor", this);
        if (is_active == UVM_ACTIVE) begin
            if (cov_control == COV_DISABLE) begin
                uvm_config_db#(int)::set(this, "sequencer", "cov_control", COV_DISABLE);
            end
            sequencer = fft_16_4_in_sequencer::type_id::create("sequencer", this);
            driver    = fft_16_4_in_driver::type_id::create("driver", this);
        end

        if (cov_control == COV_ENABLE) begin
            coverage = fft_16_4_in_coverage::type_id::create("coverage", this);
            `uvm_info("FFT_16_4_IN AGENT", "Coverage is enabled." , UVM_LOW) 
        end else begin
            `uvm_info("FFT_16_4_IN AGENT", "Coverage is disabled." , UVM_LOW)
        end
    endfunction : build_phase

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);

        monitor.item_collected_port.connect(item_from_monitor_port);
        
        if (is_active == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end

        if (cov_control == COV_ENABLE) begin
            monitor.item_collected_port.connect(coverage.analysis_export);
            sequencer.from_cov_get_port.connect(coverage.cov_to_seq_get_imp);
        end
    endfunction : connect_phase

    function void start_of_simulation_phase (uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info("FFT_16_4_IN AGENT", "Simulation initialized", UVM_HIGH)
    endfunction : start_of_simulation_phase

endclass : fft_16_4_in_agent
