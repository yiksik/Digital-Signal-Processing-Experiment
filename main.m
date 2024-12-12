clc;
%% 生成信号
fs=1000;%采样频率
t=(0:1/fs:0.5);%时间向量，t=0..1s
f1=10;f2=10;%基带信号频率
f3=100;f4=300;%调制载波频率
signal2=square(2*pi*f1*t);%产生矩形信号
signal1=sin(2*pi*f2*t);%产生正弦信号

figure(1)
%基带信号时域波形
subplot(2,2,1);
plot(t,signal1);
xlabel('时间（s）');
ylabel('幅值');
title('正弦信号');
ylim([-2,2])

subplot(2,2,3);
plot(t,signal2);
xlabel('时间（s）');
ylabel('幅值');
title('方波信号');
ylim([-2,2])

%频域分析
N=2048;
Y1=fft(signal1,N);
Y1=fftshift(Y1);%更改截断范围
Y2=fft(signal2,N);
Y2=fftshift(Y2); 
f=(0:N-1)*fs/N-fs/2;

%频域显示  纵坐标为幅值所以取绝对值
subplot(2,2,2);
plot(f,abs(Y1));
xlabel('频率(Hz)');
ylabel('幅值');
title('正弦信号频谱图');

subplot(2,2,4);
plot(f,abs(Y2));
xlabel('频率(Hz)');
ylabel('幅值');
title('方波信号频谱图');

%% 显示调制信号 cos(2*pi*f3*t) 和 cos(2*pi*f4*t) 的时域和频域波形
figure(2)

% 时域显示 cos(2*pi*f3*t) 和 cos(2*pi*f4*t)
subplot(2,2,1);
plot(t, cos(2*pi*f3*t));
xlabel('时间（s）');
ylabel('幅值');
title('调制信号 cos(2\pi f3t) 时域波形');

subplot(2,2,3);
plot(t, cos(2*pi*f4*t));
xlabel('时间（s）');
ylabel('幅值');
title('调制信号 cos(2\pi f4t) 时域波形');

% 频域分析 cos(2*pi*f3*t) 和 cos(2*pi*f4*t)
YModulating1 = fft(cos(2*pi*f3*t), N);
YModulating1 = fftshift(YModulating1);
subplot(2,2,2);
plot(f, abs(YModulating1));
xlabel('频率(Hz)');
ylabel('幅值');
title('调制信号 cos(2\pi f3t) 频谱图');

YModulating2 = fft(cos(2*pi*f4*t), N);
YModulating2 = fftshift(YModulating2);
subplot(2,2,4);
plot(f, abs(YModulating2));
xlabel('频率(Hz)');
ylabel('幅值');
title('调制信号 cos(2\pi f4t) 频谱图');


%% 调制(modulation)信号
modusignal1=signal1.*cos(2*pi*f3*t);%直接相乘
modusignal2=signal2.*cos(2*pi*f4*t);

figure(3)
%调制信号时域波形
subplot(2,2,1);
plot(t,modusignal1);
xlabel('时间（s）');
ylabel('幅值');
title('正弦调制信号');

subplot(2,2,3);
plot(t,modusignal2);
xlabel('时间（s）');
ylabel('幅值');
title('方波调制信号');

%频域
YModu1=fft(modusignal1,N);
YModu1=fftshift(YModu1);%更改截断范围
YModu2=fft(modusignal2,N);
YModu2=fftshift(YModu2); 
f=(0:N-1)*fs/N-fs/2;
%频域显示
subplot(2,2,2);
plot(f,abs(YModu1));
xlabel('频率(Hz)');
ylabel('幅值');
title('正弦调制频谱图');
subplot(2,2,4);
plot(f,abs(YModu2));
xlabel('频率(Hz)');
ylabel('幅值');
title('方波调制频谱图');


%% 信号相加
signal=modusignal1+modusignal2;

figure(4)
%时域显示
subplot(2,1,1);
plot(t,signal);
xlabel('时间（s）');
ylabel('幅值');
title('调制相加后信号');
Y=fft(signal,N);Y=fftshift(Y);
f=(0:N-1)*fs/N-fs/2;
%频域显示
subplot(2,1,2);
plot(f,abs(Y));
xlabel('频率(Hz)');
ylabel('幅值');
title('调制相加后信号频谱图');


%% 带通滤波
% x1=bpf(f3-f1^2*5,f3+f1^2*5,f3-f1^2*5-40,f3+f1^2*5+40,fs);
x1=bpf(50,150,40,160,fs);
y1=filter(x1,1,signal);
% x2=bpf(f4-f2^2,f4+f2^2,f4-f2^2-40,f4+f2^2+40,fs);
x2=bpf(200,400,180,420,fs);
Y2=filter(x2,1,signal);

figure(5)
%时域显示
subplot(2,2,1);
plot(t,y1);
xlabel('时间（s）');
ylabel('幅值');
title('signal1带通信号');

subplot(2,2,3);
plot(t,Y2);
xlabel('时间（s）');
ylabel('幅值');
title('signal2带通信号');
%%%频域分析
ybp1=fft(y1,N);ybp1=fftshift(ybp1);%快速傅里叶变换得出频谱函数
ybp2=fft(Y2,N);ybp2=fftshift(ybp2); 
f=(0:N-1)*fs/N-fs/2;
%频域显示
subplot(2,2,2);
plot(f,abs(ybp1));
xlabel('频率(Hz)');
ylabel('幅值');
title('signal1带通频谱图');
subplot(2,2,4);
plot(f,abs(ybp2));
xlabel('频率(Hz)');
ylabel('幅值');
title('signal2带通频谱图');


%% 相干解调
ydem1=y1.*(cos(2*pi*f3*t)*2);%将幅值乘 2
ydem2=Y2.*(cos(2*pi*f4*t)*2);

figure(6)
%时域显示
subplot(2,2,1);
plot(t,ydem1);
xlabel('时间（s）');
ylabel('幅值');
title('signal1解调信号');
subplot(2,2,3);
plot(t,ydem2);
xlabel('时间（s）');
ylabel('幅值');
title('signal2解调信号');
%%%频域分析
Ym1=fft(ydem1,N);Ym1=fftshift(Ym1);%更改截断范围
Ym3=fft(ydem2,N);Ym3=fftshift(Ym3); 
f=(0:N-1)*fs/N-fs/2;

%频域显示
subplot(2,2,2);
plot(f,abs(Ym1));
xlabel('频率(Hz)');
ylabel('幅值');
title('signal1解调频谱图');

subplot(2,2,4);
plot(f,abs(Ym3));
xlabel('频率(Hz)');
ylabel('幅值');
title('signal2解调频谱图');



%% 低通滤波
% z1=lpf(12*f1,14*f1,fs);
z1=lpf(10,20,fs);
SY1=filter(z1,1,ydem1);
z2=lpf(100,110,fs);
sY2=filter(z2,1,ydem2);
figure(7)
%时域显示
subplot(2,2,1);
plot(t,SY1);
xlabel('时间（s）');
ylabel('幅值');
title('signal1低通滤波信号');

subplot(2,2,3);
plot(t,sY2);
xlabel('时间（s）');
ylabel('幅值');
title('signal2低通滤波信号');
%%%频域分析
SY1=fft(SY1,N);SY1=fftshift(SY1);%更改截断范围
SY2=fft(sY2,N);SY2=fftshift(SY2); 
%频域显示
f=(0:N-1)*fs/N-fs/2;
subplot(2,2,2);
plot(f,abs(SY1));
xlabel('频率(Hz)');
ylabel('幅值');
title('signal1低通频谱图');
subplot(2,2,4);
plot(f,abs(SY2));
xlabel('频率(Hz)');
ylabel('幅值');
title('signal2低通频谱图');


 