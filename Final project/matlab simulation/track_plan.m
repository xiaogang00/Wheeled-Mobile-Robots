% function track_plan(Pos_Start,Pos_Goal,route)
% 由起点、终点、路径点，对小车进行仿真，得到左右轮的速度序列
%% 参数
Wheel_Distance=0.36;%车轮的距离
dt=2;
MAX_ROUND=500/dt;%最大迭代次数
%% 变量
Pos_Cur=Pos_Start;
Pos_Array=[];
V_Array=[];
W_Array=[];
VL_Array=[];
VR_Array=[];
round=0;
Total_Node=size(route,1);%总的点数
Next_Goal_Order=2;
Next_Goal=route(Next_Goal_Order,:);
while 1
    %% 更新目标点
    tmp_dis=distance( Pos_Cur(1), Pos_Cur(2),Next_Goal(1),Next_Goal(2));
    if Next_Goal_Order<=n-1
        tmp_angle=CalInnerAngleOfTriangle(Pos_Cur,Next_Goal,...
            route(Next_Goal_Order+1,:));
    else
        tmp_angle=0;
    end
    % 当dis小于一个很小的值时，一定使得目标点发生更新
    % 当dis小于一个较小的值时，如果当前点与目标点、与下下个目标点
    %   所组成的角度较大时，也使得目标点发生更新
    if tmp_dis<0.03 || (tmp_dis<0.3 && tmp_angle>60/180*pi)
        if Next_Goal_Order<Total_Node
            Next_Goal_Order=Next_Goal_Order+1;
            Next_Goal=route(Next_Goal_Order,:);
        end
    end
    %% 到达终点的判定（即循环结束的条件）
    if distance( Pos_Cur(1), Pos_Cur(2),Pos_Goal(1),Pos_Goal(2))<0.05
        break;
    end
    round=round+1;
    if round>MAX_ROUND
        break;
    end
    %% 计算新的速度和位置
    Velocity_Limit=0.1;
    Steering_Limits=0.8;
    krho=3; %线速度
    kalpha=12; %向目标点的转速
    kbeta=5; %角度约束的逼近程度
    if Next_Goal_Order==n %最后一个点时，速度减慢，角度约束的逼近更快
        kalpha=10; %向目标点的转速
         kbeta=8; %角度约束的逼近程度
    end
    [V_Left,V_Right,v,w] = Cal_Speed( Pos_Cur,Next_Goal,Wheel_Distance,...
            Velocity_Limit,Steering_Limits,krho,kalpha,kbeta);
    Pos_Cur=Int_Position( Pos_Cur,v,w,dt);
    %% 存储位置和速度
    V_Array=[V_Array,v];
    W_Array=[W_Array,w];
    VL_Array=[VL_Array,V_Left];
    VR_Array=[VR_Array,V_Right];
    Pos_Array=[Pos_Array;Pos_Cur];

end