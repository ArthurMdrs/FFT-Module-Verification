/*
	This module does the butterfly computation for signed 
    fixed-point numbers. N is the number of samples, which
    must be a power of 2. WIDTH is the width of the numbers.
*/

module butterfly #(
  int N = 4, // Must be a power of 2
  int WIDTH = 12
) 
(
  input  logic signed [WIDTH-1:0] evens[N/2][2], 
  input  logic signed [WIDTH-1:0] odds [N/2][2], 
  output logic signed [WIDTH-1:0] out [N][2]
);
  
  // Angle of the twiddle factor
  real theta = 2*$acos(-1.0)/N;
  
  // Calculations
  always_comb 
    for (int i = 0; i < N/2; i++) begin
      out[i][0] = evens[i][0] + $cos(i*theta)*odds[i][0] - 
      				$sin(i*theta)*odds[i][1];
      out[i][1] = evens[i][1] + $sin(i*theta)*odds[i][0] + 
      				$cos(i*theta)*odds[i][1];
      out[i+N/2][0] = evens[i][0] - $cos(i*theta)*odds[i][0] + 
      				$sin(i*theta)*odds[i][1];
      out[i+N/2][1] = evens[i][1] - $sin(i*theta)*odds[i][0] - 
      				$cos(i*theta)*odds[i][1];
    end
      
endmodule
