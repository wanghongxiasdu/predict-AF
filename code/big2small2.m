function small=big2small2(A,h,l)
[m,n]=size(A);         %��þ���A��С?
A=im2double(A);
small=zeros(h,l); 
for i=1:h 
    for j=1:l 
        sum=0;
        i1=round((m/h).*(i-1)+1);%������ֿ�
        j1=round((n/l).*(j-1)+1);%i1,j1Ϊ����С�����Ͻ�Ԫ���±�
        i2=round((m/h).*i);
        j2=round((n/l).*j);%i2,j2Ϊ����С�����½�Ԫ���±�????
        for ii=i1:i2
            for jj=j1:j2
                sum=sum+A(ii,jj);%���������Ԫ��ֵ�ĺ�?
            end
        end
        small(i,j)=sum/((i2-i1+1).*(j2-j1+1));%����ֵ����Ŀ�����
    end
end
end