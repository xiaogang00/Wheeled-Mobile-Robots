function [ vleft,vright ] = clockwise45( v,car_length,wheel_radius )
%CLOCKWISE45 Summary of this function goes here
%   Detailed explanation goes here
R=0.5*tan(135/2/180*pi);
vright=-v*(R-car_length/2)/(R*wheel_radius);
vleft=-(R+car_length/2)*vright/(R-car_length/2);

end

