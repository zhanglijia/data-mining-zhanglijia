%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DMBIT��ҵ������̽���Է�����Ԥ����
% ����޲�����
% ������������
% ѧ�ţ�2120161077
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function main

horse_colic_mat = load_file('horse-colic.txt');

% ɾ������NaN���в�����
temp_data = horse_colic_mat;
count=[];
for i=1:368
    for j=1:28
    if(find(isnan(horse_colic_mat{i,j}) == 1))
        count=[count i];
        break;
    end
    end
end
temp_data(count,:)=[];
output_file(temp_data,'horse_colic_delete.txt');

% �����������
ATTRIBUTES_Nominal = {'surgery';'Age';'temperature of extremities';'peripheral pulse';'mucous membranes';'capillary refill time';
    'pain';'peristalsis';'abdominal distension';'nasogastric tube';'nasogastric reflux';'rectal examination';'abdomen';'abdominocentesis appearance';
    'outcome';'surgical lesion';'type of lesion';'cp_data'}
% ��ֵ��������
ATTRIBUTES_Number = {'rectal temperature'; 'peripheral pulse'; 'respiratory rate'; 'nasogastric reflux PH'; 'packed cell volume'; 'total protein'; 'abdomcentesis total protein'}; 

% ͳ�Ʊ�����Ե�Ƶ��
n1 = 1;
for i=1:28
     % ɾ������NaN����
    if(i==3 || i==4 || i==5 || i==6 || i==16 || i==19 || i==20 || i==22 || i==26 || i==27)
    else
        temp_data = [horse_colic_mat{:, i}]';
        [NaN_line, ~] = find(isnan(temp_data) == 1);
        temp_data(NaN_line, :) = []; 
        disp(['Frequency of ', ATTRIBUTES_Nominal{n1,1}, ' attribute:']);
        tabulate(temp_data);
        disp(' ');
        n1 = n1+1;
    end
end


 % �����ֵ���������С����ֵ����λ�����ķ�λ����ȱʧֵ�ĸ���
n2 = 1;
for i=4:22
    % ɾ������NaN����
    temp_data = [horse_colic_mat{:, i}]';
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = []; 
  
    if(i==4||i==5||i==6||i==16||i==19||i==20||i==22)
        disp(['Data abstract of attribute ', ATTRIBUTES_Number{n2,1}, ':']);
        disp(['  Maximium:     ', num2str(max(temp_data))]); % ���ֵ
        disp(['  Minimium:     ', num2str(min(temp_data))]); % ��Сֵ
        disp(['  Average:      ', num2str(sum(temp_data) / size(temp_data, 1))]); % ƽ��ֵ
        disp(['  Median:       ', num2str(median(temp_data))]); % ��λ��
        disp(['  Quartile:     ', num2str(prctile(temp_data,25)), ', ', num2str(prctile(temp_data,75))]); % �ķ�λ��
        disp(['  Missing data: ', num2str(size(NaN_line, 1))]); % ȱʧֵ����
        disp(' ');
        n2 = n2+1;
    end
end

visualization(horse_colic_mat);

while(1)
    disp('Choose one way to fill the missing data:');
    disp('(1 - filled by maxium; 2 - filled by attributes; 3 - filled by similarity; any other key - end program)');
    method = input('');
    
    switch(method)
        case 1
            data = preprocessing(horse_colic_mat, 1);
            output_file(data, 'horse_colic_filled_by_maximium.txt');
            visualization(data);
        case 2
            data = preprocessing(horse_colic_mat, 2);
            output_file(data, 'horse_colic_filled_by_attribute.txt');
            visualization(data);
        case 3
            data = preprocessing(horse_colic_mat, 3);
            output_file(data, 'horse_colic_filled_by_similarity.txt');
            visualization(data);
        otherwise
            break;
    end
end

end