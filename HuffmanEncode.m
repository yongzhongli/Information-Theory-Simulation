function [Code, averLen, Eta, process] = HuffmanEncode(Prob, r)
%HuffmanEncode （最小码方差）霍夫曼编码
%   [Code, averLen, Eta, trace] = HuffmanEncode(Prob, r)
%   Prob        :  输入消息概率
%   r           :  r元霍夫曼编码
%   Code        :  码字
%   averLen     :  平均符号长度
%   Eta         :  编码效率
%   process     :  编码过程

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    % 补齐符号个数，使之满足q = (r - 1) * θ + r
    len = length(Prob);
    theta = ceil((len - r) / (r - 1));
    q = theta * (r - 1) + r;
    newProb = Prob;
    for i = (len + 1) : q
        newProb(i) = 0;
    end
    % 递减次序排序
    sortProb = sort(newProb, 'descend');

    % 编码预过程：s(i, 1)为缩减过程，s(i, 2)为被缩减的位置
    s = cell(theta + 1, 2);
    s{1, 1} = newProb;
    s{1, 2} = NaN;
    for i = 1 : theta
        tempMat = sort(cell2mat(s(i)), 'descend');
        tempLen = length(tempMat);
        temp = sum(tempMat(tempLen - r + 1 : tempLen));
        % 找到缩减码该放的位置
        for j = 1 : (tempLen - r + 1)
            if(temp >= tempMat(j))
                s{i + 1, 2} = j;
                break
            end
        end
        newMat = [temp, tempMat(1 : (tempLen - r))];
        s{i + 1, 1} = sort(newMat, 'descend');
    end

    % 霍夫曼编码
    [Code, codeLen, process] = HuffmanCode(s, r, q, theta, len);

    % 计算平均码长及编码效率
    averLen = sum(codeLen .* sortProb(1 : len));
    IProb = -log2(Prob);
    H = sum(IProb .* Prob);
    Eta = H / (averLen * log2(r));
    
%     fprintf('霍夫曼编码：');
%     fprintf('平均码长为：%.2f 码元/符号，信源熵为：%.2f bit/符号，编码效率为：%.1f%%\n', averLen, H, Eta * 100);
end