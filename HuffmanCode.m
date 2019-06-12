function [Code, codeLen, trace] = HuffmanCode(process, r, fullLen, theta, originalLen)
%HuffmanCode 通过编码过程得到最终码字
%   [Code, codeLen, trace] = HuffmanCode(process, r, fullLen, theta, originalLen)
%   process     :  编码过程
%   r           :  r元霍夫曼编码
%   fullLen     :  补齐符号个数
%   theta       :  信源缩减次数
%   originalLen	:  初始符号个数
%   Code        :  码字
%   codeLen     :  码长
%   trace       :  编码过程

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
	trace = cell(fullLen, (theta+1));
    for j = (theta + 1) : -1 : 1
        % 本级编码（末尾位置0，1，2编码）
        tempS = process{j, 1};
        tempLen = length(tempS);
        for k = (tempLen - r + 1) : tempLen
            trace{k, j} = strcat(num2str(trace{k, j}), num2str(k - tempLen + r - 1));
        end

        % 向前一级传递
        tempNum = process{j, 2};
        if(~isnan(tempNum))
            for l = 1 : tempNum
                trace{l, j - 1} = trace{l, j};
            end
            for l = tempNum : (tempLen - 1)
                trace{l, j - 1} = trace{(l + 1), j};
            end
            for l = tempLen : (tempLen + r - 1)
                trace{l, j - 1} = trace{tempNum, j};
            end
        end
    end

    % 计算代码组长度
    Code = trace(1 : originalLen, 1);
    codeLen = zeros(1, originalLen);
    for i = 1 : originalLen
        codeLen(i) = length(Code{i});
    end
end