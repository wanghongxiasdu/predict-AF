function small=big2small2(A,h,l)
[m,n]=size(A);         %获得矩阵A大小?
A=im2double(A);
small=zeros(h,l); 
for i=1:h 
    for j=1:l 
        sum=0;
        i1=round((m/h).*(i-1)+1);%将矩阵分块
        j1=round((n/l).*(j-1)+1);%i1,j1为矩阵小块左上角元素下标
        i2=round((m/h).*i);
        j2=round((n/l).*j);%i2,j2为矩阵小块右下角元素下标????
        for ii=i1:i2
            for jj=j1:j2
                sum=sum+A(ii,jj);%计算矩阵内元素值的和?
            end
        end
        small(i,j)=sum/((i2-i1+1).*(j2-j1+1));%将均值赋给目标矩阵
    end
end
end