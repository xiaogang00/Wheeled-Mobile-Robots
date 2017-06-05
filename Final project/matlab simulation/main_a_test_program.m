close all;
clear all,clc;
addpath './Astar'
addpath './Others'

%%
figure;
axis([-5 5 -5 5]);axis equal;
%% ����
x0=[0 0 0];%���
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
% ���Ŀ����ں��棬��ԭ��תȦ
for xxxxx=1:size(xgg,1)
    xg=xgg(xxxxx,:);
    Wheel_Distance=0.36;%���
    dt=0.1;
    MAX_ROUND=400;
    %% ����
    Pos_Goal=xg;
    Pos_Start=x0;
    Pos_Cur=Pos_Start;
    Pos_Array=[];
    V_Array=[];
    W_Array=[];
    round=0;
    while 1
        %% �����µ��ٶȺ�λ��
        [V_Left,V_Right,v,w] = Cal_Speed( Pos_Cur,Pos_Goal,Wheel_Distance);
        Pos_Cur=Int_Position( Pos_Cur,v,w,dt);
        %% �洢λ�ú��ٶ�
        V_Array=[V_Array,v];
        W_Array=[W_Array,w];
        Pos_Array=[Pos_Array;Pos_Cur];
        %% �˳�����
        if distance( Pos_Cur(1), Pos_Cur(2),Pos_Goal(1),Pos_Goal(2))<0.05
            break;
        end
        round=round+1;
        if round>MAX_ROUND
            break;
        end
    end
    round
    %% ��ͼ
    plot(Pos_Goal(1),Pos_Goal(2),'ro');
    hold on;plot(Pos_Start(1),Pos_Start(2),'r*');
    hold on;plot(Pos_Array(:,1),Pos_Array(:,2),'g.');
%     pause(0.5);
    axis equal
end


