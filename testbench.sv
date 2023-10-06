`timescale 1us / 1ns

// Testbench
module tb();
  logic o_valid, i_valid, clk, rst_sync_n;
  logic signed [7:0] i_data[4][2];
  logic signed [11:0] o_data[16][2];
  
  localparam scale_out = 2.0**-4.0;
  localparam scale_in = 2.0**-7;
  
  int seed = 1; // Seed for the RNG
  
  // Instantiation of our module
  fft_16_4 MyMod (.*);
  
  // Creating the clock signal
  initial begin
    clk = 0;
    forever #1 clk = ~clk; // Clock period = 2 us
  end
  
  // Simulation
  initial begin
    // Printing o_valid signal
    $monitor ("At time %5t, o_valid = %b ", $time, o_valid);
    
    // Starting variables
    rst_sync_n = 0;
    i_valid = 1;
    foreach (i_data[i]) i_data[i][0:1] = {0,0};
    // The seed must be used only on the first instance of $random
    $random(seed);
    
    #2 rst_sync_n = 1; // Releasing reset 
    
    // Generating values:
    for (int j = 0; j < 4; j++) begin
      foreach (i_data[i]) begin
        i_data[i][0] = $random;
        i_data[i][1] = $random;
        $write ("i_data[%2d]= %f + i*(%f), ", 
                i+j*4, i_data[i][0]*scale_in, i_data[i][1]*scale_in);  
        if ((i+1) % 2 == 0) $write ("\n");
      end
      #2; 
    end
    
    // Visualizing the results:
    #2 foreach (o_data[i]) begin
      $write ("o_data[%2d]= %.4f + i*(%.4f), ", 
              i, o_data[i][0]*scale_out, o_data[i][1]*scale_out);
      if ((i+1) % 2 == 0) $write ("\n");
    end
    
    $display ("%f", $clog2(16));
    
    $finish;
  end
  
endmodule
    