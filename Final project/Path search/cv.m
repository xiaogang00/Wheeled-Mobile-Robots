function [ vleft vright ] = cv( v,wheel_radius )
%CV Summary of this function goes here
%   Detailed explanation goes here
vleft=v/wheel_radius;
vright=-v/wheel_radius;

end

