function [B]=AFSWT(s)          
% s=data(z,:);%sΪ�ź�
          Fs=128;
           N=length(s);
           s=s-mean(s);   %��һ��
           f1=1;
           df=1; %�۲�Ƶ�ʲ��� ���������㽫��Ҫ�۲����ֵ���ȷֳ����ɸ����䣬ÿ������ĳ��Ⱦͽв���
           f2=36*df;
           k1=fix(f1*N/Fs-0.5);
           %k1=0;
           k2=fix(f2*N/Fs-1.5);
           if(k2>N/2+1) 
               k2=N/2+1; 
           end
           fp= fix(k1:df:k2);   %���ɵĹ۲�Ƶ�ʷ�Χ
           nl=length(fp);
           Tn=1280; %% ʱ�򲽳�
           S1=GetAFST(s,Fs,fp,Tn);
           B=sqrt(S1.*conj(S1));
           mx= max(max(B));%ȡ��B������һ��ֵ
           B=fix(B*256/mx); %fix���㷽��ȡ��
%            b = mat2cell(B,repmat(5,1,size(B,1)/5),repmat(2,1,size(B,2)/2));
%            B = cell2mat(cellfun(@(x) mean(mean(x)),b,'UniformOutput',false));