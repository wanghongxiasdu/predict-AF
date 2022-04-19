load data_n.mat;
data_n_original=cell(9000,1);
Fs=128;
for i=1:9000
    s=data_n(:,i);
    
     s = butterworth_filter(s,2,0.25,40,Fs, 0);%巴特沃斯带通滤波器去噪
    s=myMedfilt(s, 32,0);%中值滤波去除基线漂移
    data_n_original(i,1)={s};
end;
%data_n_afswt=num2cell(data_n_afswt,[2 3]);
save('data_n_original.mat','data_n_original');