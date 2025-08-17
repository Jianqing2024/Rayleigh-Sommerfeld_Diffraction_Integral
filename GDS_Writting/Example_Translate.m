clear;clc
load End.mat
clear Ft Eout Ein

phi = readmatrix('angle.txt');
phi = wrapTo2Pi(phi);

[U,~] = size(Phase);

r = linspace(0.08e-6,0.18e-6,numel(phi));

radius = ones(U,U);
diff = ones(numel(phi),1);

for i=1:U
    for j=1:U
        phase = Phase(i,j);

        if phase == 0
            radius(i,j) = 0;
        else
            for k=1:numel(phi)
                diff(k) = abs(phase-phi(k));
            end
            [~, index] = min(diff);
            radius(i,j) = r(index);
        end
    end
end

physical_parameter = physical_parameter_processing2(radius*1e6, X*1e6, Y*1e6);


% disp('物理参数重构')
% physical_parameter = physical_parameter_processing(radius, X, Y, 1000);
% disp('保存')
save('radius.mat','physical_parameter','-v7.3')