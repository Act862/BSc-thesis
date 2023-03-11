clear all

dB = -6:3:15;
P = 10.^(dB./10);      % TX power
L = 100;             % Lengh in channel uses of the given sub-codeword 
R = 1;               % Data Rate

Nof_samples = 10^4; 

Pout = zeros(Nof_samples,length(P));
Pout2 = zeros(Nof_samples,length(P));
Pout3 = zeros(Nof_samples,length(P));
Approx_Pout = zeros(Nof_samples,length(P));
theta_m = zeros(1,length(P));
b_m = zeros(1,length(P));

h_samples = (randn(1,Nof_samples) + 1i*randn(1,Nof_samples))/sqrt(2);
x = abs(h_samples).^2; % Channel gains


for j = 1 : length(P),
    
    theta_m(j) = (exp(R)-1)/P(j);
    b_m(j) = sqrt(L*P(j)^2/(exp(2*R)-1));
    
    for i = 1 : Nof_samples,    
        A = sqrt(L)*log(1+x(i)*P(j))-R;
        B = sqrt(1-1/((1+x(i)*P(j))^2));
        
        %%
        Pout(i,j) = qfunc(A/B);
        
        %%
        % the following Pout 2 and Pout 3 are given, respectively, as per
        % Eqs. (4) and (13) in:
        % H. Fu, M. W. Wu, and P. Y. Kam, "Explicit, closed-form performance analysis 
        % in fading via new bound on Gaussian Q-function," in IEEE Int. Conf. Commun. (ICC),
        % Jun. 2013, pp. 5819–5823. 
        if A <= 0,
            Pout2(i,j) = 1;
            Pout3(i,j) = 1;
        else
            Pout2(i,j) = exp(-((A/B)^2)/2)/((A/B)*sqrt(2*pi)); 
            Pout3(i,j) = exp(-((A/B)^2)/2)/((A/B)*sqrt(2*pi)) - exp(-((A/B)^2))/((A/B)*2*sqrt(2*pi)) - exp(-3*((A/B)^2))/((A/B)*6*sqrt(2*pi)); 
        end;
        %%
        
        Temp_1 = theta_m(j) - sqrt(pi/(2*(b_m(j)^2)));
        Temp_2 = theta_m(j) + sqrt(pi/(2*(b_m(j)^2)));
        if x(i) <= Temp_1,
            Approx_Pout(i,j) = 1;
        elseif x(i) > Temp_1 && x(i) < Temp_2,
            Approx_Pout(i,j) = 1/2-b_m(j)*(x(i)-theta_m(j))/sqrt(2*pi);
        else 
            Approx_Pout(i,j) = 0;
        end;
    
    
    end;
end;


figure;
mean_Pout = mean(Pout,1);
mean_Pout2 = mean(Pout2,1);
mean_Pout3 = mean(Pout3,1);
mean_Approx_Pout = mean(Approx_Pout,1); 
set(gca,'fontname','times','fontsize',18)
subplot(1,2,1)
plot(dB,mean_Pout,'b-o','LineWidth',1.5); hold on; 
plot(dB,mean_Approx_Pout,'r-*','LineWidth',1.5); grid on;
plot(dB,smooth(mean_Pout2),'g--*','LineWidth',1.5); grid on;
plot(dB,smooth(mean_Pout3),'m--*','LineWidth',1.5); grid on;
legend('Q-Function','Approximation (Makki et.al.)','Upper bound (1 term)','Upper bound (3 terms)', 'location','northeast')
ylabel('Outage Probability', 'FontSize',20,'fontWeight', 'bold')
xlabel('Input SNR (dB)', 'FontSize',20,'fontWeight', 'bold')
axis([dB(1) dB(length(dB)) 0 1])

subplot(1,2,2)
semilogy(dB,mean_Pout,'b-o','LineWidth',1.5); hold on; 
semilogy(dB,mean_Approx_Pout,'r-*','LineWidth',1.5); grid on;
semilogy(dB,smooth(mean_Pout2),'g--*','LineWidth',1.5); grid on;
semilogy(dB,smooth(mean_Pout3),'m--*','LineWidth',1.5); grid on;
legend('Q-Function','Approximation (Makki et.al.)','Upper bound (1 term)','Upper bound (3 terms)', 'location','southwest')
ylabel('Outage Probability', 'FontSize',20,'fontWeight', 'bold')
xlabel('Input SNR (dB)', 'FontSize',20,'fontWeight', 'bold')
axis([dB(1) dB(length(dB)) 0 1])