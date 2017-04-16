function analytic_mat = load_file(path)
% LOAD_FILE 读取path处的文件，输出数据矩阵和数据条数。
% 要求path处的文件按照horse-colic.data的标准格式给出，每行包含20个标称属性，8个数值属性


file = fopen(path);

DIM = 28; % 马的疝病参数维度

temp_mat = textscan(file, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s'); % 读取的数据集
N = size(temp_mat{1, 1}, 1); % 数据条数

analytic_mat = cell(N, DIM); % 创建新的cell矩阵对temp_mat进行格式化存储
for i = 1: N
    for j = 1: DIM
            if(strcmp(temp_mat{1, j}{i}, '?') == 1)
                analytic_mat{i, j} = NaN; % 数据缺失转换为NaN
            else
%                 if (j==4 ||j==5||j==6||j==16||j==19||j==20||j==22)
                    analytic_mat{i, j} = str2double(temp_mat{1, j}{i}); % 如果是数值属性就转换为double
%                 else
%                     analytic_mat{i, j} = temp_mat{1, j}{i}; % 其他标称属性不转换
%                 end 
            end
    end
end
end