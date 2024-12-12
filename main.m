clc;
%% �����ź�
fs=1000;%����Ƶ��
t=(0:1/fs:0.5);%ʱ��������t=0..1s
f1=10;f2=10;%�����ź�Ƶ��
f3=100;f4=300;%�����ز�Ƶ��
signal2=square(2*pi*f1*t);%���������ź�
signal1=sin(2*pi*f2*t);%���������ź�

figure(1)
%�����ź�ʱ����
subplot(2,2,1);
plot(t,signal1);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('�����ź�');
ylim([-2,2])

subplot(2,2,3);
plot(t,signal2);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('�����ź�');
ylim([-2,2])

%Ƶ�����
N=2048;
Y1=fft(signal1,N);
Y1=fftshift(Y1);%���ĽضϷ�Χ
Y2=fft(signal2,N);
Y2=fftshift(Y2); 
f=(0:N-1)*fs/N-fs/2;

%Ƶ����ʾ  ������Ϊ��ֵ����ȡ����ֵ
subplot(2,2,2);
plot(f,abs(Y1));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('�����ź�Ƶ��ͼ');

subplot(2,2,4);
plot(f,abs(Y2));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('�����ź�Ƶ��ͼ');

%% ��ʾ�����ź� cos(2*pi*f3*t) �� cos(2*pi*f4*t) ��ʱ���Ƶ����
figure(2)

% ʱ����ʾ cos(2*pi*f3*t) �� cos(2*pi*f4*t)
subplot(2,2,1);
plot(t, cos(2*pi*f3*t));
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('�����ź� cos(2\pi f3t) ʱ����');

subplot(2,2,3);
plot(t, cos(2*pi*f4*t));
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('�����ź� cos(2\pi f4t) ʱ����');

% Ƶ����� cos(2*pi*f3*t) �� cos(2*pi*f4*t)
YModulating1 = fft(cos(2*pi*f3*t), N);
YModulating1 = fftshift(YModulating1);
subplot(2,2,2);
plot(f, abs(YModulating1));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('�����ź� cos(2\pi f3t) Ƶ��ͼ');

YModulating2 = fft(cos(2*pi*f4*t), N);
YModulating2 = fftshift(YModulating2);
subplot(2,2,4);
plot(f, abs(YModulating2));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('�����ź� cos(2\pi f4t) Ƶ��ͼ');


%% ����(modulation)�ź�
modusignal1=signal1.*cos(2*pi*f3*t);%ֱ�����
modusignal2=signal2.*cos(2*pi*f4*t);

figure(3)
%�����ź�ʱ����
subplot(2,2,1);
plot(t,modusignal1);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('���ҵ����ź�');

subplot(2,2,3);
plot(t,modusignal2);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('���������ź�');

%Ƶ��
YModu1=fft(modusignal1,N);
YModu1=fftshift(YModu1);%���ĽضϷ�Χ
YModu2=fft(modusignal2,N);
YModu2=fftshift(YModu2); 
f=(0:N-1)*fs/N-fs/2;
%Ƶ����ʾ
subplot(2,2,2);
plot(f,abs(YModu1));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('���ҵ���Ƶ��ͼ');
subplot(2,2,4);
plot(f,abs(YModu2));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('��������Ƶ��ͼ');


%% �ź����
signal=modusignal1+modusignal2;

figure(4)
%ʱ����ʾ
subplot(2,1,1);
plot(t,signal);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('������Ӻ��ź�');
Y=fft(signal,N);Y=fftshift(Y);
f=(0:N-1)*fs/N-fs/2;
%Ƶ����ʾ
subplot(2,1,2);
plot(f,abs(Y));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('������Ӻ��ź�Ƶ��ͼ');


%% ��ͨ�˲�
% x1=bpf(f3-f1^2*5,f3+f1^2*5,f3-f1^2*5-40,f3+f1^2*5+40,fs);
x1=bpf(50,150,40,160,fs);
y1=filter(x1,1,signal);
% x2=bpf(f4-f2^2,f4+f2^2,f4-f2^2-40,f4+f2^2+40,fs);
x2=bpf(200,400,180,420,fs);
Y2=filter(x2,1,signal);

figure(5)
%ʱ����ʾ
subplot(2,2,1);
plot(t,y1);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('signal1��ͨ�ź�');

subplot(2,2,3);
plot(t,Y2);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('signal2��ͨ�ź�');
%%%Ƶ�����
ybp1=fft(y1,N);ybp1=fftshift(ybp1);%���ٸ���Ҷ�任�ó�Ƶ�׺���
ybp2=fft(Y2,N);ybp2=fftshift(ybp2); 
f=(0:N-1)*fs/N-fs/2;
%Ƶ����ʾ
subplot(2,2,2);
plot(f,abs(ybp1));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('signal1��ͨƵ��ͼ');
subplot(2,2,4);
plot(f,abs(ybp2));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('signal2��ͨƵ��ͼ');


%% ��ɽ��
ydem1=y1.*(cos(2*pi*f3*t)*2);%����ֵ�� 2
ydem2=Y2.*(cos(2*pi*f4*t)*2);

figure(6)
%ʱ����ʾ
subplot(2,2,1);
plot(t,ydem1);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('signal1����ź�');
subplot(2,2,3);
plot(t,ydem2);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('signal2����ź�');
%%%Ƶ�����
Ym1=fft(ydem1,N);Ym1=fftshift(Ym1);%���ĽضϷ�Χ
Ym3=fft(ydem2,N);Ym3=fftshift(Ym3); 
f=(0:N-1)*fs/N-fs/2;

%Ƶ����ʾ
subplot(2,2,2);
plot(f,abs(Ym1));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('signal1���Ƶ��ͼ');

subplot(2,2,4);
plot(f,abs(Ym3));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('signal2���Ƶ��ͼ');



%% ��ͨ�˲�
% z1=lpf(12*f1,14*f1,fs);
z1=lpf(10,20,fs);
SY1=filter(z1,1,ydem1);
z2=lpf(100,110,fs);
sY2=filter(z2,1,ydem2);
figure(7)
%ʱ����ʾ
subplot(2,2,1);
plot(t,SY1);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('signal1��ͨ�˲��ź�');

subplot(2,2,3);
plot(t,sY2);
xlabel('ʱ�䣨s��');
ylabel('��ֵ');
title('signal2��ͨ�˲��ź�');
%%%Ƶ�����
SY1=fft(SY1,N);SY1=fftshift(SY1);%���ĽضϷ�Χ
SY2=fft(sY2,N);SY2=fftshift(SY2); 
%Ƶ����ʾ
f=(0:N-1)*fs/N-fs/2;
subplot(2,2,2);
plot(f,abs(SY1));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('signal1��ͨƵ��ͼ');
subplot(2,2,4);
plot(f,abs(SY2));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('signal2��ͨƵ��ͼ');


 