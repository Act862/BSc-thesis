%This function is for computing the theoretical value of a Nakagami-m PDF with Omega=1
% 
function [gam] = Nakagami_theory_omega1(m, x)

	x1=lagam(m);
	x2=2.0*power(m,m)*power(x,2.0*m-1.0);
	gam=x2*exp(-m*x*x)/x1;
 
end