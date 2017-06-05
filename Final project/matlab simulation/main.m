%% 新版全局路径规划算法
%% 重点更新内容：
% 1、A*算法的估值函数中，引入了障碍物的势场（Astar_potential函数），
%    使得路径点在非必要时会与墙壁隔一段距离
% 2、换了一个路径简化函数，删除路径的各段直线中，非端点的路径点
% 3、速度计算函数。采用了网上一个工具包里的算法（并修正了其中一个重大错误！），
%    使得路径更平滑，而且可以设置初始和末尾的角度约束。

%% 读取地图信息

global length_per_dot safe_distance length_of_the_matrix
length_per_dot=0.1;     % 每个像素点对应的边长
length_of_the_map=[4 4];% 地图的总高和总宽
length_of_the_matrix=length_of_the_map/length_per_dot;%二值化矩阵的行数和列数
Car_Length=0.4;%车的长度
safe_distance=0.2+Car_Length/2;%安全距离

%% 调用读取地图的函数，自动生成地图矩阵以及起点、终点坐标
filename='map3.jpg';
[MAP,start_x, start_y, target_x, target_y]=map2(filename,length_of_the_matrix); %手绘地图

EMAP=MAP;
find_route=0;
round=0;
%为使得路径点远离墙壁：①是在A*算法中加入了势场，②是使用如下的膨胀障碍物方法
% Expand_Time=safe_distance/length_per_dot;%方法②中的膨胀次数
Expand_Time=1;%经测试，只使用方法①时就可以了。令障碍物膨胀的次数为0
while round<Expand_Time
    tmproute=Astar(EMAP, start_x, start_y, target_x, target_y)';%调用A*算法
    if same(tmproute,-1)==0 %如果route~=-1，说明找到了路径
        route=tmproute;
        route=simplify_route( route,EMAP,length_per_dot); %两个路径点间如果没有障碍物，则期间的路径点也要删去
        find_route=1;
    else
        break;
    end
    round=round+1;
end


%% 路径点的坐标系变换到标准的直角坐标系
route=(route-1/2)*length_per_dot;%将路经点的单位转换为米
route=[route(2,:);route(1,:)];%原先是(↓，→)，现在是(→，↑)
route(2,:)=length_of_the_map(1)-route(2,:);

%% 计算每一个路径点的角度约束
route=route';%反转成列
n=size(route,1);
route_Angle=zeros(n,1);%新的一列，存储每个路径点的斜率
for i=2:n-1 %计算斜率
    angle_last=atan2( route(i,2)-route(i-1,2),route(i,1)-route(i-1,1));
    angle_next=atan2( route(i+1,2)-route(i,2),route(i+1,1)-route(i,1));
    angle_next=Angle_Convert(angle_next,angle_last);
    route_Angle(i)=(angle_next+angle_last)/2;
    route_Angle(i)=Angle_Convert(route_Angle(i));
end
route=[route,route_Angle];%route_Angle加入route中

%% 设置起点和终点的斜率
if 1 % 是否自动计算起点和终点的角度
    Start_Angle=atan2( route(2,2)-route(1,2),route(2,1)-route(1,1));%起点角度约束
    Goal_Angle=atan2( route(n,2)-route(n-1,2),route(n,1)-route(n-1,1));%终点角度约束
else %否则手动输入
    Start_Angle=-pi;%起点角度约束
    Goal_Angle=0;%终点角度约束
end
route(1,3)=Start_Angle;
route(end,3)=Goal_Angle;

%% 调用仿真程序
Pos_Start=[route(1,:)];%起始位置和角度
Pos_Goal=[route(end,:)];%终止位置和角度
track_plan;