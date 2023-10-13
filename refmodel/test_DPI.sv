// Element 0 is real, element 1 is imaginary
typedef struct {
  real operands [16][2];
  real results  [16][2];
} DpiStructGEN;

import "DPI-C" context cpp_set = function void set (inout DpiStructGEN dpiStruct);
import "DPI-C" context cpp_fft = function void fft (inout DpiStructGEN dpiStruct);

module test_DPI ();

    DpiStructGEN dpiStruct;

    initial begin
        set (dpiStruct);
        $display("Operands set.");
        // foreach (dpiStruct.operands[i]) begin
        //     $write("Operand %2d is %.2f + %.2fj\t\t", i, dpiStruct.operands[i][0], dpiStruct.operands[i][1]);
        //     $display(" Result %2d is %.2f + %.2fj", i, dpiStruct.results[i][0], dpiStruct.results[i][1]);
        // end
        
        fft (dpiStruct);
        $display("Results set.");
        foreach (dpiStruct.operands[i]) begin
            $write("Operand %2d is %.2f + %.2fj\t\t", i, dpiStruct.operands[i][0], dpiStruct.operands[i][1]);
            $display(" Result %2d is %.2f + %.2fj", i, dpiStruct.results[i][0], dpiStruct.results[i][1]);
        end
    end

endmodule
