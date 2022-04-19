clear all;clc;
addpath( 'files');
[s, Fs, tm] = rdsamp('files/p49',[1]);
s(230400)=s(230399);
p49=segment(s,Fs);
save('10s\p49.mat','p49');