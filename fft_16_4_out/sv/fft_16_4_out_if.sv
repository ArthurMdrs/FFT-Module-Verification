    interface fft_16_4_out_if #(int OUTPUT_WIDTH = 12) (input clk, input rst_sync_n );

        import uvm_pkg::*;    
        `include "uvm_macros.svh"
        import fft_16_4_out_pkg::*;

        // Interface Signals - Begin
        logic  o_valid;
        logic signed [OUTPUT_WIDTH-1:0] o_data[16][2];
        // Interface Signals - End

        // Signals for transaction recording
        bit monstart, drvstart;      

        task fft_16_4_out_reset();
            @(negedge rst_sync_n);
            monstart = 0;
            drvstart = 0;
            disable send_to_dut;
        endtask

        // Gets a packet and drive it into the DUT
        task send_to_dut(fft_16_4_out_packet req);
            
            $display("This is an output interface! Cannot send to DUT!");

        endtask : send_to_dut

        // Collect Packets
        task collect_packet(output logic signed [OUTPUT_WIDTH-1:0] data[16][2]);
            // Logic to start recording transaction
            @(negedge clk iff (o_valid && o_data !== data));
            // trigger for transaction recording
            monstart = 1'b1;

            data = o_data;

            @(negedge clk);

            // Reset trigger
            monstart = 1'b0;
        endtask : collect_packet

    endinterface : fft_16_4_out_if
    