function  dx = sys_ltv_secondOrder_example(t, x)
    dx=zeros(2,1);
	x1=x(1);
	x2=x(2);
	dx(1)=x2;
    dx(2)=-(1/(t+1e-10))*x2+((120*sin(t))/(t+1000));
% 	dx(2)=(-(10*atan(900*x2))*(3+cos(0.5*pi*t)))-((2+sin(t))*x2)+((300*sin(4*pi*t)))+rand(1)-0.5;
end