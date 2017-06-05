function theta = CalInnerAngleOfTriangle( A,B,C )
AB=distance(A(1),A(2),B(1),B(2));
AC=distance(A(1),A(2),C(1),C(2));
BC=distance(C(1),C(2),B(1),B(2));
theta=acos( (AB^2+AC^2-BC^2)/(2*AB*AC) );
end

