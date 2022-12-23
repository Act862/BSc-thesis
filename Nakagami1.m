% function for nakagami fadding for LOS links, i.e., im=>3
function [x] = Nakagami1(ia, omega)

if (ia < 6)
  x=1.0;
  for j=1:ia
   x = x*rand;
  end
   x = -log(x);
end
if (ia > 5)
   while 1
     while 1
       while 1
           v1=rand;
	   v2=2.0*rand-1.0;
       if ~(v1*v1+v2*v2 > 1.0)
           break;
       end
       end
	    y=v2/v1;
	    am=ia-1;
	    s=sqrt(2.0*am+1.0);
	    x=s*y+am;
     if ~(x <= 0.0)
                   break;
       end
       end
	e=(1.0+y*y)*exp(am*log(x/am)-s*y);
   if ~(rand > e)
                     break;
       end
   end
end
x=x*omega/ia;
x=sqrt(x);
end

