function Pos_Next = Int_Position( Pos_Cur,v,w,dt)
    % 这是一个简单的积分程序，由当前的位置和速度、角速度，进行积分
    Pos_Next=Pos_Cur+[v*cos(Pos_Cur(3)),v*sin(Pos_Cur(3)),w]*dt;
end

% %% 以下程序的输入是线速度
% function Pos_Next = Int_Position( Pos_Cur,V_Left,V_Right,dt,Wheel_Distance)
% % 由左右轮的线速度，进行简单的积分
% v=(V_Left+V_Right)/2;
% w=(-V_Left+V_Right)/Wheel_Distance;
% Pos_Next=Pos_Cur+dt*[v*cos(theta),v*sin(theta),w];
% end

