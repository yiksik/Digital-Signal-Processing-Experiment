%���ܣ���ͨ�˲���
%param��
%f1 ͨ����ֹƵ��
%f2 �����ֹƵ��
%fs ����Ƶ��
function y=lpf(f1,f2,fs)
wp=2*pi*f1/fs; 
ws=2*pi*f2/fs;
DB=ws-wp; 
N=ceil(8*pi/DB); 
wc=(wp+ws)/2/pi; %�����ͨ�˲�����ֹƵ��(���ڦй�һ����
y=fir1(N-1,wc); %���� fir1 �����ͨ�˲������̣�Ĭ�ϸĽ��������Ҵ�
end