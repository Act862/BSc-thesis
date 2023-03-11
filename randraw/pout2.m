clear,clc

% Interference constraint

I = 20;
I = 10^(I/10);


% Sencondary transmit power

P1 = [0:2:30];

P = 10.^(P1/10);

m_sp = 0.5;
Omega_sp = 1;

m_rp = 1;
Omega_rp = 2;

m_sr = 2;
Omega_sr = 0.5;

m_rd = 4;
Omega_rd = 4;

threshold = 5;
threshold = 10^(threshold/10);

Iteration = 1000;

 test1 = zeros(1,length(P));
test2 = zeros(1,length(P));

Pout = zeros(1,length(P));
tic
for i = 1:Iteration,
    h_sp = Nakagamim(1,1,m_sp,Omega_sp);
    h_rp = Nakagamim(1,1,m_rp,Omega_rp);
    h_sr = Nakagamim(1,1,m_sr,Omega_sr);
    h_rd = Nakagamim(1,1,m_rd,Omega_rd);
    
    for j = 1:length(P),
        if min(I/abs(h_sp)^2,P(j))*abs(h_sr)^2<threshold,
          test1(j) = test1(j) +1;
         end
         if min(I/abs(h_rp)^2,P(j))*abs(h_rd)^2<threshold,
             test2(j) = test2(j)+1;
         end
        
        if min(min(I/abs(h_sp)^2,P(j))*abs(h_sr)^2,min(I/abs(h_rp)^2,P(j))*abs(h_rd)^2)<threshold,
            Pout(j) = Pout(j)+1;
        end
    end
end
 toc
% test1=test1/Iteration
% test2=test2/Iteration
% 
Pout = Pout/Iteration


beta1 = m_sp/Omega_sp;
beta2 = m_sr/Omega_sr;
beta3 = m_rp/Omega_rp;
beta4 = m_rd/Omega_rd;

for jj =1:length(P),
    A = 0;
    for ii=0:m_sr-1,
        A = A +(threshold*beta2/I)^ii/factorial(ii)*(threshold*beta2/I+beta1)^(-m_sp-ii)*(gamma(m_sp+ii)-gamma(m_sp+ii)*gammainc((threshold*beta2+beta1*I)/P(jj),m_sp+ii));
    end
    F1(jj) = gammainc(threshold*beta2/P(jj),m_sr)*gammainc(beta1*I/P(jj),m_sp)+(1-gammainc(beta1*I/P(jj),m_sp))-beta1^(m_sp)/gamma(m_sp)*A;
end

for jj =1:length(P),
    B = 0;
    for ii=0:m_rd-1,
        B = B +(threshold*beta4/I)^ii/factorial(ii)*(threshold*beta4/I+beta3)^(-m_rp-ii)*(gamma(m_rp+ii)-gamma(m_rp+ii)*gammainc((threshold*beta4+beta3*I)/P(jj),m_rp+ii));
    end
    F2(jj) = gammainc(threshold*beta4/P(jj),m_rd)*gammainc(beta3*I/P(jj),m_rp)+(1-gammainc(beta3*I/P(jj),m_rp))-beta3^(m_rp)/gamma(m_rp)*B;
end

% F1,F2
% 
Pout2 = F1+F2-F1.*F2

for jj =1:length(P),
    C = 0;
    for ii=0:m_sr-1,
        C = C +(threshold*beta2/I)^ii/factorial(ii)*(threshold*beta2/I+beta1)^(-m_sp-ii)*gamma(m_sp+ii);
    end
    G1(jj) = 1-beta1^(m_sp)/gamma(m_sp)*C;
end

for jj =1:length(P),
    D = 0;
    for ii=0:m_rd-1,
        D = D +(threshold*beta4/I)^ii/factorial(ii)*(threshold*beta4/I+beta3)^(-m_rp-ii)*gamma(m_rp+ii);
    end
    G2(jj) = 1-beta3^(m_rp)/gamma(m_rp)*D;
end

Pout3 = G1+G2-G1.*G2

semilogy(P1,Pout,'-');
hold on;

semilogy(P1,Pout3,'*');
hold on;


