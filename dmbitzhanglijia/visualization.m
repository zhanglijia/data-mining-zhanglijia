function visualization(data)
%VISUALIZATION ���ӻ����ݡ����dataδ��Ԥ�������NaN�����Ҫ�ȿ����޳�NaN��������ٷֱ���ӻ���
%   ����7�����Ե�ֱ��ͼ��QQͼ����ͼ

figure; % �½�ֱ��ͼ����

X_LABELS = {'temperature'; 'pulse'; 'rate'; 'PH'; 'volume'; 't-protein'; 'a-protein'}; % ֱ��ͼx������

n = 1;
for i = 1:28
    if(i==4||i==5||i==6||i==16||i==19||i==20||i==22)
        % ɾ������NaN����
        temp_data = [data{:, i}]';
        [NaN_line, ~] = find(isnan(temp_data) == 1);
        temp_data(NaN_line, :) = [];
        % �������Ե�ֱ��ͼ
        subplot(2, 4, n); 
        histogram(temp_data);
        title(X_LABELS(n));
        n = n+1;
    end
end

figure; % �½�QQͼ���ڣ���Ϊ��֪����ô��subplot�ŵ���ͬfigure��ֻ����дһ��
m = 1;
for i = 1:28
    if(i==4||i==5||i==6||i==16||i==19||i==20||i==22)
        % ɾ������NaN����
        temp_data = [data{:, i}]';
        [NaN_line, ~] = find(isnan(temp_data) == 1);
        temp_data(NaN_line, :) = [];
        % �������Ե�QQͼ
        subplot(2, 4, m); 
        qqplot(temp_data);
        title(X_LABELS(m));
        set(gca, 'xlabel', [], 'ylabel', []); % ȡ����������
        m = m+1;
    end
end


figure; % �½���ͼ����
t = 1;
for i = 1:28
    if(i==4||i==5||i==6||i==16||i==19||i==20||i==22)
        % ɾ������NaN����
        temp_data = [data{:, i}]';
        [NaN_line, ~] = find(isnan(temp_data) == 1);
        temp_data(NaN_line, :) = [];
        % �������Եĺ�ͼ
        subplot(2, 4, t); 
        boxplot(temp_data);
        title(X_LABELS(t));
        set(gca, 'xticklabel', []); % ȡ��������
        t = t+1;
    end
end

end