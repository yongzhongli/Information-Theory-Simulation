function process = FanoDivision(Group, process, divNum, deviation)
%Division 把降序排序的序列按尽可能等概率分为两组
%   process = FanoDivision(Group, process, divNum)
%   Group       :  输入消息概率序列
%   process     :  分组过程（待更新）
%   divNum      :  分组次数，默认值为1
%   deviation   :  起始值（偏移值），默认值为1

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    if(~exist('divNum', 'var'))
        divNum = 1;
    end
    if(~exist('deviation', 'var'))
        deviation = 1;
    end
    
    % 初始值
    len = length(Group);
    up = Group(1);
    upNum = 1;
    down = Group(end);
    downNum = len;
    process{upNum + deviation - 1, divNum + 1} = strcat(process{upNum + deviation - 1, divNum}, '0');
    process{downNum + deviation - 1, divNum + 1} = strcat(process{downNum + deviation - 1, divNum}, '1');
    divUpGroup(upNum) = Group(upNum);
    divDownGroup(len - downNum + 1) = Group(downNum);
    % 比较两部分大小，向小的部分合并新的项
    while( (downNum - upNum) > 1)
        if(up < down)
            upNum = upNum + 1;
            up = up + Group(upNum);
            process{upNum + deviation - 1, divNum + 1} = strcat(process{upNum + deviation - 1, divNum}, '0');
            divUpGroup(upNum) = Group(upNum);
        else
            downNum = downNum - 1;
            down = down + Group(downNum);
            process{downNum + deviation - 1, divNum + 1} = strcat(process{downNum + deviation - 1, divNum}, '1');
            divDownGroup(len - downNum + 1) = Group(downNum);
        end
    end
    % 降序排序
    divUpGroup = sort(divUpGroup, 'descend');
    divDownGroup = sort(divDownGroup, 'descend');
    
    % 递归调用
    if(length(divUpGroup) > 1)
        process = FanoDivision(divUpGroup, process, divNum + 1, deviation);
    end
    if(length(divDownGroup) > 1)
        process = FanoDivision(divDownGroup, process, divNum + 1, downNum + deviation - 1);
    end
end