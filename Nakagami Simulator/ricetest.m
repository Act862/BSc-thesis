function q = ricetest(inph,quad,data,bins)

y = sort(data); %data to be tested
b = sqrt((std(inph)^2 + std(quad)^2)/2); %Rician parameter
a = mean(inph); %Rician parameter

inter = max(y) - min(y); %interval for chi-square test 
intstep = inter/bins; %size of sub-interval
intval = [min(y):intstep:max(y)]; %samples at the sub-intervals
k = [zeros(1,bins)]; %number of samples in each sub-interval

%counting the samples in each sub-interval
for i = 1:length(y)
   for j = 1:bins
      if y(i) <= intval(j+1)
         k(j) = k(j) + 1;
         break;
      end;
   end;
end;

Fy = zeros(1,length(intval));
for i = 1:length(intval)
   	x = 0:intval(i)/(i*400):intval(i); %integration range
   	I = besseli(0,x.*(a/b^2)); %Bessel function of zero order and first kind
	fy = (x./b^2).*exp(-(a^2+x.^2)./(2*b^2)).*I; %pdf at each sub-interval sample 
	Fy(i) = trapz(x,fy); %cdf at each sub-interval sample
end;

p = zeros(1,bins);
for i = 1:bins
   p(i) = Fy(i+1) - Fy(i); %probabilities at the sub-interval samples
end;

np = p.*length(y);

q = 0; 
for i = 1:bins
   q = q + ((k(i)-np(i))^2)/np(i); %chi-square test
end;




