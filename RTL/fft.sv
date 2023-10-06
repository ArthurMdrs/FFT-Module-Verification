/*
	This module does the FFT computation for signed fixed-
    point numbers. N is the number of samples, which must
    be a power of 2. WIDTH is the width of the numbers. 
*/

`include "butterfly.sv"

module fft #(
  int N = 4, // Must be a power of 2
  int WIDTH = 12
)
(
  input  logic signed [WIDTH-1:0] inputs  [N][2],
  output logic signed [WIDTH-1:0] outputs [N][2] 
);
  
  if (N > 1) begin
    logic signed [WIDTH-1:0] in_evens [N/2][2], in_odds [N/2][2]; 
    logic signed [WIDTH-1:0] out_evens[N/2][2], out_odds[N/2][2];
    
    // Separating the evens and odds elements of the input.
    always_comb 
      for (int i = 0; i < N/2; i++) begin 
        in_evens[i][0] = inputs[2*i][0];
        in_odds [i][0] = inputs[2*i+1][0];
        in_evens[i][1] = inputs[2*i][1];
        in_odds [i][1] = inputs[2*i+1][1];
      end
    
    // Recursive action
    fft #(N/2, WIDTH) FFT_evens (in_evens, out_evens); 
    fft #(N/2, WIDTH) FFT_odds  (in_odds,  out_odds);
    
    // Butterfly calculation
    butterfly #(N, WIDTH) m_butterfly (out_evens, out_odds, outputs);
  end
  else
    assign outputs = inputs;
  
endmodule
