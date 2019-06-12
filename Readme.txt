
task1.m 是用于输入信源概率和转移概率，然后计算出 联合概率，信宿概率  信源熵  信宿熵 自信息  疑义度 噪声熵 互信息


x是信源矩阵  y_x同于P是x——>y的转移矩阵

Self_information(x) 				%自信息量计算
Information_entropy(x)			%平均自信息量/信息熵 计算
Forword_probability(x,y_x)			%后向概率计算
Doubtful_degree(x,y_x)			%X-Y 条件熵/信道疑义度 计算
Y_X_conditiona_entropy(x,y_x)			%Y-X 条件熵 计算
Joint_entropy(x,y_x)				%Y-X 联合熵 计算
Average_Mutual_Information(x,y_x)		%平均互信息量 / (原始信源熵 - 信道疑义度) 计算


在main里修改x 和P ，随后调用函数进行计算



因为 0*log0有bug，因此定义了Log函数对结果进行优化
但是在计算自信息量时不能使用，因为他没有求期望