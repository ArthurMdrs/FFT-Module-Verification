# Vector that specifies the packet's attributes
packet_vec = [
  [false, "bit", "", "o_valid"],
  [true , "int", "", "o_data_1_real"], 
  [true , "int", "", "o_data_1_imag"], 
  [true , "int", "", "o_data_2_real"], 
  [true , "int", "", "o_data_2_imag"], 
  [true , "int", "", "o_data_3_real"], 
  [true , "int", "", "o_data_3_imag"], 
  [true , "int", "", "o_data_4_real"], 
  [true , "int", "", "o_data_4_imag"],
  [true , "int", "", "o_data_5_real"], 
  [true , "int", "", "o_data_5_imag"], 
  [true , "int", "", "o_data_6_real"], 
  [true , "int", "", "o_data_6_imag"], 
  [true , "int", "", "o_data_7_real"], 
  [true , "int", "", "o_data_7_imag"], 
  [true , "int", "", "o_data_8_real"], 
  [true , "int", "", "o_data_8_imag"],
  [true , "int", "", "o_data_9_real"], 
  [true , "int", "", "o_data_9_imag"], 
  [true , "int", "", "o_data_10_real"], 
  [true , "int", "", "o_data_10_imag"], 
  [true , "int", "", "o_data_11_real"], 
  [true , "int", "", "o_data_11_imag"], 
  [true , "int", "", "o_data_12_real"], 
  [true , "int", "", "o_data_12_imag"],
  [true , "int", "", "o_data_13_real"], 
  [true , "int", "", "o_data_13_imag"], 
  [true , "int", "", "o_data_14_real"], 
  [true , "int", "", "o_data_14_imag"], 
  [true , "int", "", "o_data_15_real"], 
  [true , "int", "", "o_data_15_imag"], 
  [true , "int", "", "o_data_16_real"], 
  [true , "int", "", "o_data_16_imag"]
]

# Vector that specifies the interface's signals
signals_if_config = [
  ["logic", "", "o_valid"],
  ["logic signed", "[OUTPUT_WIDTH-1:0]", "o_data[16][2]"]]

# Variable that defines if reset is active low or high
rst_is_negedge_sensitive = true

# Vector that defines clock and reset names
if_vec = ["clk", ["rst_sync_n", rst_is_negedge_sensitive], signals_if_config]

# UNCOMMENT ONLY IF NECESSARY!!!
# This will overwrite the vectors defined in global_vectors.jl
# Check the documentation's "How to use" section for more info
#
# Variables that define which classes will be included in the package
# pkg_classes.packet = false
# pkg_classes.sequence_lib = false
# pkg_classes.monitor = false
# pkg_classes.sequencer = false
# pkg_classes.driver = false
# pkg_classes.coverage = false
# pkg_classes.agent = false
#
# Variables that define which classes will be generated as files
# gen_classes.packet = false
# gen_classes.sequence_lib = false
# gen_classes.monitor = false
# gen_classes.sequencer = false
# gen_classes.driver = false
# gen_classes.coverage = false
# gen_classes.agent = false
# gen_classes.pkg = false
# gen_classes.interface = false
#
# UNCOMMENT ONLY IF NECESSARY!!!