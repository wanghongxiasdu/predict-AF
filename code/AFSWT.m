function [B]=AFSWT(s)          
% s=data(z,:);%s为信号
          Fs=128;
           N=length(s);
           s=s-mean(s);   %归一化
           f1=1;
           df=1; %观测频率步长 步长就是你将需要观测的数值均匀分成若干个区间，每个区间的长度就叫步长
           f2=36*df;
           k1=fix(f1*N/Fs-0.5);
           %k1=0;
           k2=fix(f2*N/Fs-1.5);
           if(k2>N/2+1) 
               k2=N/2+1; 
           end
           fp= fix(k1:df:k2);   %生成的观测频率范围
           nl=length(fp);
           Tn=1280; %% 时域步长
           S1=GetAFST(s,Fs,fp,Tn);
           B=sqrt(S1.*conj(S1));
           mx= max(max(B));%取出B中最大的一个值
           B=fix(B*256/mx); %fix朝零方向取整
%            b = mat2cell(B,repmat(5,1,size(B,1)/5),repmat(2,1,size(B,2)/2));
%            B = cell2mat(cellfun(@(x) mean(mean(x)),b,'UniformOutput',false));