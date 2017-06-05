function new_route = simplify_route( route,map,length_per_dot )
%% 共四步
% 0、如果N1、Ni点的连线中，有N2、N3、...、Ni-1，则把N2、N3、...、Ni-1删掉
% 得到的结果，可能会出现一些不必要的折线

% 1、在原结点序列A1,A2,...,An中，如果A1、An构成的长方形内没有障碍物
% 则删去 A2,...,An-1，将路径简化为A1,An

% 2、如果两个点的距离超过max_dis,则在它们中间插入一个点
max_dis=1.2/length_per_dot;

% 3、如果两个点的距离小于min_dis，则把它们缩减为一个点
min_dis=0.2/length_per_dot;% 如果两个点很近，则把它们合并为一个点

%%
original_route=route;

%% 0、如果N1、Ni点的连线中，有N2、N3、...、Ni-1，则把N2、N3、...、Ni-1删掉
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
            % 如果下一点的增量仍相同
            Current_Detecting_Index=Current_Detecting_Index+1;
        else % 如果下一点的增量不同，则Current_Detecting_Index为一个分界线
            New_Index_Array=[New_Index_Array,Current_Detecting_Index];
            Start_Index=Current_Detecting_Index;
            break; %退出循环，从分界线开始，开始新一轮的循环
        end
    end
end
% 由于末尾加了一个转折点，所以当Start_Index==n时，循环结束
new_route=[];
for i=1:length(New_Index_Array)
    new_route(:,i)=route(:,New_Index_Array(i));
end
route=new_route;


%% 1、在原结点序列A1,A2,...,An中，如果A1、An构成的长方形内没有障碍物
%  则删去 A2,...,An-1，将路径简化为A1,An
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
route=new_route;

%% 2、如果两个点的距离超过max_dis,则在它们中间插入一个点
i=1;
while i<=size(route,2)-1
    if distance(route(1,i+1),route(2,i+1),route(1,i),route(2,i))>max_dis
        tmp_x=round((route(1,i+1)+route(1,i))/2);
        tmp_y=round((route(2,i+1)+route(2,i))/2);
        % 在原先的route中，找到和tmp_x,tmp_y最近的点
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
        %把这个点插入到新的route中
        route=[route(:,1:i),[tmp_x;tmp_y],route(:,i+1:end)] ;
    else
        i=i+1;
    end
end

%% 3、再对路径点做一次简化
%% 合并相邻点
i=2;
while i<=size(route,2)-2
    if distance(route(1,i+1),route(2,i+1),route(1,i),route(2,i))<min_dis
        route(1,i)=(route(1,i+1)+route(1,i))/2;
        route(2,i)=(route(2,i+1)+route(2,i))/2;
        route(:,i+1)=[];
    end
    i=i+1;
end

%% 输出
new_route=route;


   
   
   
   


