function filtered_signal = butterworth_filter(original_signal,order,cutoff_low,cutoff_high,sampling_frequency, figures)
if nargin < 5,
    figures = 0;
end
%���ô�����
W=101;
    ecg1=original_signal;
    %��������
    L=length(ecg1);
    %����ECG�ź�
    for i=1:L+W
     if i>=1&i<=(W+1)/2
         ecg2(i)=ecg1(1);
     else if i>(W+1)/2&i<=L+(W+1)/2
             ecg2(i)=ecg1(i-(W+1)/2);
         else if i>(W+1)/2&i<=L+W-1
              ecg2(i)=ecg1(L);   
             end
         end
     end
    end
    %������ECG�źŽ�����ֵ�˲�
    for i=1:L
        BL(i)=median(ecg2(i:i+W-1));
    end
    %ȥ������Ư��
    for i=1:L
        ecg3(i)=ecg1(i)-BL(i);
    end
    S=ecg3;
filtered_signal =S;
filtered_signal = butterworth_low_pass_filter(filtered_signal,order,cutoff_high,sampling_frequency, false);
filtered_signal = butterworth_high_pass_filter(filtered_signal,order,cutoff_low,sampling_frequency);
if(figures)
    subplot(211);
plot(original_signal);
title('ԭʼ�ź�');
xlabel('�������n');
ylabel('��ֵA');
subplot(212);
plot(filtered_signal);
title('������˹�˲�');
xlabel('�������n');
ylabel('��ֵA');
end