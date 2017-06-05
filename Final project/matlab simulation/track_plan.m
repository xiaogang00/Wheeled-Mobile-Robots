% function track_plan(Pos_Start,Pos_Goal,route)
% ����㡢�յ㡢·���㣬��С�����з��棬�õ������ֵ��ٶ�����
%% ����
Wheel_Distance=0.36;%���ֵľ���
dt=2;
MAX_ROUND=500/dt;%����������
%% ����
Pos_Cur=Pos_Start;
Pos_Array=[];
V_Array=[];
W_Array=[];
VL_Array=[];
VR_Array=[];
round=0;
Total_Node=size(route,1);%�ܵĵ���
Next_Goal_Order=2;
Next_Goal=route(Next_Goal_Order,:);
while 1
    %% ����Ŀ���
    tmp_dis=distance( Pos_Cur(1), Pos_Cur(2),Next_Goal(1),Next_Goal(2));
    if Next_Goal_Order<=n-1
        tmp_angle=CalInnerAngleOfTriangle(Pos_Cur,Next_Goal,...
            route(Next_Goal_Order+1,:));
    else
        tmp_angle=0;
    end
    % ��disС��һ����С��ֵʱ��һ��ʹ��Ŀ��㷢������
    % ��disС��һ����С��ֵʱ�������ǰ����Ŀ��㡢�����¸�Ŀ���
    %   ����ɵĽǶȽϴ�ʱ��Ҳʹ��Ŀ��㷢������
    if tmp_dis<0.03 || (tmp_dis<0.3 && tmp_angle>60/180*pi)
        if Next_Goal_Order<Total_Node
            Next_Goal_Order=Next_Goal_Order+1;
            Next_Goal=route(Next_Goal_Order,:);
        end
    end
    %% �����յ���ж�����ѭ��������������
    if distance( Pos_Cur(1), Pos_Cur(2),Pos_Goal(1),Pos_Goal(2))<0.05
        break;
    end
    round=round+1;
    if round>MAX_ROUND
        break;
    end
    %% �����µ��ٶȺ�λ��
    Velocity_Limit=0.1;
    Steering_Limits=0.8;
    krho=3; %���ٶ�
    kalpha=12; %��Ŀ����ת��
    kbeta=5; %�Ƕ�Լ���ıƽ��̶�
    if Next_Goal_Order==n %���һ����ʱ���ٶȼ������Ƕ�Լ���ıƽ�����
        kalpha=10; %��Ŀ����ת��
         kbeta=8; %�Ƕ�Լ���ıƽ��̶�
    end
    [V_Left,V_Right,v,w] = Cal_Speed( Pos_Cur,Next_Goal,Wheel_Distance,...
            Velocity_Limit,Steering_Limits,krho,kalpha,kbeta);
    Pos_Cur=Int_Position( Pos_Cur,v,w,dt);
    %% �洢λ�ú��ٶ�
    V_Array=[V_Array,v];
    W_Array=[W_Array,w];
    VL_Array=[VL_Array,V_Left];
    VR_Array=[VR_Array,V_Right];
    Pos_Array=[Pos_Array;Pos_Cur];

end