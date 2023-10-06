/*
	This module implements the size-16 Fast Fourier Transform (FFT).
    - Inputs:
    	The data inputs are complex, with the element 0 being the real 
    part and the element 1 the imaginary. The module takes 4 samples 
    at a time, meaning it takes 4 clock cycles to acquire the full 16
    samples. The input numbers are to be interpreted as fixed-point,
    with 1 integer bit (represents the signal) and 7 fractional 
    bits. So the range is [-1, 1) with a precision of 2^(-7).
    	The input i_valid indicates there is a valid data input to be
    processed.
    	clk is the clock and rst_sync_n is the reset (synchronous and
    active-low).
    -Output:
    	The data outputs are complex, with the element 0 being the real 
    part and the element 1 the imaginary. The module produces all 16 
    samples at the same time. The output numbers are to be interpreted 
    as fixed-point, with 8 integer bit (1 for the signal) and 4 
    fractional bits. So the range is [-128, 128) with a precision of 
    2^(-4).
    	The output o_valid indicates there is a valid data output. 
*/

`include "fft.sv"

module fft_16_4 #(
  int INPUT_WIDTH = 8,
  int OUTPUT_WIDTH = INPUT_WIDTH + 4
)
(
  output logic o_valid,
  output logic signed [OUTPUT_WIDTH-1:0] o_data[16][2],
  input logic i_valid,
  input logic signed [INPUT_WIDTH-1:0] i_data[4][2],
  input logic clk,
  input logic rst_sync_n
);
  
  // Defining a fixed width for the numbers in the fft modules.
  // There are 2 extra bits for each step in the recursion.
  localparam EXTRA_BITS = 2*$clog2(16); 
  localparam GENERAL_WIDTH = INPUT_WIDTH + EXTRA_BITS;
  
  logic signed [GENERAL_WIDTH-1:0] inputs  [16][2];
  logic signed [GENERAL_WIDTH-1:0] outputs [16][2];
  
  // Instantiation of the recursive FFT module
  fft #(16, GENERAL_WIDTH) myFFT (inputs, outputs);
  
  int k;
  logic state;
  
  // This module is sensitive to the clock's positive edge.
  always_ff @ (posedge clk)
    // Synchronous active-low reset
    if (~rst_sync_n) begin
      state <= 0;
      o_valid <= 0;
      foreach (o_data[i]) 
        o_data[i] <= {{OUTPUT_WIDTH{1'b0}}, {OUTPUT_WIDTH{1'b0}}};
      k <= 0;
    end
  	// The state machine only works when i_valid = HIGH
  	else if (i_valid)
      case (state)
        0: begin
          if (k == 3) state <= 1;
          else k <= k + 1;          
          for (int i = 0; i < 4; i++) begin
            inputs[i+k*4][0] <= {{EXTRA_BITS{i_data[i][0][INPUT_WIDTH-1]}}, i_data[i][0]};
            inputs[i+k*4][1] <= {{EXTRA_BITS{i_data[i][1][INPUT_WIDTH-1]}}, i_data[i][1]};
          end          
          o_valid <= 1'b0;
        end
        1: begin
          foreach (o_data[i])
            foreach (o_data[i][j])
              o_data[i][j] <= outputs[i][j] >>> 3;
          // We shift the outputs to the right by 3 because the 
          // input has 7 fractional bits while the output only has 4.
          o_valid <= 1'b1;
          state <= 0;
          k <= 0;
        end
      endcase
  	else begin
      k <= 0;
      state <= 0;
    end
  
endmodule
