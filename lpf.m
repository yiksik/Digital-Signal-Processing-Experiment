%功能：低通滤波器
%param：
%f1 通带截止频率
%f2 阻带截止频率
%fs 采样频率
function y=lpf(f1,f2,fs)
wp=2*pi*f1/fs; 
ws=2*pi*f2/fs;
DB=ws-wp; 
N=ceil(8*pi/DB); 
wc=(wp+ws)/2/pi; %计算低通滤波器截止频率(关于π归一化）
y=fir1(N-1,wc); %调用 fir1 计算低通滤波器方程，默认改进型升余弦窗
end