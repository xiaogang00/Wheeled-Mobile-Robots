function x = Boundary( x,m,fl )
    %��x�任��[m-fl,m+fl]��������
    x = max(min(x,m+fl),m-fl);%���½纯��
end

