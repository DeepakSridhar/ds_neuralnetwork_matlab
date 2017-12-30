function  dx = sys_ltv_secondOrder_data2(t, x, a0, a1, a2)
    dx=zeros(2,1);
	x1=x(1);
	x2=x(2);
	dx(1)=x2;
	dx(2)=(-x2*(t^a1+a2))-(a0*x1)+((120*sin(t))/(t+1000));
end