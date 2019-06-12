function [b]=repcode(a,r)
b=zeros(1,r*length(a));
for i=1:length(a)
    b(i*r-r+1:i*r)=a(i);
end
end
