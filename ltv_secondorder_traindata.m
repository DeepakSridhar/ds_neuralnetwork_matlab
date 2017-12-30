%% Author - DS %%
tic
clc
clearvars  

a=0;                        % start time
b=10;                        % end time
fs=1000;                    % sampling frequency
t_array=linspace(a,b,fs);   % sampling time instants
n=1700;                     % no of examples
c = 0;
d = 10;
r0 = randi([c d],1,n);
r1 = randi([c d/2],1,n);
r2 = randi([c d],1,n);
y_n=zeros(n,fs);

parfor i=1:n

    a0=r0(i);
    a1=r1(i);
    a2=r2(i);
    options=[];
    x0 = [1; 0];
    [~, x_array] = ode45(@sys_ltv_secondOrder_data,t_array,x0,options,a0,a1,a2);
    y=x_array(:,1); % y_noisy = awgn(y,30);%measured signal with error%
    y_n(i,:) = y;
    
end
X1=y_n;
y1=repmat([1 0 0],n,1);
clearvars -except X1 y1
save('ltv_secondorder_traindata1f');




a=0;                        % start time
b=10;                        % end time
fs=1000;                    % sampling frequency
t_array=linspace(a,b,fs);   % sampling time instants
n=1600;                     % no of examples
c = 0;
d = 10;
r0 = randi([c d],1,n);
r1 = randi([c d/2],1,n);
r2 = randi([c d],1,n);
y_n=zeros(n,fs);

parfor i=1:n

    a0=r0(i);
    a1=r1(i);
    a2=r2(i);
    options=[];
    x0 = [1; 0];
    [~, x_array] = ode45(@sys_ltv_secondOrder_data2,t_array,x0,options,a0,a1,a2);
    y=x_array(:,1); % y_noisy = awgn(y,30);%measured signal with error%
    y_n(i,:) = y;
    
end
X2=y_n;
y2=repmat([0 1 0],n,1);
clearvars -except X2 y2 X1 y1
save('ltv_secondorder_traindata2f');





a=0;                        % start time
b=10;                       % end time
fs=1000;                    % sampling frequency
t_array=linspace(a,b,fs);   % sampling time instants
n=1700;                     % no of examples
c = 0;
d = 10;
r0 = randi([c d/2],1,n);
r1 = randi([c d],1,n);
r2 = randi([c d/2],1,n);
r3 = randi([c d],1,n);
y_n=zeros(n,fs);

parfor i=1:n

    a0=r0(i);
    a1=r1(i);
    a2=r2(i);
    a3=r3(i);
    options=[];
    x0 = [1; 0];
    [~, x_array] = ode45(@sys_ltv_secondOrder_data3,t_array,x0,options,a0,a1,a2,a3);
    y=x_array(:,1); % y_noisy = awgn(y,30);%measured signal with error%
    y_n(i,:) = y;
    
    
end
X3=y_n;
y3=repmat([0 0 1],n,1);
clearvars -except X3 y3 X2 y2 X1 y1
X=[X1;X2;X3];
y=[y1;y2;y3];
p=randperm(5000);
X=X(p,:);
y=y(p,:);
X_train=X(1:3000,:);
X_dev=X(3001:4000,:);
X_test=X(4001:5000,:);
y_train=y(1:3000,:);
y_dev=y(3001:4000,:);
y_test=y(4001:5000,:);
save('ltv_secondorder_traindataf');
toc
