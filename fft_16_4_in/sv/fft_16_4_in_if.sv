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

        task fft_16_4_in_reset();
            @(negedge rst_sync_n);
            monstart = 0;
            drvstart = 0;
            foreach (i_data[i])
                i_data[i] = {'x, 'x};
            i_valid = 0;
            disable send_to_dut;
        endtask

        // Gets a packet and drive it into the DUT
        task send_to_dut(input logic signed [INPUT_WIDTH-1:0] data[4][2]);
            // Logic to start recording transaction
            @(negedge clk);
            // trigger for transaction recording
            drvstart = 1'b1;
            
            i_data = data;
            i_valid = 1;

            got_packet = 1'b1;
            @(negedge clk);
            i_valid = 0;

            // Reset trigger
            drvstart = 1'b0;
        endtask : send_to_dut

        // Collect Packets
        task collect_packet(output logic signed [INPUT_WIDTH-1:0] data[4][2]);
            // Logic to start recording transaction
            @(posedge clk iff got_packet);
            got_packet = 1'b0;            
            // trigger for transaction recording
            monstart = 1'b1;

            // Collect logic
            data = i_data;

            @(posedge clk);

            // Reset trigger
            monstart = 1'b0;
        endtask : collect_packet

    endinterface : fft_16_4_in_if
    