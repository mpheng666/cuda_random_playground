# CUDA PROGRAMMING

- Single Instruction Multiple Threads (SIMT)
- Threads->Warps->Thread Blocks (lower programmable entity)->Grid

## Concepts

1. Heterogenous Computing
2. Blocks
3. Threads
4. Indexing
5. Shared memory
6. _syncthreads()
7. Asynchronous operation
8. Handling errors
9. Managing devices

### 1. Heterogenous Computing

- Host (CPU and its memory)
- Device (GPU and its memory)
- Simple Processing Flow
   1. Copy input data from CPU memory to GPU memory
   2. Load GPU program and execute, caching data on chip for performance
   3. Copy the results back to CPU

### 2. Blocks

- Each parallel invocation is referred to as a block
- A set of blocks is referred to a grid
- Each invocation can refer to its block index using blockIdx.x

### 3. Threads

- A block can be split into parallel threads
- Synchronization
- Can share memories

### 4. Indexing

- Combining threads and blocks
- M threads/block
- int index = threadIdx.x + blockIdx.x * blockDim.x

### 5/6. Cooperating threads

- Declare using __shared__, allocated per block
- Data is not visible to threads in other blocks
- Use __synthreads() as a barrier to prevent data hazards
