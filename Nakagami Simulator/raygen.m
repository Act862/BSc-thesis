clear
%Gayatrii Prabhu and P. M. Shankar
%generates Rayleigh faded signal with 10 multiple paths
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
    subplot(2,2,1)
plot(t*1e9,ray)%plots the rf signal
title('rf signal')
xlabel('time ns')
ylabel('volt')
xlim([0 20])
subplot(2,2,2)
plot(t*1e9,rayi)%plots the inphase component
xlabel('time ns')
ylabel('volt')
xlim([0 20])
title('inphase component')
subplot(2,2,3)
plot(t*1e9,rayq)%plots the quadrature component
title('quadrature component')
xlabel('time ns')
ylabel('volt')
xlim([0 20])
subplot(2,2,4)
plot(t*1e9,env_ray)%plots the envelope
title('envelope')
xlabel('time ns')
ylabel('volt')
xlim([0 20])

y = sort(env_ray); %unity mean
b = (mean(y)^2)*2/pi; %Rayleigh parameter for unit mean
fyray = (y./b).*exp(-(y.^2/(2*b)));

m=mean(y.^2)^2/mean((y.^2-mean(y.^2)).^2); %Nakagami m parameter
omega=mean(y.^2); %Nakagami parameter
fynaka = (2*m^m*y.^(2*m-1).*exp(-(m*y.^2)./omega))./(gamma(m)*omega^m);

h=18;
x1=hist(y,h);
x1=x1./max(x1);
y=y./max(y);

x2=fyray;
x2=x2./max(x2);
fray=x2;
x3=fynaka;
x3=x3./max(x3);
fynaka=x3;
figure
plot(0:1/h:1-1/h,x1,':')
hold on
plot(y,fray)
hold on
plot(y,fynaka,'--')
xlabel('Envelope r');
ylabel('Probability density function f(r)');

%computation of the outage probabilities
power_ray=env_ray.^2;
powerdB=10*log10(power_ray);
mean_power=10*log10(mean(env_ray.^2))
MK=length(env_ray)
for k=1:20;
    pow(k)=mean_power-2*k; %threshold power
    kps=pow(k);
    ratio=10^(kps/10)/10^(mean_power/10);
    poutth(k)=1-exp(-ratio);%theoretical outage
    count=0;
    for ku=1:MK;
        power=powerdB(ku);%power in dB
        if power <= kps
            count=count+1;
        else
        end;
    end;
        poutsim(k)=count/MK;%outage probability simulated
        
end;
figure
plot(pow,poutth,':',pow,poutsim,'--');
xlabel('thrshold power dBm')
ylabel('outage probability')
legend('poutth','poutsim')


