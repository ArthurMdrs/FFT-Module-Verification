module top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // VIP imports - begin
        import fft_16_4_in_pkg::*;
        import fft_16_4_out_pkg::*;
    // VIP imports - end

    `include "tests.sv"

    bit clk, rst_sync_n;
    bit run_clock;

    // localparam int  INPUT_WIDTH = 8;

    // Interfaces instances - begin
        fft_16_4_in_if if_fft_16_4_in(.clk(clk), .rst_sync_n(rst_sync_n));
        fft_16_4_out_if if_fft_16_4_out(.clk(clk), .rst_sync_n(rst_sync_n));
    // Interfaces instances - end


    // stub dut(
    //     .clk(clk),
    //     .rst_sync_n(rst_sync_n),
    //     // Signals from fft_16_4_in's interface - begin
    //         .i_valid(if_fft_16_4_in.i_valid),
    //         .i_data[4][2](if_fft_16_4_in.i_data[4][2]),
    //     // Signals from fft_16_4_in's interface - end

    //     // Signals from fft_16_4_out's interface - begin
    //         .o_valid(if_fft_16_4_out.o_valid),
    //         .o_data[16][2](if_fft_16_4_out.o_data[16][2])
    //     // Signals from fft_16_4_out's interface - end
    // );

    initial begin
        clk = 0;
        rst_sync_n = 1;
        #3 rst_sync_n = 0;
        #5 rst_sync_n = 1;
    end
    always #2 clk=~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        // Virtual interfaces send to VIPs - begin
            fft_16_4_in_vif_config::set(null, "uvm_test_top.agent_fft_16_4_in.*", "vif", if_fft_16_4_in);
            fft_16_4_out_vif_config::set(null, "uvm_test_top.agent_fft_16_4_out.*", "vif", if_fft_16_4_out);
        // Virtual interfaces send to VIPs - end

        run_test();
    end

endmodule: top
