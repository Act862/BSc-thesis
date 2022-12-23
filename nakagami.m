% this code is written by Jamal A. Hussein
% barznjy79@yahoo.com
% all rights reserved
clc; clear all; close all;
colors=['r','g','b', 'c', 'm', 'y', 'k'] ;
m = 1;
x = [0:0.05:7];
for w = 1:7
for ii = 1:length(x)
y(ii)=((2*m^m)/(gamma(m)*w^m))*x(ii)^(2*m-1)*exp(-((m/w)*x(ii)^2));
 
end
plot(x,y,colors(w))
hold on
end
xlabel('Support'); 
ylabel('PDF'); 
title('probability density function')
hleg1 = legend('w=1','w=2','w=3');
set(hleg1,'Location','NorthEast')
axis([0 3 0 2]);
grid on 