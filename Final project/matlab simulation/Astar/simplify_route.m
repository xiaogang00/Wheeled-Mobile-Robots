function new_route = simplify_route( route,map )
% 该函数的功能是简化路径
% 在原结点序列A1,A2,...,An中，如果A1、An构成的长方形内没有障碍物
% 则删去 A2,...,An-1，将路径简化为A1,An

if size(route,1)~=2
    route=route';
end %转置成行向量

wall=-1; 
space=2;
n=size(route,2);
start_point=1;
new_route=route(:,1);
while start_point<=n-1
    next_point=start_point+1;
    next_test_point=start_point+1;
    while 1
        flag=1; %中间无障碍的标记
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
                    flag=0; %如果中间有障碍，标记置0
                end
            end
        end
        if flag==1 %中间无障碍
            next_point=next_test_point;
            next_test_point=next_test_point+1;
            if next_test_point==n+1
                break
            end
        else %中间有障碍
            break;
        end
    end
    start_point=next_point;
    new_route=[new_route route(:,next_point)];
end
end



