function [V_Left,V_Right,v,w] = Cal_Speed( Pos_Cur,Pos_Goal,Wheel_Distance,...
    Velocity_Limit,...
    Steering_Limits,...
    krho,... %线速度
    kalpha, ...
    kbeta)
%返回左右轮的线速度
%参考系为标准参考系，即 (→x，↑y，逆时针角度为正)
% Pos_Goal(3)=Angle_Convert(Pos_Goal(3),Pos_Cur(3));
% Pos_Cur(3)=Angle_Convert(Pos_Cur(3)); 
% Pos_Goal(3)=Angle_Convert(Pos_Goal(3));
% if Pos_Goal(3)<=Pos_Cur(3)-pi
%     Pos_Goal(3)=Pos_Goal(3)+2*pi;
% elseif Pos_Goal(3)>Pos_Cur(3)+pi %将Pos_Goal(3)-Pos_Cur(3)变换到 -pi~pi内
%     Pos_Goal(3)=Pos_Goal(3)-2*pi;
% end

%% 参数
direction=1;
%% 各个角度参数的计算
%例如x0=[0 0 30],xg=[1,√3,120]
X=Pos_Cur-[Pos_Goal(1:2) 0];
x = X(1); y = X(2); theta = X(3);
rho = sqrt(x^2 + y^2); %当前位置和目标位置的距离
%% 原先有问题的算法
%   假设X=[-1,-√3,-90]
%     beta=atan2(-y, -x)-Angle_Convert(Pos_Goal(3));%atan(√3/1)-120，位置差-末态的角度
%     alpha = -theta +atan2(-y, -x);%90+60，即朝向角的差+位置角的差
%% 改正的算法
alpha=atan2(-y,-x)-Pos_Cur(3);alpha=Angle_Convert(alpha);
beta=atan2(-y, -x)-Angle_Convert(Pos_Goal(3));
alpha=Boundary(alpha,0,pi/2);
beta=Angle_Convert(beta);
%% 计算速度v和角速度w
v=rho*krho*direction;
gamma=(kalpha*alpha+kbeta*beta)*direction/abs(v);%v越大，gamma越小
v=Boundary(v,0,Velocity_Limit);
gamma=Boundary(gamma,0,Steering_Limits);
w=tan(gamma)/Wheel_Distance*v;
v=v/min(2,max(1,abs(w/0.3)));%速度v根据w进行缩放
%% 由v和w得到V_Left和V_Right
V_Left=v-w*Wheel_Distance/2;
V_Right=v+w*Wheel_Distance/2;
end

