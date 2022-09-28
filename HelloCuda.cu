// __global__ runs on the device, is called from host code
// Device function processed by NVIDIA compiler
// void return type, can pass in any params 
#include <stdio.h>

__global__ void mykernel(void)
{

}

// Host functions processed by standard compiler
int main(void)
{
    // <<<>>> marks a call from host code to device code
    // kernal launch
    // return to the parameters (1,1) in a moment
    // 1 block, 1 thread
    mykernel<<<1,1>>>();
    printf("Hello CUDA! \n");
    return 0;
}

// nvcc separates source code into host and device components