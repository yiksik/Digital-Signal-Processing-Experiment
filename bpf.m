%ʹ�ú�������Ϊ�������Ĵ�ͨ�˲���
% param��
%f1 ͨ���½�ֹƵ��
%f2 ͨ���Ͻ�ֹƵ��
%f3 ����½�ֹƵ��
%f4 ����Ͻ�ֹƵ��

function y=bpf(f1,f2,f3,f4,fs)
wpl=2*pi*f1/fs;
wpu=2*pi*f2/fs;
wsl=2*pi*f3/fs;
wsu=2*pi*f4/fs;
BW=wpl-wsl; 
N=ceil(4*pi/BW); % h(n)���� N  ceil��ʾ��ȡ��
wc=[(wpl+wsl)/2/pi, (wpu+wsu)/2/pi]; %��ͨ�˲�����ֹƵ��(���ڦй�һ����
y=fir1(N-1,wc); %���� fir1 �����ͨ�˲������̣�Ĭ�ϸĽ��������Ҵ�
end