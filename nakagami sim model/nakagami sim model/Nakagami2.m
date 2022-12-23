% function for nakagami fadding for NLOS links, i.e., im<3
% This function and the next two (lagam and nakagami_theory_omega1) generates normalized random Nakagami-m
% (x=r/sqrt{Omega})  distributed numbers having the m value in the range [0.5, 3].
% The random number  is generated using the rejection method.
function [x] = Nakagami2(m)

 if(m<=3.0)
     while 1
       v1=5.0*rand;
       x1=Nakagami_theory_omega1(m,v1);
       height=0.8;
       if (m>0.75)
	 height=0.9;
       end
       if(m>1.0)
	 height=1.05;
       end
       if(m>1.5)
	 height=1.2;
       end
       if(m>2.0)
	 height=1.45;
       end
       v2=height*rand;
     if ~(v2>x1)
         break;
     end
     end
       end
 a=v1*v1;
 x=sqrt(a);
end