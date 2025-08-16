%% GDS写入
physical_parameter=physical_parameter_processing(radius, X, Y, 5000);
numSubMatrices=numel(physical_parameter);

% 使用前请测试内存容量，尽可能完全使用内存
group_size=1000;
group_num=ceil(numSubMatrices/group_size);

disp('物理参数重构已完成');

for i=1:group_num

    if i==group_num
        idx_start=(i-1)*group_size+1;
        idx_stop=numSubMatrices;
    else
        idx_start=(i-1)*group_size+1;
        idx_stop=idx_start+group_size-1;
    end

    topCellname='TOP';
    libname=creat_libname(i);
    glib=gds_library(libname, 'uunit', 1e-6, 'dbunit', 1e-12);
    topCell=gds_structure(topCellname);

    for j=idx_start:idx_stop
        pa=physical_parameter{j}*1e6;
        cellname=creat_cellname(j);
        gs=gds_structure(cellname);

        for k = 1:size(pa,1)  
            c=circle(pa(k,1),pa(k,2),pa(k,3),120);
            gs(end+1)=gds_element('boundary', 'xy', c, 'layer', 1);
        end

        printProgress('分组GDS写入', j-(i-1)*group_size, group_size)

        physical_parameter{j}=[];

        glib(end+1)=gs;
        topCell=add_ref(topCell,gs);
     end

glib(end+1)=topCell;
filename=ceate_filename(i);
write_gds_library(glib, filename);

end

disp('GDS文件已导出');

disp('Now running validate...');