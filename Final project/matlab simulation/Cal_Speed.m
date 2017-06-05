function [V_Left,V_Right,v,w] = Cal_Speed( Pos_Cur,Pos_Goal,Wheel_Distance,...
    Velocity_Limit,...
    Steering_Limits,...
    krho,... %���ٶ�
    kalpha, ...
    kbeta)
%���������ֵ����ٶ�
%�ο�ϵΪ��׼�ο�ϵ���� (��x����y����ʱ��Ƕ�Ϊ��)
% Pos_Goal(3)=Angle_Convert(Pos_Goal(3),Pos_Cur(3));
% Pos_Cur(3)=Angle_Convert(Pos_Cur(3)); 
% Pos_Goal(3)=Angle_Convert(Pos_Goal(3));
% if Pos_Goal(3)<=Pos_Cur(3)-pi
%     Pos_Goal(3)=Pos_Goal(3)+2*pi;
% elseif Pos_Goal(3)>Pos_Cur(3)+pi %��Pos_Goal(3)-Pos_Cur(3)�任�� -pi~pi��
%     Pos_Goal(3)=Pos_Goal(3)-2*pi;
% end

%% ����
direction=1;
%% �����ǶȲ����ļ���
%����x0=[0 0 30],xg=[1,��3,120]
X=Pos_Cur-[Pos_Goal(1:2) 0];
x = X(1); y = X(2); theta = X(3);
rho = sqrt(x^2 + y^2); %��ǰλ�ú�Ŀ��λ�õľ���
%% ԭ����������㷨
%   ����X=[-1,-��3,-90]
%     beta=atan2(-y, -x)-Angle_Convert(Pos_Goal(3));%atan(��3/1)-120��λ�ò�-ĩ̬�ĽǶ�
%     alpha = -theta +atan2(-y, -x);%90+60��������ǵĲ�+λ�ýǵĲ�
%% �������㷨
alpha=atan2(-y,-x)-Pos_Cur(3);alpha=Angle_Convert(alpha);
beta=atan2(-y, -x)-Angle_Convert(Pos_Goal(3));
alpha=Boundary(alpha,0,pi/2);
beta=Angle_Convert(beta);
%% �����ٶ�v�ͽ��ٶ�w
v=rho*krho*direction;
gamma=(kalpha*alpha+kbeta*beta)*direction/abs(v);%vԽ��gammaԽС
v=Boundary(v,0,Velocity_Limit);
gamma=Boundary(gamma,0,Steering_Limits);
w=tan(gamma)/Wheel_Distance*v;
v=v/min(2,max(1,abs(w/0.3)));%�ٶ�v����w��������
%% ��v��w�õ�V_Left��V_Right
V_Left=v-w*Wheel_Distance/2;
V_Right=v+w*Wheel_Distance/2;
end

