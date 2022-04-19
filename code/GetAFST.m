function [a] = GetAFST(s,Fs,fp,Tn)
%% s:信号
%% Fs:采样率
%% Tn: 时间尺度
%% fp : 频率尺度
N=length(s);  
Krate=Fs/N;
nkk=length(fp);
div=sum(fp==fp(1));
Y=fft(s,N);
Y(1)=0; 
TNN=fix(Tn/2);
u_fp=unique(fp);
mark=fix(Fs/N);
if mark<1
    index=0;
else
    index=fix(fp(1)/mark);
end
nl=length(u_fp);
S1=zeros(Tn,nl);
a=zeros(Tn,nl*div);
Y_abs=abs(Y((fp(1)+1):(fp(end)+1)));
scale=(Y_abs-min(Y_abs))./(max(Y_abs)-min(Y_abs));
rang_s=30;
scale=fix(scale*rang_s);
up_board=N*0.1/6;
down_board=N*0.02/6;
if down_board==0
    down_board=1e6;
end
if up_board==0
    up_board=1e6;
end
if scale(2)/30>0.7
    sc=down_board+0.618*(up_board-down_board)*scale(2)/30;
else
        sc=down_board+(up_board-down_board)*(1-0.618);
end
ad_step=0.02*(up_board-down_board);
for i=1:nl
   filter_input=((1-i-index):(1-i+N-1-index));
   if u_fp(i)==0  S1(:,i)=0; continue;end
    if i>1   && i<nl
        Gradient=scale(i)-scale(i-1);
        sc=sc+sign(Gradient)*ad_step;
    end
  
    if sc>up_board
        sc=up_board;
    end
    if sc<down_board
        sc=down_board;
    end
   val=(filter_input)/(sc);    
    filter=exp(-val.^2/2);                 %FSF    
    FY=filter.*Y;       
    if i<=TNN-index
        FY=[zeros(1,TNN-index-i+1) FY];
    else
        FY=FY(index-TNN+i:end);
    end
    if length(FY)<Tn
        FY(Tn)=0;
    end
    FY(1,fix(Tn/4)+1)=0;
    FY(fix(Tn*3/4)+1:end)=0;
    FY=conj(FY(1:Tn));
    S1(:,i)=fft(FY,Tn);
    
end

for k=1:Tn
    if mod(k-1,2)==1 
        S1(k,:)=-S1(k,:); 
    end
end

for i=1:nl
    index=find(fp==u_fp(i));
    a(:,index)=repmat(S1(:,i),1,length(index)); 
end

a=a(:,1:nkk);




