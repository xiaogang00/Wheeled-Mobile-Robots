Optimal_path = [10 10
     9 10
     8 10
     7 9
     6 8
     5 7
     5 6
     4 5
     3 4
     2 4
     1 3
     1 2];
element_num = size(Optimal_path,1);
Optimal_path(element_num+1,1) = 1;
Optimal_path(element_num+1,2) = 1;
xTarget=10;
yTarget=10;
v=0.5;
car_length=1;%车长
wheel_radius=1;%轮子半径
%x为所在横坐标，y为所在纵坐标，x_1=x2-x1,x_2=x3-x2,y_1=y2-y1,y_2=y3-y2
count = 0.5/v*10;
i = 1;
while count~=0
    [vleft(i),vright(i)]=av(v,wheel_radius);
    count = count-1;
    i = i+1;
end
x = Optimal_path(element_num,1);
y = Optimal_path(element_num,2);
while x~=xTarget||y~=yTarget
    x_1 = Optimal_path(element_num,1)-Optimal_path(element_num+1,1);
    y_1 = Optimal_path(element_num,2)-Optimal_path(element_num+1,2);
    x_2 = Optimal_path(element_num-1,1)-Optimal_path(element_num,1);
    y_2 = Optimal_path(element_num-1,2)-Optimal_path(element_num,2);
    if x_1==-1&&y_1==0&&x_2==-1&&y_2==0||x_1==0&&y_1==-1&&x_2==0&&y_2==-1||x_1==0&&y_1==1&&x_2==0&&y_2==1||x_1==1&&y_1==0&&x_2==1&&y_2==0
        count = 1/v*10;
        while count~=0
            [vleft(i),vright(i)]=av(v,wheel_radius);%直走
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==-1&&x_2==-1&&y_2==-1||x_1==-1&&y_1==1&&x_2==-1&&y_2==1||x_1==1&&y_1==-1&&x_2==1&&y_2==-1||x_1==1&&y_1==1&&x_2==1&&y_2==1
        count = round(sqrt(2)/v*10);
        while count~=0
            [vleft(i),vright(i)]=cv(v,wheel_radius);%走斜线
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==0&&x_2==-1&&y_2==-1||x_1==0&&y_1==-1&&x_2==1&&y_2==-1||x_1==0&&y_1==1&&x_2==-1&&y_2==1||x_1==1&&y_1==0&&x_2==1&&y_2==1
        count = round(0.5*tan(135/2/180*pi)*2*pi/8/v*10);
        while count~=0
            [vleft(i),vright(i)]=anticlockwise45(v,car_length,wheel_radius);%逆时针转
            i = i+1;
            count = count-1;
        end
        count = round((0.5*sqrt(2)-0.5)/v*10);
        while count~=0
            [vleft(i),vright(i)]=cv(v,wheel_radius);
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==0&&x_2==-1&&y_2==1||x_1==0&&y_1==-1&&x_2==-1&&y_2==-1||x_1==0&&y_1==1&&x_2==1&&y_2==1||x_1==1&&y_1==0&&x_2==1&&y_2==-1
        count = round(0.5*tan(135/2/180*pi)*2*pi/8/v*10);
        while count~=0
            [vleft(i),vright(i)]=clockwise45(v,car_length,wheel_radius);%顺时针转
            i = i+1;
            count = count-1;
        end
        count = round((0.5*sqrt(2)-0.5)/v*10);
        while count~=0
            [vleft(i),vright(i)]=cv(v,wheel_radius);
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==-1&&x_2==-1&&y_2==0||x_1==-1&&y_1==1&&x_2==0&&y_2==1||x_1==1&&y_1==-1&&x_2==0&&y_2==-1||x_1==1&&y_1==1&&x_2==1&&y_2==0
        count = round((0.5*sqrt(2)-0.5)/v*10);
        while count~=0
            [vleft(i),vright(i)]=cv(v,wheel_radius);
            i = i+1;
            count = count-1;
        end
        count = round(0.5*tan(135/2/180*pi)*2*pi/8/v*10);
        while count~=0
            [vleft(i),vright(i)]=clockwise45(v,car_length,wheel_radius);%顺时针转
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==-1&&x_2==0&&y_2==-1||x_1==-1&&y_1==1&&x_2==-1&&y_2==0||x_1==1&&y_1==-1&&x_2==1&&y_2==0||x_1==1&&y_1==1&&x_2==0&&y_2==1
        count = round((0.5*sqrt(2)-0.5)/v*10);
        while count~=0
            [vleft(i),vright(i)]=cv(v,wheel_radius);
            i = i+1;
            count = count-1;
        end
        count = round(0.5*tan(135/2/180*pi)*2*pi/8/v*10);
        while count~=0
            [vleft(i),vright(i)]=anticlockwise45(v,car_length,wheel_radius);%逆时针转
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==0&&x_2==0&&y_2==1||x_1==0&&y_1==-1&&x_2==-1&&y_2==0||x_1==0&&y_1==1&&x_2==1&&y_2==0||x_1==1&&y_1==0&&x_2==0&&y_2==-1
        count = round(2*pi*0.5/4/v*10);
        while count~=0
            [vleft(i),vright(i)]=clockwise90(v,car_length,wheel_radius);%90度顺时针
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==0&&x_2==0&&y_2==-1||x_1==0&&y_1==-1&&x_2==1&&y_2==0||x_1==0&&y_1==1&&x_2==-1&&y_2==0||x_1==1&&y_1==0&&x_2==0&&y_2==1
        count = round(2*pi*0.5/4/v*10);
        while count~=0
            [vleft(i),vright(i)]=anticlockwise90(v,car_length,wheel_radius);%90度逆时针
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==-1&&x_2==-1&&y_2==1||x_1==-1&&y_1==1&&x_2==1&&y_2==1||x_1==1&&y_1==-1&&x_2==-1&&y_2==-1||x_1==1&&y_1==1&&x_2==1&&y_2==-1
        count = round(2*pi*0.5*sqrt(2)/4/v*10);
        while count~=0
            [vleft(i),vright(i)]=sqrt_clockwise90(v,car_length,wheel_radius);%顺时针
            i = i+1;
            count = count-1;
        end
    end
    if x_1==-1&&y_1==-1&&x_2==1&&y_2==-1||x_1==-1&&y_1==1&&x_2==-1&&y_2==-1||x_1==1&&y_1==-1&&x_2==1&&y_2==1||x_1==1&&y_1==1&&x_2==-1&&y_2==1
        count = round(2*pi*0.5*sqrt(2)/4/v*10);
        while count~=0
            [vleft(i),vright(i)]=sqrt_anticlockwise90(v,car_length,wheel_radius);%逆时针
            i = i+1;
            count = count-1;
        end
    end
    element_num = element_num-1;
    x = Optimal_path(element_num,1);
    y = Optimal_path(element_num,2);
end
count = 0.5/v*10;
while count~=0
    [vleft(i),vright(i)]=av(v,wheel_radius);
    count = count-1;
    i = i+1;
end