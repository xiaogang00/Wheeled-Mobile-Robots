function [ vleft,vright ] = anticlockwise45( v,car_length,wheel_radius )
%ANTICLOCKWISE45 Summary of this function goes here
%   Detailed explanation goes here
R=0.5*tan(135/2/180*pi);
vleft=v*(R-car_length/2)/(R*wheel_radius);
vright=-(R+car_length/2)*vleft/(R-car_length/2);

end

