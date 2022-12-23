clear
%Gayatari Prabhu and P. M. Shankar
%loggen1.m   
%generates a lognormally faded signal with  multipaths (10) and  multiple scattering (5)
%iterated 1000 times to see of the mean is lognormally distributed.
%gives the chi-squate test value as well
close all
numscat = 8; %number of scatterers
numpaths = 10; %number of paths
Fc = 900e6; %carrier frequency
Fs = 4*Fc; %sampling frequency
Ts = 1/Fs; %sampling period
t = [0:Ts:4999*Ts]; %time array
wc = 2*pi*Fc; %radian frequency
v = 1; %vehicle speed in m/s
bins = 20; %bins for chi-square test
numit = 2000; %number of iterations for Rayleigh
meanval = 0;
for i = 1:numit
	ray = zeros(1,length(t)); %received signal
   	for j = 1:numpaths
		wd = 2*pi*v*Fc*cos(unifrnd(0,2*pi))/3e8;
		a = prod(raylrnd(1,1,numscat));
		ray = ray + a*cos((wc+wd)*t+unifrnd(0,2*pi,1,length(t)));
   	end;
	[rayi rayq] = demod(ray,Fc,Fs,'qam'); %demodulated signal 
	env_ray = sqrt(rayi.^2+rayq.^2); %envelope of received signal 
	meanval(i) = mean(env_ray); % mean of Rayleigh envelope
end;

y=sort(meanval./mean(meanval));%mean of y has been made equal to 1
sig=sqrt(log(std(y)^2+1));%parameter sigma for lognormal....... mean of y has been made equal to 1 (inside the bracket)
mu=-sig^2/2; %second parameter for lognormal
fylog=lognpdf(y,mu,sig);% theoretical lognormal pdf based on the data
[h xx]=hist(y,40);%histogram
plot(y/max(y),fylog/max(fylog),'r')
xlabel('Envelope r');
ylabel('Probability density function f(r)');
hold on
plot(xx/max(xx),h/max(h),'k-.')

chi_square=logtest(y,20)%chi square test


