function [MAP,start_x, start_y, target_x, target_y]=map2(filename,length_of_the_matrix)
% ���ֻ�ͼ�����ɵ�ͼ����
% �ڵ�ͼ�У����Ϊ��ɫ���յ�Ϊ��ɫ���ϰ�Ϊ��ɫ���յ�Ϊ��ɫ
% clc;clear;close all;
img=imread(filename);%��ȡ��ͼ
[r l k]=size(img);%��ȡ��ͼ�����ص����
% �ӵ�ͼ�ж�ȡ�����յ�
for i=1:r
    for j=1:l
        if img(i,j,1)>128 & img(i,j,2)<128 & img(i,j,3)<128 %��ɫ
            start_x=i;
            start_y=j;
        end
        if img(i,j,2)>128 & img(i,j,1)<128 & img(i,j,3)<128 %��ɫ
            target_x=i;
            target_y=j;
        end
    end
end
% �������յ������� ���ص� �任�� �����е�λ��
start_x=round(start_x/r*length_of_the_matrix(1));
start_y=round(start_y/l*length_of_the_matrix(2));
target_x=round(target_x/r*length_of_the_matrix(1));
target_y=round(target_y/l*length_of_the_matrix(2));

%% ����ͼ��ֵ��������A*�㷨
img=rgb2gray(img);%��ͼת��ͼ
img=imresize(img,length_of_the_matrix);%����ͼƬ�����յľ���Ĵ�С
MAP=zeros(size(img));
MAP(find(img>10))=1;%��ͼƬ��ֵ������ɫΪ1����ɫΪ0
% figure
% imshow(img);
% figure
% imshow(MAP);
MAP(MAP==1)=2; %A*�㷨�У��յ�Space ��ֵ��2
MAP(MAP==0)=-1;%A*�㷨�У��ϰ�bstacle ��ֵ��-1
% figure;imshow(MAP);title('Read Map');
end

