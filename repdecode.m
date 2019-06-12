function [b]=repdecode(a,r)
b=zeros(1,length(a)/r);
for i=1:length(b)
    p0=length(find(a(i*r-r+1:i*r)==0));
    p1=r-p0;
    if p0>p1
        b(i)=0;
    else
        b(i)=1;
    end
end
end