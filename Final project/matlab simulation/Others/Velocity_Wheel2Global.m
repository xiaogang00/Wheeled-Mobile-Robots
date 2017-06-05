function [v,w] = Velocity_Wheel2Global(V_Left,V_Right,Wheel_Distance)
%把左右轮的速度，变换为小车的线速度和角速度
v=(V_Left+V_Right)/2;
w=(-V_Left+V_Right)/Wheel_Distance;
end

