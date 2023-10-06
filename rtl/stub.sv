module stub (input clk, input rst_sync_n, 
    // Signals from fft_16_4_in's interface - begin
        NOTYPE      i_valid,
        NOTYPE     [INPUT_WIDTH-1:0] i_data[4][2],
    // Signals from fft_16_4_in's interface - end

    // Signals from fft_16_4_out's interface - begin
        NOTYPE      o_valid,
        NOTYPE     [OUTPUT_WIDTH-1:0] o_data[16][2]
    // Signals from fft_16_4_out's interface - end
    );

    always @(posedge clk or negedge rst_sync_n) begin
        if(~rst_sync_n) begin
            // Reset logic
        end
        else begin
            // Sequencial logic
        end
    end

    always @(*) begin
        // Combinational logic
    end

endmodule: stub
