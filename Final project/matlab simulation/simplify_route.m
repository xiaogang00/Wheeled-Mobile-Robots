function new_route = simplify_route( route,map,length_per_dot )
%% ���Ĳ�
% 0�����N1��Ni��������У���N2��N3��...��Ni-1�����N2��N3��...��Ni-1ɾ��
% �õ��Ľ�������ܻ����һЩ����Ҫ������

% 1����ԭ�������A1,A2,...,An�У����A1��An���ɵĳ�������û���ϰ���
% ��ɾȥ A2,...,An-1����·����ΪA1,An

% 2�����������ľ��볬��max_dis,���������м����һ����
max_dis=1.2/length_per_dot;

% 3�����������ľ���С��min_dis�������������Ϊһ����
min_dis=0.2/length_per_dot;% ���������ܽ���������Ǻϲ�Ϊһ����

%%
original_route=route;

%% 0�����N1��Ni��������У���N2��N3��...��Ni-1�����N2��N3��...��Ni-1ɾ��
min_dis=0.3;
n=size(route,2);
route=[route,[0;pi]];
Start_Index=1;
New_Index_Array=[Start_Index];
while Start_Index<n
    delta_x=route(1,Start_Index+1)-route(1,Start_Index);
    delta_y=route(2,Start_Index+1)-route(2,Start_Index);
    Current_Detecting_Index=Start_Index+1;
    while 1
        if route(1,Current_Detecting_Index+1)-route(1,Current_Detecting_Index)==delta_x...
            && route(2,Current_Detecting_Index+1)-route(2,Current_Detecting_Index)==delta_y
            % �����һ�����������ͬ
            Current_Detecting_Index=Current_Detecting_Index+1;
        else % �����һ���������ͬ����Current_Detecting_IndexΪһ���ֽ���
            New_Index_Array=[New_Index_Array,Current_Detecting_Index];
            Start_Index=Current_Detecting_Index;
            break; %�˳�ѭ�����ӷֽ��߿�ʼ����ʼ��һ�ֵ�ѭ��
        end
    end
end
% ����ĩβ����һ��ת�۵㣬���Ե�Start_Index==nʱ��ѭ������
new_route=[];
for i=1:length(New_Index_Array)
    new_route(:,i)=route(:,New_Index_Array(i));
end
route=new_route;


%% 1����ԭ�������A1,A2,...,An�У����A1��An���ɵĳ�������û���ϰ���
%  ��ɾȥ A2,...,An-1����·����ΪA1,An
wall=-1;
space=2;
n=size(route,2);
start_point=1;
new_route=route(:,1);
while start_point<=n-1
    next_point=start_point+1;
    next_test_point=start_point+1;
    while 1
        flag=1; %�м����ϰ��ı��
        if route(1,start_point)<route(1,next_test_point)
            gap1=1;
        else
            gap1=-1;
        end
        if route(2,start_point)<route(2,next_test_point)
            gap2=1;
        else
            gap2=-1;
        end
        for i=route(1,start_point):gap1:route(1,next_test_point)
            for j=route(2,start_point):gap2:route(2,next_test_point)
                if map(i,j)==wall;
                    flag=0; %����м����ϰ��������0
                end
            end
        end
        if flag==1 %�м����ϰ�
            next_point=next_test_point;
            next_test_point=next_test_point+1;
            if next_test_point==n+1
                break
            end
        else %�м����ϰ�
            break;
        end
    end
    start_point=next_point;
    new_route=[new_route route(:,next_point)];
end
route=new_route;

%% 2�����������ľ��볬��max_dis,���������м����һ����
i=1;
while i<=size(route,2)-1
    if distance(route(1,i+1),route(2,i+1),route(1,i),route(2,i))>max_dis
        tmp_x=round((route(1,i+1)+route(1,i))/2);
        tmp_y=round((route(2,i+1)+route(2,i))/2);
        % ��ԭ�ȵ�route�У��ҵ���tmp_x,tmp_y����ĵ�
        tmp_index=1;
        tmp_min=999;
        for j=1:size(original_route,2)
            tmp_dis=distance(original_route(1,j),original_route(2,j),...
                tmp_x,tmp_y);
            if tmp_dis<tmp_min
                tmp_min=tmp_dis;
                tmp_index=j;
            end
        end
        tmp_x=original_route(1,tmp_index);
        tmp_y=original_route(2,tmp_index);
        %���������뵽�µ�route��
        route=[route(:,1:i),[tmp_x;tmp_y],route(:,i+1:end)] ;
    else
        i=i+1;
    end
end

%% 3���ٶ�·������һ�μ�
%% �ϲ����ڵ�
i=2;
while i<=size(route,2)-2
    if distance(route(1,i+1),route(2,i+1),route(1,i),route(2,i))<min_dis
        route(1,i)=(route(1,i+1)+route(1,i))/2;
        route(2,i)=(route(2,i+1)+route(2,i))/2;
        route(:,i+1)=[];
    end
    i=i+1;
end

%% ���
new_route=route;


   
   
   
   


