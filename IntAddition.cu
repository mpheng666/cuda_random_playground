// Function that runs on the GPU is called a kernel
// add() runs on the device, a,b,c must point to device memory
// May be passed to/from host code, may not be dereference in host code
__global__ void add(int *a, int *b, int *c)
{
    *c = *a + *b;
}

// Memory handling API
// cudaMalloc()
// cudaFree()
// cudaMemcpy()

int main()
{
    int a, b, c;                // Host copies
    int *d_a, *d_b, *d_c;       // Device copies
    int size = sizeof(int);

    // Allocate space for device copies
    // ** because it is a returned value of a pointer (address of pointer)
    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_b, size);
    cudaMalloc((void**)&d_c, size);

    a = 3;
    b = 100;

    // copy inputs to device
    cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

    // add<<<N_times, 1>>>()
    add<<<1,1>>>(d_a, d_b, d_c);

    // copy result back to host
    cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

    // cleanup
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}