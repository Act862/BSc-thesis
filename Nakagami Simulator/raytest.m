function q = raytest(data,bins)
%Gayatri Prabhu and P. M. Shankar
y = sort(data./mean(data)); %unity mean
b = sqrt(2/pi); %Rayleigh parameter for unit mean

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

Fy = raylcdf(intval,b); %cdf at each sub-interval sample 

p = zeros(1,bins);
for i = 1:bins
   p(i) = Fy(i+1) - Fy(i); %probabilities at the sub-interval samples
end;

np = p.*length(y);

q = 0; 
for i = 1:bins
   q = q + ((k(i)-np(i))^2)/np(i); %chi-square test statistic
end;



