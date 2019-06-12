close all; clear; clc;

Prob = [0.2, 0.19, 0.18, 0.17, 0.15, 0.10, 0.01];
% Prob = [0.4, 0.2, 0.1, 0.1, 0.05, 0.05, 0.05, 0.05];
% Prob = [0.22, 0.2, 0.18, 0.15, 0.1, 0.08, 0.05, 0.02];
% Prob = [0.25, 0.25, 0.2, 0.15, 0.10, 0.05];
% Prob = [0.32, 0.22, 0.18, 0.16, 0.08, 0.04];
r = 2;

if( (abs(sum(Prob) - 1) <= 1e-12) && (isempty(find(Prob < 0, 1))) )
% 概率检查
    [SNCode, SNLen, SNEta] = ShannonEncode(Prob);
    [HFMCode, HFMLen, HFMEta] = HuffmanEncode(Prob, r);
    [FNCode, FNLen, FNEta] = FanoEncode(Prob);
%     fprintf('CODE(%d) = "%s"\n', n, strCode);
else
    fprintf('概率输入有误！\n');
end