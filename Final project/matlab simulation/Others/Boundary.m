function x = Boundary( x,m,fl )
    %把x变换到[m-fl,m+fl]的区域内
    x = max(min(x,m+fl),m-fl);%上下界函数
end

