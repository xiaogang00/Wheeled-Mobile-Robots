function [MAP,start_x, start_y, target_x, target_y]=map2(filename,length_of_the_matrix)
% 从手绘图中生成地图矩阵
% 在地图中，起点为红色，终点为绿色，障碍为黑色，空地为白色
% clc;clear;close all;
img=imread(filename);%读取地图
[r l k]=size(img);%读取地图的像素点个数
% 从地图中读取起点和终点
for i=1:r
    for j=1:l
        if img(i,j,1)>128 & img(i,j,2)<128 & img(i,j,3)<128 %红色
            start_x=i;
            start_y=j;
        end
        if img(i,j,2)>128 & img(i,j,1)<128 & img(i,j,3)<128 %绿色
            target_x=i;
            target_y=j;
        end
    end
end
% 将起点和终点的坐标从 像素点 变换到 矩阵中的位置
start_x=round(start_x/r*length_of_the_matrix(1));
start_y=round(start_y/l*length_of_the_matrix(2));
target_x=round(target_x/r*length_of_the_matrix(1));
target_y=round(target_y/l*length_of_the_matrix(2));

%% 将地图二值化，调用A*算法
img=rgb2gray(img);%彩图转灰图
img=imresize(img,length_of_the_matrix);%缩放图片至最终的矩阵的大小
MAP=zeros(size(img));
MAP(find(img>10))=1;%将图片二值化，白色为1，黑色为0
% figure
% imshow(img);
% figure
% imshow(MAP);
MAP(MAP==1)=2; %A*算法中，空地Space 的值是2
MAP(MAP==0)=-1;%A*算法中，障碍bstacle 的值是-1
% figure;imshow(MAP);title('Read Map');
end

