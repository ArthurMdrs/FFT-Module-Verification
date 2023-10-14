#include <stdio.h>

#include <Python.h>
#include <pythonrun.h> 
#include <bytearrayobject.h>

typedef struct {
    double operands [16][2];
    double results  [16][2];
} DpiStructGEN;

PyObject *pBlockObjectGEN;

extern "C" void cpp_set (DpiStructGEN *dpiStruct) {
    for (int i = 0; i < 16; i++){
        dpiStruct->operands[i][0] = i;
        dpiStruct->operands[i][1] = 0;
    }
}

// extern "C" void cpp_fft (DpiStructGEN *dpiStruct) {
//     for (int i = 0; i < 16; i++){
//         dpiStruct->results[i][0] = dpiStruct->operands[i][1];
//         dpiStruct->results[i][1] = dpiStruct->operands[i][0];
//     }
// }

//////////   PYTHON FUNCTIONS BELOW   //////////
extern "C" void gen_init_python(){ 
    char pydir[400];
    
    PyObject *pBlockWrapper, *pBlockClass;

    Py_Initialize();

    PyRun_SimpleString("import sys"); 
    strcpy(pydir, "sys.path.append('");
    strcat(pydir, "./"); 
    strcat(pydir, "')"); 
    PyRun_SimpleString(pydir);


    pBlockWrapper = PyImport_ImportModule("my_fft"); 
    if(pBlockWrapper == NULL){ 
        PyErr_Print(); 
        exit(1); 
    }

    pBlockClass = PyObject_GetAttrString(pBlockWrapper, "my_fft"); 
    assert(pBlockClass && PyCallable_Check(pBlockClass)); 



    pBlockObjectGEN = PyObject_CallObject(pBlockClass, NULL);
    if(pBlockObjectGEN  == NULL){ 
        PyErr_Print(); 
        exit(1); 
    }

    Py_XDECREF(pBlockWrapper);
    Py_XDECREF(pBlockClass);

}

extern "C" void cpp_fft (DpiStructGEN *dpiStruct){
    PyObject *pBlockMethod, *pMethodReturn;
    PyObject *a;
    PyObject *b;

    a = Py_BuildValue("f", dpiStruct->operands);
    b = Py_BuildValue("f", dpiStruct->results );

    pBlockMethod = Py_BuildValue("s", "set"); 
    assert(pBlockMethod != NULL); 

    pMethodReturn = PyObject_CallMethodObjArgs(
        pBlockObjectGEN, pBlockMethod, a, b, NULL);
    
    if(pMethodReturn == NULL){ 
        PyErr_Print(); 
        exit(1); 
    }

    Py_XDECREF(pBlockMethod  ); 
    Py_XDECREF(pMethodReturn );
    Py_XDECREF(a ); 
    Py_XDECREF(b ); 
}