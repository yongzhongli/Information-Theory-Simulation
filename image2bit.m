function [s,a,b]=image2bit(image)
[a,b]=size(image);
image1=reshape(image,a*b,1);
image1=dec2bin(image1);
s=zeros(a*b*8,1);
for i=1:a*b
    for j=1:8
        if image1(i,j)=='1'
            s(i*8-8+j)=1;
        end
    end
end
end