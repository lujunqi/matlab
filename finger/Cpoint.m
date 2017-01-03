function a=Cpoint(g);

a(1,1)=0;

for x=2:479
for y=2:399
c=0;
if(g(x,y)==1)
if(g(x-1,y-1)==g(x-1,y))
else
c=c+1;
end
if(g(x-1,y)==g(x-1,y+1))
else
c=c+1;
end
if(g(x-1,y+1)==g(x,y+1))
else
c=c+1;
end
if(g(x,y+1)==g(x+1,y+1))
else
c=c+1;
end
if(g(x+1,y+1)==g(x+1,y))
else
c=c+1;
end
if(g(x+1,y)==g(x+1,y-1))
else
c=c+1;
end
if(g(x+1,y-1)==g(x,y-1))
else
c=c+1;
end
if(g(x,y-1)==g(x-1,y-1))
else
c=c+1;
end
a(x,y)=c;
end
end
end

a(480,400)=0;