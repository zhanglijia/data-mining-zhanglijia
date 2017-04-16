function output_file(data, path)
%OUTPUT_FILE 将数据标准化输出。
%   输出的路径（包含文件名）为path。

file = fopen(path, 'w');
for i = 1: size(data, 1)
        fprintf(file, '%f     %f     %f     %f     %f     %f      %f     %f     %f     %f     %f     %f     %f      %f     %f     %f     %f     %f     %f     %f      %f     %f     %f     %f     %f     %f     %f      %f\n', data{i, 1}, data{i, 2}, data{i, 3},data{i, 4}, data{i, 5}, data{i, 6},data{i, 7}, data{i, 8}, data{i, 9},data{i, 10}, data{i, 11}, data{i, 12},data{i, 13}, data{i, 14}, data{i, 15},data{i, 16}, data{i, 17}, data{i, 18},data{i, 19}, data{i, 20}, data{i, 21},data{i, 22}, data{i, 23}, data{i, 24},data{i, 25}, data{i, 26}, data{i, 27},data{i, 28});
    
end

end