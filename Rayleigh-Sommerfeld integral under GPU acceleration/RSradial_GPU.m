function U = RSradial_GPU(Ein,lambda,X0,Y0,x,z)
Ein_GPU = gpuArray(Ein);
lambda_gpu = gpuArray(lambda);
X0_gpu = gpuArray(X0);
Y0_gpu = gpuArray(Y0);
z_gpu = gpuArray(z);
x_gpu = gpuArray(x);

u = gpuArray.zeros(1, numel(x_gpu));
for i=1:numel(x_gpu)
   X=x_gpu(i);
   u(i)=RSintegration(Ein_GPU,lambda_gpu,X0_gpu,Y0_gpu,X,0,z_gpu);
end
U = abs(u)^2;
U = gather(U); 
end