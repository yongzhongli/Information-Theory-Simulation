function [image]=bit2image(s,a,b)
image=zeros(a,b);
s1=zeros(length(s)/8,8);
for i=1:length(s)/8
    s1(i,:)=s(i*8-7:i*8);
end
s2=num2str(s1);
s3=bin2dec(s2);
s4=reshape(s3,a,b);
image=uint8(s4);
end