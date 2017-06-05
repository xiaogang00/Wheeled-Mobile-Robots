%% �°�ȫ��·���滮�㷨
%% �ص�������ݣ�
% 1��A*�㷨�Ĺ�ֵ�����У��������ϰ�����Ƴ���Astar_potential��������
%    ʹ��·�����ڷǱ�Ҫʱ����ǽ�ڸ�һ�ξ���
% 2������һ��·���򻯺�����ɾ��·���ĸ���ֱ���У��Ƕ˵��·����
% 3���ٶȼ��㺯��������������һ�����߰�����㷨��������������һ���ش���󣡣���
%    ʹ��·����ƽ�������ҿ������ó�ʼ��ĩβ�ĽǶ�Լ����

%% ��ȡ��ͼ��Ϣ

global length_per_dot safe_distance length_of_the_matrix
length_per_dot=0.1;     % ÿ�����ص��Ӧ�ı߳�
length_of_the_map=[4 4];% ��ͼ���ܸߺ��ܿ�
length_of_the_matrix=length_of_the_map/length_per_dot;%��ֵ�����������������
Car_Length=0.4;%���ĳ���
safe_distance=0.2+Car_Length/2;%��ȫ����

%% ���ö�ȡ��ͼ�ĺ������Զ����ɵ�ͼ�����Լ���㡢�յ�����
filename='map3.jpg';
[MAP,start_x, start_y, target_x, target_y]=map2(filename,length_of_the_matrix); %�ֻ��ͼ

EMAP=MAP;
find_route=0;
round=0;
%Ϊʹ��·����Զ��ǽ�ڣ�������A*�㷨�м������Ƴ�������ʹ�����µ������ϰ��﷽��
% Expand_Time=safe_distance/length_per_dot;%�������е����ʹ���
Expand_Time=1;%�����ԣ�ֻʹ�÷�����ʱ�Ϳ����ˡ����ϰ������͵Ĵ���Ϊ0
while round<Expand_Time
    tmproute=Astar(EMAP, start_x, start_y, target_x, target_y)';%����A*�㷨
    if same(tmproute,-1)==0 %���route~=-1��˵���ҵ���·��
        route=tmproute;
        route=simplify_route( route,EMAP,length_per_dot); %����·��������û���ϰ�����ڼ��·����ҲҪɾȥ
        find_route=1;
    else
        break;
    end
    round=round+1;
end


%% ·���������ϵ�任����׼��ֱ������ϵ
route=(route-1/2)*length_per_dot;%��·����ĵ�λת��Ϊ��
route=[route(2,:);route(1,:)];%ԭ����(������)��������(������)
route(2,:)=length_of_the_map(1)-route(2,:);

%% ����ÿһ��·����ĽǶ�Լ��
route=route';%��ת����
n=size(route,1);
route_Angle=zeros(n,1);%�µ�һ�У��洢ÿ��·�����б��
for i=2:n-1 %����б��
    angle_last=atan2( route(i,2)-route(i-1,2),route(i,1)-route(i-1,1));
    angle_next=atan2( route(i+1,2)-route(i,2),route(i+1,1)-route(i,1));
    angle_next=Angle_Convert(angle_next,angle_last);
    route_Angle(i)=(angle_next+angle_last)/2;
    route_Angle(i)=Angle_Convert(route_Angle(i));
end
route=[route,route_Angle];%route_Angle����route��

%% ���������յ��б��
if 1 % �Ƿ��Զ����������յ�ĽǶ�
    Start_Angle=atan2( route(2,2)-route(1,2),route(2,1)-route(1,1));%���Ƕ�Լ��
    Goal_Angle=atan2( route(n,2)-route(n-1,2),route(n,1)-route(n-1,1));%�յ�Ƕ�Լ��
else %�����ֶ�����
    Start_Angle=-pi;%���Ƕ�Լ��
    Goal_Angle=0;%�յ�Ƕ�Լ��
end
route(1,3)=Start_Angle;
route(end,3)=Goal_Angle;

%% ���÷������
Pos_Start=[route(1,:)];%��ʼλ�úͽǶ�
Pos_Goal=[route(end,:)];%��ֹλ�úͽǶ�
track_plan;