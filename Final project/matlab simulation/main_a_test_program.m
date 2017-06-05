close all;
clear all,clc;
addpath './Astar'
addpath './Others'

%%
figure;
axis([-5 5 -5 5]);axis equal;
%% 参数
x0=[0 0 0];%起点
xgg=[
    1 -3 0
    1  3 0
    2 4 pi/2
    2 -4 -pi/2
    3 1 pi/4
    3 -1 -pi/4
    0 3 pi/2
    0 -3 -pi/2
      -3 0 pi*(3/4)
      -3 0 pi*(5/4) 
];
global direction
% 如果目标点在后面，则原地转圈
for xxxxx=1:size(xgg,1)
    xg=xgg(xxxxx,:);
    Wheel_Distance=0.36;%轴距
    dt=0.1;
    MAX_ROUND=400;
    %% 变量
    Pos_Goal=xg;
    Pos_Start=x0;
    Pos_Cur=Pos_Start;
    Pos_Array=[];
    V_Array=[];
    W_Array=[];
    round=0;
    while 1
        %% 计算新的速度和位置
        [V_Left,V_Right,v,w] = Cal_Speed( Pos_Cur,Pos_Goal,Wheel_Distance);
        Pos_Cur=Int_Position( Pos_Cur,v,w,dt);
        %% 存储位置和速度
        V_Array=[V_Array,v];
        W_Array=[W_Array,w];
        Pos_Array=[Pos_Array;Pos_Cur];
        %% 退出条件
        if distance( Pos_Cur(1), Pos_Cur(2),Pos_Goal(1),Pos_Goal(2))<0.05
            break;
        end
        round=round+1;
        if round>MAX_ROUND
            break;
        end
    end
    round
    %% 画图
    plot(Pos_Goal(1),Pos_Goal(2),'ro');
    hold on;plot(Pos_Start(1),Pos_Start(2),'r*');
    hold on;plot(Pos_Array(:,1),Pos_Array(:,2),'g.');
%     pause(0.5);
    axis equal
end


