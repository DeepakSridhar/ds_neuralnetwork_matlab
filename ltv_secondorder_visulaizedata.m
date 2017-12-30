%% Author Deepak Sridhar %%

% Visualize data%
tic
clc
clearvars  
load('ltv_secondorder_traindata.mat');

a=0;                        % start time
b=1;                        % end time
fs=1000;                    % sampling frequency
t_array=linspace(a,b,fs);   % sampling time instants
n=10;                     % no of examples
sel1 = randperm(size(X1, 1));
sel1 = sel1(1:n);
figure
hold on

for i=1:n
    plot(t_array, X(sel1(i),:));
    hold on
end
  

sel2 = randperm(4000,2001);
sel2 = sel2(1:n);
figure
hold on

for i=1:n
    plot(t_array, X(sel2(i),:));
    hold on
end

sel3 = randperm(6000,4001);
sel3 = sel3(1:n);
figure
hold on

for i=1:n
    plot(t_array, X(sel3(i),:));
    hold on
end