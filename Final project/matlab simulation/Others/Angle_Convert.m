function theta = Angle_Convert( theta,mean )
if nargin==1
    mean=0;
end
%把一个角度变换到-pi~pi
while theta>pi+mean,theta=theta-2*pi;end
while theta<=-pi+mean,theta=theta+2*pi;end
end

