clear
%Gayatri Prabhu and P. M. Shankar
%ricegen.m
%generates a fading signal where a direct (LOS) component is present
%generates the RF signal, in phase and quadrature components, the envelope and the density functions
%can also be used to calculate the outage
v=input('MU speed in m/s....5, 10, 15, 20, 25,..>');
numpaths = 10; %number of paths
Fc = 900e6; %carrier frequency
Fs = 4*Fc; %sampling frequency
Ts = 1/Fs; %sampling period
t = [0:Ts:1999*Ts]; %time array
wc = 2*pi*Fc; %radian frequency
v = 25; %vehicle speed in m/s

rice = zeros(1,length(t)); %received signal

for i = 1:numpaths-1
   	wd = 2*pi*v*Fc*cos(unifrnd(0,2*pi))/3e8;
	a = weibrnd(1,3,1,length(t)); 
	rice = rice + a.*cos((wc+wd)*t+unifrnd(0,2*pi,1,length(t)));
end;

wd = 2*pi*v*Fc/3e8;
rice = rice + 4.5*cos((wc+wd)*t);

[ricei riceq] = demod(rice,Fc,Fs,'qam'); %demodulated signal 
env_rice = sqrt(ricei.^2+riceq.^2); %envelope of received signal 
subplot(2,2,1)
plot(t*1e9,rice)%plots the rf signal
title('rf signal')
xlabel('time ns')
ylabel('volt')
xlim([0 20])
subplot(2,2,2)
plot(t*1e9,ricei)%plots the inphase component
xlabel('time ns')
ylabel('volt')
xlim([0 20])
title('inphase component')
subplot(2,2,3)
plot(t*1e9,riceq)%plots the quadrature component
title('quadrature component')
xlabel('time ns')
ylabel('volt')
xlim([0 20])
subplot(2,2,4)
plot(t*1e9,env_rice)%plots the envelope
title('envelope')
xlabel('time ns')
ylabel('volt')
xlim([0 20])
y = sort(env_rice);

b = sqrt((std(ricei)^2 + std(riceq)^2)/2); %Rician parameter
a = mean(ricei); %Rician parameter
I = besseli(0,y.*(a/b^2));
fyrice = (y./b^2).*exp(-(a^2+y.^2)./(2*b^2)).*I;

m=mean(y.^2)^2/mean((y.^2-mean(y.^2)).^2); %Nakagami m parameter
omega=mean(y.^2); %Nakagami parameter
fynaka = (2*m^m*y.^(2*m-1).*exp(-(m*y.^2)./omega))./(gamma(m)*omega^m);


h=18;
x1=hist(y,h);
x1=x1./max(x1);
y=y./max(y);

x2=fyrice;
x2=x2./max(x2);

x3=fynaka;
x3=x3./max(x3);
 
figure
plot(0:1/h:1-1/h,x1,':')
hold on
plot(y,x2)
hold on
plot(y,x3,'--')
xlabel('Envelope r');
ylabel('Probability density function f(r)');


power_rice=env_rice.^2;
powerdB=10*log10(power_rice);
mean_power=10*log10(mean(env_rice.^2))
MK=length(env_rice)
for k=1:20;
    pow(k)=mean_power-2*k; %threshold power
    kps=pow(k);
    count=0;
    for ku=1:MK;
        power=powerdB(ku);%power in dB
        if power <= kps
            count=count+1;
        else
        end;
    end;
        poutsim(k)=count/MK;%outage probability simulated
        kbs=10^(kps/10);%power in mW
        poutth(k)=1-marcumq(a/b,sqrt(kbs)/b);%from the communications toolbox
end;
figure
plot(pow,poutsim,pow,poutth);
xlabel('thrshold power dBm')
ylabel('outage probability')
legend('poutth','poutsim')
