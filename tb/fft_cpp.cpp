#include <stdio.h>
#include <vector>
#include <cmath>
using namespace std;

/////////////////////////////////////////////////////////////////
class complex_int {
    public:
        int real;
        int imag;
    complex_int(int = 0, int = 0);
};

complex_int::complex_int (int real, int imag){
    this->real = real;
    this->imag = imag;
}
/////////////////////////////////////////////////////////////////

typedef struct {
    int array [16][2];
} DpiStructGEN;

void fft_aux (vector<complex_int> &, vector<complex_int> &);

extern "C" void fft_cpp (DpiStructGEN *dpiStruct) {    
    vector<complex_int> vec_i;
    vector<complex_int> vec_o;

    for (int i = 0; i < 16; i++){
        complex_int a (dpiStruct->array[i][0], dpiStruct->array[i][1]);
        vec_i.push_back(a);
    }

    fft_aux(vec_i, vec_o);
    
    // for (int i = 0; i < 16; i++){
    //     printf("input %8x, %8x\t\toutput %8x, %8x\n", vec_i[i].real, vec_i[i].imag, vec_o[i].real >> 3, vec_o[i].imag >> 3);
    // }

    for (int i = 0; i < 16; i++){
        dpiStruct->array[i][0] = vec_o[i].real >> 3;
        dpiStruct->array[i][1] = vec_o[i].imag >> 3;
    }

}



// https://cp-algorithms.com/algebra/fft.html
void fft_aux (vector<complex_int> & P, vector<complex_int> & res) {
    int n = P.size();
    res = vector<complex_int> (n);
    
    if (n == 1){
        res[0] = P[0];
        return;
    }

    vector<complex_int> evens_i(n/2), odds_i(n/2);
    vector<complex_int> evens_o(n/2), odds_o(n/2);

    for (int i = 0; 2 * i < n; i++) {
        evens_i[i] = P[2*i];
        odds_i[i] = P[2*i+1];
    }

    fft_aux(evens_i, evens_o);
    fft_aux(odds_i, odds_o);
    
    double theta = 2*M_PI/n;

    for (int i = 0; i < n/2; i++) {
      res[i].real     = evens_o[i].real + cos(i*theta)*odds_o[i].real - sin(i*theta)*odds_o[i].imag;
      res[i].imag     = evens_o[i].imag + sin(i*theta)*odds_o[i].real + cos(i*theta)*odds_o[i].imag;
      res[i+n/2].real = evens_o[i].real - cos(i*theta)*odds_o[i].real + sin(i*theta)*odds_o[i].imag;
      res[i+n/2].imag = evens_o[i].imag - sin(i*theta)*odds_o[i].real - cos(i*theta)*odds_o[i].imag;
    }

    return;
}