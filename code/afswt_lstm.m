clear;clc;
load data_pafn.mat;
data_pafn_afswt=cell(4500,1);
Fs=128;

for i=1:4500
    s=data_pafn(:,i);
    s = butterworth_filter(s,2,0.25,40,Fs, 0);%巴特沃斯带通滤波器去噪
    s=myMedfilt(s, 32,0);%中值滤波去除基线漂移

    B=AFSWT(s)';
    %imagesc(B);
    small=big2small2(B,35,128);%50*10缩小
    data_pafn_afswt(i,1)={small/255};%归一化
    %
    %imagesc(data_n_afswt(i,1:35,1:128)');
    %print(gcf,sprintf('p50(%d)',i),'-dpng');
    %saveas(figure(i),'p50(i)');
end;
%data_n_afswt=num2cell(data_n_afswt,[2 3]);
save('data_pafn_afswt.mat','data_pafn_afswt');
