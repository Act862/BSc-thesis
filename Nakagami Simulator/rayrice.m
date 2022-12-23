clear
%rayrice.m
%Gayatrii Prabhu and P. M. Shankar
%generates Rayleigh and Rician faded signal with 10 multiple paths
%by varying the number of paths, it is possible to get an idea on how many paths are required
%for Rayleigh fading (numpaths)
v=input('MU speed in m/s....5, 10, 15, 20, 25,..>');
numpaths = 10; %number of paths
Fc = 900e6; %carrier frequency
Fs = 4*Fc; %sampling frequency
Ts = 1/Fs; %sampling period
t = [0:Ts:1999*Ts]; %time array
wc = 2*pi*Fc; %radian frequency
%v = 25; %vehicle speed in m/s

   	ray = zeros(1,length(t)); %received signal

	for i = 1:numpaths
    	wd = 2*pi*v*Fc*cos(unifrnd(0,2*pi))/3e8;
		a =  weibrnd(1,3,1,length(t)); 
		ray = ray + a.*cos((wc+wd)*t+unifrnd(0,2*pi,1,length(t)));
   	end;

	[rayi rayq] = demod(ray,Fc,Fs,'qam'); %demodulated signal 
	env_ray = sqrt(rayi.^2+rayq.^2); %envelope of received signal 
    mean(env_ray)
    subplot(2,2,1)
plot(t*1e9,ray,'k')%plots the rf signal
%title('rf signal')
xlabel('time (ns)')
ylabel('rf signal  (volt)')
ylim([-10 10])
xlim([0 20])
subplot(2,2,3)
plot(t*1e9,env_ray,'k',t*1e9,mean(env_ray),'k')%plots the envelope
%title('envelope')
xlabel('time (ns)')
ylabel('envelope (volt)')
xlim([0 20])
ylim([0 10])


rice = zeros(1,length(t)); %received signal

for i = 1:numpaths-1
   	wd = 2*pi*v*Fc*cos(unifrnd(0,2*pi))/3e8;
	a = weibrnd(1,3,1,length(t)); 
	rice = rice + a.*cos((wc+wd)*t+unifrnd(0,2*pi,1,length(t)));
end;

wd = 2*pi*v*Fc/3e8;
rice = rice + 2.8*cos((wc+wd)*t);

[ricei riceq] = demod(rice,Fc,Fs,'qam'); %demodulated signal 
env_rice = sqrt(ricei.^2+riceq.^2); %envelope of received signal 
mean(env_rice)
subplot(2,2,2)
plot(t*1e9,rice,'k')%plots the rf signal
%title('rf signal')
xlabel('time (ns)')
ylabel('rf signal  (volt)')
xlim([0 20])
ylim([-10 10])
subplot(2,2,4)
%thrshold value is fixed at the average value of the envelope in the Rayleigh case
plot(t*1e9,env_rice,'k',t*1e9,mean(env_ray),'k')%plots the envelope
%title('envelope')
xlabel('time (ns)')
ylabel('envelope (volt)')
xlim([0 20])
ylim([0 10])

