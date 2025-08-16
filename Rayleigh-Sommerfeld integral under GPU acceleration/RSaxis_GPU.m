function U=RSaxis_GPU(Ein,lambda,X0,Y0,z)
Ein_GPU = gpuArray(Ein);
lambda_gpu = gpuArray(lambda);
X0_gpu = gpuArray(X0);
Y0_gpu = gpuArray(Y0);
z_gpu = gpuArray(z);

u = gpuArray.zeros(1,numel(z));
for i=1:numel(z)
    Z=z_gpu(i);
    u(i) = RSintegration(Ein_GPU,lambda_gpu,X0_gpu,Y0_gpu,0,0,Z);
end
U=abs(u).^2;
U=gather(U);
end