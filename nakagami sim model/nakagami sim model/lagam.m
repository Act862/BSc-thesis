
function [s] = lagam(m)

   a =[0.0000677106,-0.0003442342,  0.0015397681,-0.0024467480,0.0109736958,  -0.0002109075,0.0742379071,0.0815782188,  0.4118402518,0.4227843370,1.0];

    y=m;
    if (y<=1.0)
      t=1.0/(y*(y+1.0));
      y=y+2.0;
    elseif (y<=2.0)
      t=1.0/y;
      y=y+1.0;
    elseif (y<=3.0)
      t=1.0;
    else
      t=1.0;
        while (y>3.0)
	     y=y-1.0;
	       t=t*y;
        end
        end
    s=a(1);
    u=y-2.0;
    for i=2:11
      s=s*u+a(i);
    end
    s=s*t;
    end