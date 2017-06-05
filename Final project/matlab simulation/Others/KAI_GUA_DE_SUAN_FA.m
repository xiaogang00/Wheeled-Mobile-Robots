close all;
clear all,clc;
%% ����
x0=[0 0 -pi/2];%���
xg=[1 0 pi/4];%�յ�
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
figure;
plot(Pos_Goal(1),Pos_Goal(2),'ro');
hold on;plot(Pos_Start(1),Pos_Start(2),'r*');
hold on;plot(Pos_Array(:,1),Pos_Array(:,2),'g.');
axis equal


