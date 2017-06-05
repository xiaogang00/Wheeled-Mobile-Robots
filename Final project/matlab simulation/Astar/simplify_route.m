function new_route = simplify_route( route,map )
% �ú����Ĺ����Ǽ�·��
% ��ԭ�������A1,A2,...,An�У����A1��An���ɵĳ�������û���ϰ���
% ��ɾȥ A2,...,An-1����·����ΪA1,An

if size(route,1)~=2
    route=route';
end %ת�ó�������

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
end



