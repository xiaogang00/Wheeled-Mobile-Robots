function [v,w] = Velocity_Wheel2Global(V_Left,V_Right,Wheel_Distance)
%�������ֵ��ٶȣ��任ΪС�������ٶȺͽ��ٶ�
v=(V_Left+V_Right)/2;
w=(-V_Left+V_Right)/Wheel_Distance;
end

