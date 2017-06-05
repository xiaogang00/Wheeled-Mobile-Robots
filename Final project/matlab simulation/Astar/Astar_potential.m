function pot=Astar_potential(MAP,node_x,node_y)
global length_per_dot safe_distance
% global potential_map
detect_size= 3*ceil(safe_distance/length_per_dot);%检测起点周围延伸多少范围内的点
[MAX_X, MAX_Y] = size(MAP);
x=node_x;
y=node_y;
pot=0;
pot_add=100*detect_size;
for i=x-detect_size:1:x+detect_size
    for j=y-detect_size:1:y+detect_size
        if i~=x && j~=y
            if (i>=1 && i<=MAX_X && j>=1 && j<=MAX_Y && MAP(i,j)==-1) || ...
                    ~(i>=1 && i<=MAX_X && j>=1 && j<=MAX_Y)
                pot=max(pot,pot_add*1/distance(i,j,x,y));
%                 potential_map(node_x,node_y)=pot/100;
              
            end
        end
    end
end


