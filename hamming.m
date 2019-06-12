function [G,H]=hamming(m)
n=2^m-1;
k=n-m;
P1=1:n;
for i=0:m-1
    P1(2^i-i)=[];
end
P1=P1(randperm(length(P1)));
for i=1:k
    P(i,:)=bitget(P1(i),m:-1:1);
end
H=[P' eye(m)];
G=[eye(k) P];
end

