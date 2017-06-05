function [ vleft,vright ] = sqrt_anticlockwise90( v,car_length,wheel_radius )
%SQRT_ANTICLOCKWISE90 Summary of this function goes here
%   Detailed explanation goes here
R=0.5*sqrt(2);
vleft=v*(R-car_length/2)/(R*wheel_radius);
vright=-(R+car_length/2)*vleft/(R-car_length/2);

end

