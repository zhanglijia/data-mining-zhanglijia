function data = preprocessing(analytic_mat, method)
%PREPROCESSING �����ݽ���Ԥ����֧�������ַ�ʽ��methodȡֵΪ1~3����
%   ���ַ�ʽ�ֱ�Ϊ�����Ƶֵ�����������ع�ϵ�����������ԡ���ȱʧ�����޳���ȱʡ��ʽ������Ԥ�������С�

ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28; % 

[m, n] = size(analytic_mat); % �������Ĵ�С

standard_line = [analytic_mat{1, ATTRIBUTE_L: ATTRIBUTE_H}]; % ȡ��һ����ȱʧ����������Ϊ����2��ֵ������

switch(method)
    case 1 % ʹ�����Ƶֵ���NaN
        for i = 1: m
            for j = ATTRIBUTE_L: ATTRIBUTE_H 
                if(isnan(analytic_mat{i, j}))
                    analytic_mat{i, j} = max([analytic_mat{:, j}]); % ȡ�����Ե����Ƶֵ
                end
            end
        end
        data = analytic_mat;
    case 2 % ʹ������ص����Բ�ȫNaN
        cor_mat = correlation_mat_attribute(analytic_mat); % �������Ծ��󣬺�������
        cor_size = size(cor_mat, 1); % �����С������������Ƿ���
        for i = 1: m
            for j = ATTRIBUTE_L: ATTRIBUTE_H
                    if(isnan(analytic_mat{i, j}))
                    [~, index] = sort(cor_mat(j - ATTRIBUTE_L + 1, :));
                    index_list = fliplr(index); % sort����fliplr��ת����ɽ��򣬵õ��ο����������ȶ��б�
                    flag = 0; % ��ʶ�Ƿ�ȫ�ɹ�
                    for k = 1: cor_size
                        ref_attr = index_list(k); % ���ڲ�ȫ�ο�������
                        if(~isnan(analytic_mat{i, ref_attr}))
                            analytic_mat{i, j} = standard_line(j - ATTRIBUTE_L + 1) / standard_line(ref_attr) * ...
                                analytic_mat{i, ref_attr + ATTRIBUTE_L - 1}; % ��������ȫ���ⲻ����õķ�����
                            flag = 1;
                            break;
                        end
                    end
                    if(flag == 0)
                        disp(['Insert fail at row ', num2str(i), ' col ', num2str(j)]);
                        return ;
                    end
                    end
            end
        end
        data = analytic_mat;
    case 3 % ʹ�������Ƶ�����������ȫNaN����ʽ�������Ƶ��Բ�ͬ
        sim_mat = similarity_mat_sample(analytic_mat); % �������Ծ��󣬺�������
        sim_size = size(sim_mat, 1); % �����С������������Ƿ���
        for i = 1: m
            for j = ATTRIBUTE_L: ATTRIBUTE_H
                if(isnan(analytic_mat{i, j}))
                    [~, index_list] = sort(sim_mat(i, :));
                    flag = 0; % ��ʶ�Ƿ�ȫ�ɹ�
                    for k = 1: sim_size
                        ref_samp = index_list(k); % ���ڲ�ȫ�ο�������
                        if(~isnan(analytic_mat{ref_samp, j}))
                            analytic_mat{i, j} = analytic_mat{ref_samp, j}; % ԭ�����ϣ���ȫ
                            flag = 1;
                            break;
                        end
                    end
                    if(flag == 0)
                        disp(['Insert fail at row ', num2str(i), ' col ', num2str(j)]);
                        return ;
                    end
                end
            end
        end
        data = analytic_mat;
    otherwise
        data = [];
        disp('Invalid method input.');
end

end

function cor_mat = correlation_mat_attribute(analytic_mat)
%CORRELATION_MAT_ATTRIBUTE ��������֮�������Ծ���
%   �����к��ж������ԣ�value(i,j)������i������j������ԡ����ǶԳƾ���

ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28; 
COR_SIZE = ATTRIBUTE_H - ATTRIBUTE_L + 1; % ����Ծ���Ĵ�С

cor_mat = ones(COR_SIZE, COR_SIZE); % ��ʼ������Ծ�������Ҫȡ�������ԣ���ʼΪ��Сֵ��-1��
for i = ATTRIBUTE_L: ATTRIBUTE_H - 1
    for j = i + 1: ATTRIBUTE_H
        merge = [[analytic_mat{:, i}]', [analytic_mat{:, j}]']; % ���������ϵ�������в�����
        [NaN_line, ~] = find(isnan(merge) == 1);
        merge(NaN_line, :) = []; % ɾ������NaN�����Ա���ȷ������ϵ��
        
        cor_indx = i - ATTRIBUTE_L + 1;
        cor_indy = j - ATTRIBUTE_L + 1; % ����Ծ����±�
        cor_mat(cor_indx, cor_indy) = corr(merge(:, 1), merge(:, 2)); % merge�����м�ȥ��NaN�������ԣ������ϵ��
        cor_mat(cor_indy, cor_indx) = cor_mat(cor_indx, cor_indy); % �Գƾ���
    end
end

end

function sim_mat = similarity_mat_sample(analytic_mat)
%SIMILARITY_MAT_SAMPLE �������������������ԡ���correlation_mat_attribute���ơ�
%   �˴�������ʵ��������ŷ����þ��룬���ԽСԽ���ơ������������������ƣ����������ע�͡�

ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28; 

SIM_SIZE = size(analytic_mat, 1); % ���ƾ����С����analytic_mat������һ��

sim_mat = ones(SIM_SIZE, SIM_SIZE) * 999; % ��ʼ��Ϊ������
for i = 1: SIM_SIZE - 1
    for j = i + 1: SIM_SIZE
        merge = [[analytic_mat{i, ATTRIBUTE_L: ATTRIBUTE_H}]', ...
            [analytic_mat{j, ATTRIBUTE_L: ATTRIBUTE_H}]']; % ����������ת�úϲ�Ϊ������x2�ľ���
        [NaN_line, ~] = find(isnan(merge) == 1);
        merge(NaN_line, :) = [];
        
        sim_mat(i, j) = norm(merge(:, 1) - merge(:, 2)); % ��������ŷ����þ���
        sim_mat(j, i) = sim_mat(i, j); % �Գƾ���
    end
end

end