    interface fft_16_4_in_if #(int INPUT_WIDTH = 8) (input clk, input rst_sync_n );

        import uvm_pkg::*;    
        `include "uvm_macros.svh"
        import fft_16_4_in_pkg::*;

        // Interface Signals - Begin
        logic  i_valid;
        logic signed [INPUT_WIDTH-1:0] i_data[4][2];
        // Interface Signals - End

        // Signals for transaction recording
        bit monstart, drvstart;
        
        // Signal to control monitor activity
        bit got_packet;
        // Test packet
        fft_16_4_in_packet pkt = new("PKT");

        task fft_16_4_in_reset();
            @(negedge rst_sync_n);
            monstart = 0;
            drvstart = 0;
            disable send_to_dut;
        endtask

        // Gets a packet and drive it into the DUT
        task send_to_dut(fft_16_4_in_packet req);
            // Logic to start recording transaction
            @(negedge clk);

            // trigger for transaction recording
            drvstart = 1'b1;

            // Drive logic 
            pkt.copy(req);
            `uvm_info("FFT_16_4_IN INTERFACE", $sformatf("Driving packet to DUT:%s", pkt.convert2string()), UVM_HIGH)
            got_packet = 1'b1;
            @(negedge clk);

            // Reset trigger
            drvstart = 1'b0;
        endtask : send_to_dut

        // Collect Packets
        task collect_packet(fft_16_4_in_packet req);
            // Logic to start recording transaction
            @(posedge clk iff got_packet);
            got_packet = 1'b0;
            
            // trigger for transaction recording
            monstart = 1'b1;

            // Collect logic 
            req.copy(pkt);
            `uvm_info("FFT_16_4_IN INTERFACE", $sformatf("Collected packet:%s", req.convert2string()), UVM_HIGH)
            @(posedge clk);

            // Reset trigger
            monstart = 1'b0;
        endtask : collect_packet

    endinterface : fft_16_4_in_if
    