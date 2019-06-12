function [Code, averLen, Eta, process] = FanoEncode(Prob)
%FanoEncode 费诺编码
%   [Code, averLen, Eta] = FanoEncode(Prob)
%   Prob        :  输入消息概率
%   Code        :  码字
%   averLen     :  平均符号长度
%   Eta         :  编码效率
%   process     :  编码过程

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    len = length(Prob);
    % 递减次序排序
    sortProb = sort(Prob, 'descend');

    % 费诺编码
    group = FanoDivision(sortProb, cell(len, 1));
    for i = 2 : size(group, 2)
        for j = 1 : len
            if(isempty(group{j, i}))
                group{j, i} = group{j, i - 1};
            end
        end
    end
    Code = group(:, size(group, 2));
    process = group(:, 2 : end);
    % 计算平均码长及编码效率
    codeLen = zeros(1, len);
    for i = 1 : len
        codeLen(i) = length(Code{i, 1});
    end
    averLen = sum(codeLen .* sortProb);
    IProb = -log2(sortProb);
    H = sum(IProb .* sortProb);
    Eta = H / averLen;
    
%     fprintf('费诺编码：');
%     fprintf('平均码长为：%.2f 码元/符号，信源熵为：%.2f bit/符号，编码效率为：%.1f%%\n', averLen, H, Eta * 100);
end