function [ vleft,vright ] = anticlockwise90( v,car_length,wheel_radius )
%ANTICLOCKWISE90 Summary of this function goes here
%   Detailed explanation goes here
R=0.5;
vleft=v*(R-car_length/2)/(R*wheel_radius);
vright=-(R+car_length/2)*vleft/(R-car_length/2);

end

