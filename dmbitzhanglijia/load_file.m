function analytic_mat = load_file(path)
% LOAD_FILE ��ȡpath�����ļ���������ݾ��������������
% Ҫ��path�����ļ�����horse-colic.data�ı�׼��ʽ������ÿ�а���20��������ԣ�8����ֵ����


file = fopen(path);

DIM = 28; % ����޲�����ά��

temp_mat = textscan(file, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s'); % ��ȡ�����ݼ�
N = size(temp_mat{1, 1}, 1); % ��������

analytic_mat = cell(N, DIM); % �����µ�cell�����temp_mat���и�ʽ���洢
for i = 1: N
    for j = 1: DIM
            if(strcmp(temp_mat{1, j}{i}, '?') == 1)
                analytic_mat{i, j} = NaN; % ����ȱʧת��ΪNaN
            else
%                 if (j==4 ||j==5||j==6||j==16||j==19||j==20||j==22)
                    analytic_mat{i, j} = str2double(temp_mat{1, j}{i}); % �������ֵ���Ծ�ת��Ϊdouble
%                 else
%                     analytic_mat{i, j} = temp_mat{1, j}{i}; % ����������Բ�ת��
%                 end 
            end
    end
end
end