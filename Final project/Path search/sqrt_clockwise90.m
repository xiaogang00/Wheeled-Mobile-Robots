function [ vleft,vright ] = sqrt_clockwise90( v ,car_length,wheel_radius)
%SQRT_CLOCKWISE90 Summary of this function goes here
%   Detailed explanation goes here
R=0.5*sqrt(2);
vright=-v*(R-car_length/2)/(R*wheel_radius);
vleft=-(R+car_length/2)*vright/(R-car_length/2);

end

