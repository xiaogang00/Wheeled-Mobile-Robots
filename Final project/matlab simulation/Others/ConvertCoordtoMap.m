function  P=ConvertCoordtoMap( P )
    % 把直角坐标系下的点，转成map中的坐标
    global length_per_dot BIGGER length_of_the_matrix
    P(1:2)=P(1:2).*BIGGER ./length_per_dot;
    if length(P)==3
       P(3)=-P(3); 
    end
    P(2)=length_of_the_matrix(1)*BIGGER-P(2);
end

