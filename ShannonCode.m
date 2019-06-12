function Code = ShannonCode(Prob, Len)
%ShannonCode 将累加概率变为二进制数并取小数点后代码长度位为代码
%   Code = ShannonCode(Prob, Len)
%   Prob    :  累加概率
%   Len     :  代码组长度
%   Code    :  码字

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    N = length(Prob);
    Code = cell(N, 1);
    for n = 1 : N
        num = Prob(n);
        code = zeros(1, Len(n));
        for i = 1 : Len(n)
            num = num * 2;
            if (num >= 1)
                code(i) = 1;
                num = num - 1;
            end
        end

        strCode = '';
        for i = 1 : Len(n)
            strCode = strcat(strCode, num2str(code(i)));
        end
        Code{n, 1} = strCode;
    end
end