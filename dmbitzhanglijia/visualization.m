function visualization(data)
%VISUALIZATION 可视化数据。如果data未经预处理会有NaN，因此要先考虑剔除NaN的情况，再分别可视化。
%   绘制7个属性的直方图、QQ图、盒图

figure; % 新建直方图窗口

X_LABELS = {'temperature'; 'pulse'; 'rate'; 'PH'; 'volume'; 't-protein'; 'a-protein'}; % 直方图x轴名称

n = 1;
for i = 1:28
    if(i==4||i==5||i==6||i==16||i==19||i==20||i==22)
        % 删掉含有NaN的行
        temp_data = [data{:, i}]';
        [NaN_line, ~] = find(isnan(temp_data) == 1);
        temp_data(NaN_line, :) = [];
        % 画出属性的直方图
        subplot(2, 4, n); 
        histogram(temp_data);
        title(X_LABELS(n));
        n = n+1;
    end
end

figure; % 新建QQ图窗口，因为不知道怎么把subplot放到不同figure里只能重写一遍
m = 1;
for i = 1:28
    if(i==4||i==5||i==6||i==16||i==19||i==20||i==22)
        % 删掉含有NaN的行
        temp_data = [data{:, i}]';
        [NaN_line, ~] = find(isnan(temp_data) == 1);
        temp_data(NaN_line, :) = [];
        % 画出属性的QQ图
        subplot(2, 4, m); 
        qqplot(temp_data);
        title(X_LABELS(m));
        set(gca, 'xlabel', [], 'ylabel', []); % 取消横纵轴名
        m = m+1;
    end
end


figure; % 新建盒图窗口
t = 1;
for i = 1:28
    if(i==4||i==5||i==6||i==16||i==19||i==20||i==22)
        % 删掉含有NaN的行
        temp_data = [data{:, i}]';
        [NaN_line, ~] = find(isnan(temp_data) == 1);
        temp_data(NaN_line, :) = [];
        % 画出属性的盒图
        subplot(2, 4, t); 
        boxplot(temp_data);
        title(X_LABELS(t));
        set(gca, 'xticklabel', []); % 取消横轴名
        t = t+1;
    end
end

end