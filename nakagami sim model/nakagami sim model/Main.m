% Simulation setup Date 20210729
% Nakagami fading parameter m.
clear all
close all

omega=1; % scaling factor
imL=10; % same as rician fadding, imL>=3 ( Nakagami fading parameter m) also called shape parameter


%% Sim model for  im>=3 (or LoS rician channel)
for i =1:1000000
 NakL(i)= Nakagami1(imL, omega); % for LoS, im>=3
end


%% Numerical model im>=3 (or LoS rician channel)
 w = 1;% Same as omega above 

x = [0:0.05:3];
m =10; %( Nakagami fading parameter m)
for ii = 1:length(x)

y(ii)=((2*m^m)/(gamma(m)*w^m))*x(ii)^(2*m-1)*exp(-((m/w)*x(ii)^2));
 
end
figure  
histogram(NakL, "normalization","pdf") ;

 hold on
plot(x,y)
h=legend(' Sim. Nakagami fadding m = 10' , 'Num. Nakagami fadding m = 10');
set(h,'Interpreter','latex');
set(h,'FontSize',20);
set(gca,  'FontName', 'century')
set(gca,'fontsize',20);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sim model im<3 (or NLoS Rayliegh channel)
imN=1; % same as rayliegh fadding, im<3 ( Nakagami fading parameter m) also called shape parameter
for i =1:1000000
    NakN(i)= Nakagami2(imN); %for NLOS, im<3
end


%% Numerical model im<3 (or NLoS Rayliegh channel)
 w = 1;% Same as omega above 

x = [0:0.05:3];
m =1; %( Nakagami fading parameter m)
for ii = 1:length(x)

y(ii)=((2*m^m)/(gamma(m)*w^m))*x(ii)^(2*m-1)*exp(-((m/w)*x(ii)^2));
 
end
figure  
histogram(NakN, "normalization","pdf") ;

 hold on
plot(x,y)
h=legend(' Sim. Nakagami fadding m = 1' , 'Num. Nakagami fadding m = 1');
set(h,'Interpreter','latex');
set(h,'FontSize',20);
set(gca,  'FontName', 'century')
set(gca,'fontsize',20);