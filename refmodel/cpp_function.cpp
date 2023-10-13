#include <stdio.h>

typedef struct {
    double operands [16][2];
    double results  [16][2];
} DpiStructGEN;

extern "C" void cpp_set (DpiStructGEN *dpiStruct) {
    for (int i = 0; i < 16; i++){
        dpiStruct->operands[i][0] = i;
        dpiStruct->operands[i][1] = 0;
    }
}

extern "C" void cpp_fft (DpiStructGEN *dpiStruct) {
    for (int i = 0; i < 16; i++){
        dpiStruct->results[i][0] = dpiStruct->operands[i][1];
        dpiStruct->results[i][1] = dpiStruct->operands[i][0];
    }
}