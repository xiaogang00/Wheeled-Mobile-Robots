function Pos_Next = Int_Position( Pos_Cur,v,w,dt)
    % ����һ���򵥵Ļ��ֳ����ɵ�ǰ��λ�ú��ٶȡ����ٶȣ����л���
    Pos_Next=Pos_Cur+[v*cos(Pos_Cur(3)),v*sin(Pos_Cur(3)),w]*dt;
end

% %% ���³�������������ٶ�
% function Pos_Next = Int_Position( Pos_Cur,V_Left,V_Right,dt,Wheel_Distance)
% % �������ֵ����ٶȣ����м򵥵Ļ���
% v=(V_Left+V_Right)/2;
% w=(-V_Left+V_Right)/Wheel_Distance;
% Pos_Next=Pos_Cur+dt*[v*cos(theta),v*sin(theta),w];
% end

