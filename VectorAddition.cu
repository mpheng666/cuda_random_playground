# define N (2048*2048)
#define THREADS_PER_BLOCK 512

__global__ void add(int *a, int *b, int *c, int n)
{
    // // blockIdc.x magic variabele to access block index
    // c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];

    // // Use thread instead
    // c[threadIdx.x] = a[threadIdx.x] + b[threadIdx.x];

    // Use parallel threads and parallel blocks
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    // Typical problems are not whole multiples of blockDim.x
    // Avid accessing beyond the end of the arrays
    if(index<n)
    {
        c[index] = a[index] + b[index];
    }
}

void random_ints(int* a, int N)
{
   int i;
   for (i = 0; i < N; ++i)
    a[i] = rand();
}

int main()
{
    int *a, *b, *c;                // Host copies
    int *d_a, *d_b, *d_c;       // Device copies
    int size = N * sizeof(int);

    // Allocate space for device copies
    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_b, size);
    cudaMalloc((void**)&d_c, size);

    // Allocate space for host copies and setup input values
    a = (int *)malloc(size); random_ints(a, N);
    b = (int *)malloc(size); random_ints(b, N);
    c = (int *)malloc(size);

    // copy inputs to device
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    // add<<<blocks, threads>>>()
    // add<<<N,1>>>(d_a, d_b, d_c);
    add<<<N/THREADS_PER_BLOCK ,THREADS_PER_BLOCK>>>(d_a, d_b, d_c, N);
    // add<<<(N + M-1)/M, M>>>(d_a, d_b, d_c, N);

    // copy result back to host
    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    // cleanup
    free(a); free(b); free(c);
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}