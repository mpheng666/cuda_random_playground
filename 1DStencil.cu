__gloabl__.void stencil_1d(int *in, int *out)
{
    __shared__ int temp[BLOCL_SIZE + 2 * RADIUS];
    int gindex = threadIdx.x + blockIdx.x * blockDim.x;
    int lindex = threadIdx.x + RADIUS;

    // Read input elements into shared memory
    temp[lindex] = in[gindex];

    // To fill up the most front and back empty RADIUS memory
    if(threadIdx.x < RADIUS)
    {
        temp[lindex - RADIUS] = in[gindex - RADIUS];
        temp[lindex + BLOCK_SIZE] = in[gindex + BLOCK_SIZE];
    }

    // To prevent data race
    // Synchronize first
    __syncthreads();

    // Apply the stencil
    int result = 0;
    for(int offset = -RADIUS; offset <=RADIUS; offset++)
    {
        // Did not access global memory, using shared memory
        result += temp[lindex + offset];
    }

    // Store the result
    out[gindex] = result;
}

int main()
{
    return 0;
}