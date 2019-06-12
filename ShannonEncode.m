function [Code, averLen, Eta] = ShannonEncode(Prob)
%ShannonEncode 香农编码
%   [Code, averLen, Eta] = ShannonEncode(Prob)
%   Prob        :  输入消息概率
%   Code        :  码字
%   averLen     :  平均符号长度
%   Eta         :  编码效率

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    len = length(Prob);
    % 递减次序排序
    sortProb = sort(Prob, 'descend');

    % 计算累加概率
    cumulateProb = zeros(1, len);
    for i = 1 : (len - 1)
        cumulateProb(i + 1) = cumulateProb(i) + sortProb(i);
    end

    % 计算代码组长度
    IProb = -log2(sortProb);
    codeLen = ceil(IProb);

    % 香农编码
    Code = ShannonCode(cumulateProb, codeLen);

    % 计算平均码长及编码效率
    averLen = sum(codeLen .* sortProb);
    H = sum(IProb .* sortProb);
    Eta = H / averLen;
    
%     fprintf('香农编码：');
%     fprintf('平均码长为：%.2f 码元/符号，信源熵为：%.2f bit/符号，编码效率为：%.1f%%\n', averLen, H, Eta * 100);
end