
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

int A[5] = { 1, 2, 3, 4, 5 };

__device__ int d_A[5];

__global__ void multiply()
{
	int i = threadIdx.x;
	d_A[i] = d_A[i] * 2;
}

int main()
{
	cudaMemcpyToSymbol(d_A, A, 5 * sizeof(int));
	multiply <<< 1, 5 >>> ();
	cudaMemcpyFromSymbol(A, d_A, 5 * sizeof(int));

	for (int i = 0; i < 5; i++)
	{
		printf("%d ", A[i]);
	}
}