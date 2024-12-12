%使用汉明窗作为窗函数的带通滤波器
% param：
%f1 通带下截止频率
%f2 通带上截止频率
%f3 阻带下截止频率
%f4 阻带上截止频率

function y=bpf(f1,f2,f3,f4,fs)
wpl=2*pi*f1/fs;
wpu=2*pi*f2/fs;
wsl=2*pi*f3/fs;
wsu=2*pi*f4/fs;
BW=wpl-wsl; 
N=ceil(4*pi/BW); % h(n)长度 N  ceil表示上取整
wc=[(wpl+wsl)/2/pi, (wpu+wsu)/2/pi]; %带通滤波器截止频率(关于π归一化）
y=fir1(N-1,wc); %调用 fir1 计算带通滤波器方程，默认改进型升余弦窗
end