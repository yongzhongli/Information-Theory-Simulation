function [s1]=biterror(s0,pb)
s1=s0;
for i=1:length(s0)
    if(rand<pb)
        s1(i)=rem(s0(i)+1,2);
    end
end
end